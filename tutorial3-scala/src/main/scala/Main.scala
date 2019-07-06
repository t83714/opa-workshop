import swam.runtime._
import swam.runtime.formats.DefaultFormatters._
import swam.runtime.imports._
import cats.effect._
import java.nio.file.Paths
import java.nio._

import swam.{Limits, MemType}

import scala.io.Source

object Main extends App {

  val engine = Engine[IO]

  // --- ByteBuffer used as shared memory that imported into wasm module during initialization
  val buffer = ByteBuffer.allocate(100 * pageSize)
  // --- initial memory size; Opa currently requires at least 2 pages
  buffer.limit(5 * pageSize)

  // --- passing a function to opa wasm module for reporting any errors
  def opa_abort(addr: Int): IO[Unit] = IO {
    throw new Error(readStringFromBuffer(buffer)(addr))
  }

  // --- read a string from shared memory using address / index
  def readStringFromBuffer(buffer: ByteBuffer)(addr: Int): String = {
    var i = 0
    var s = ""
    buffer.flip()
    while (buffer.getInt(addr + i) != 0) {
      s += buffer.getChar(addr + i)
      i += 1
    }
    s
  }

  // --- write a string to the shared memory at opa wasm module allocated address
  def writeStringToBuffer(buffer: ByteBuffer)(addr: Int, str: String): Unit = {
    buffer.clear()
    buffer.position(addr)
    buffer.put(str.getBytes)
  }

  // --- eval policy
  def eval_bool(i: Instance[IO])(input: String): IO[Boolean] = {
    // --- call exported wasm policy function `opa_malloc`
    // --- to allocate memory for input string parameter
    i.exports
      .function("opa_malloc")
      .flatMap { f =>
        f.invoke(Vector(Value.Int32(input.length)), None).map {
          case Some(Value.Int32(addr)) =>
            writeStringToBuffer(buffer)(addr, input)
            addr
          case _ => throw new Error("Failed to malloc memory")
        }
      }
      .flatMap { addr =>
        // --- call exported `eval` wasm module function
        i.exports.function("eval").flatMap { f =>
          f.invoke(Vector(Value.Int32(addr), Value.Int32(input.length)), None)
            .map {
              case Some(Value.Int32(code)) =>
                if (code == 0) false else true
              case _ => throw new Error("Failed to eval policy")
            }
        }
      }
  }

  type AsIIO[T] = AsInterface[T, IO]
  type AsIsIO[T] = AsInstance[T, IO]

  // --- functions & memory that are imported into wasm module during initialization
  val imports = Imports[IO](
    TCMap[String, AsIsIO](
      "env" -> TCMap[String, AsIIO](
        "memory" -> buffer,
        "opa_abort" -> opa_abort _
      )))

  // --- Init wasm policy module and Eval policy
  def run() = {

    // --- load input json
    val jsonInput: String = io.Source.fromFile("./input.json").mkString

    // --- Load & initial wasm policy module
    val module = engine.flatMap(_.compile(Paths.get("./policy.wasm")))
    val instance = module
      .flatMap { m =>
        m.importing(imports).instantiate
      }
      .unsafeRunSync()

    val result = eval_bool(instance)(jsonInput).unsafeRunSync()

    println(
      s"""The evaluation result is `${result}` for the following input: """)
    println(jsonInput)
  }

  run()

}
