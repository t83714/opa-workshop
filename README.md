# opa-workshop

Workshop slides: 

https://drive.google.com/file/d/1xNNvnniHgKUpBKj9GMUnTHk0RwRbrSHR

## 1. Installation Open Policy Agent

### MacOS

```bash
cd /usr/local/bin
curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.12.1/opa_darwin_amd64
chmod 755 ./opa
```
OPA is also available on Homebrew but no up to date version.

### Windows

Download from here:

https://github.com/open-policy-agent/opa/releases/download/v0.12.1/opa_windows_amd64.exe

### Linux

Download from here:

https://github.com/open-policy-agent/opa/releases/download/v0.12.1/opa_linux_amd64

## 2. Verify Your Installation

```
# change working directory to cloned workshop repo root 
cd opa-workshop
opa eval data.intro.helloWorld -d ./policies -f values
```
You should see:
```
[
  "Hello World"
]
```
### Make sure you can run the REPL on your machine

```bash
opa run ./policies
```

You will see:

```
OPA 0.10.7 (commit 0f39c27e, built at 2019-04-09T00:29:06Z)

Run 'help' to see a list of commands.

> 
```

You can try out some simple expressions:

```
> true
true
> 3.14
3.14
> ["hello", "world"]
[
  "hello",
  "world"
]
```

You can also test simple boolean expressions:
```
> true == false
false
> 3.14 > 3
true
> "hello" != "goodbye"
true
```

Quit out of the REPL by pressing Control-D or typing exit:
```
> exit
Exiting
```


### Start OPA Server

```bash
opa run ./policies -s
```

To stop the server, press ctrl + c

Test server:
```bash
curl http://localhost:8181/v1/data/intro/helloWorld
```
You should see:
```json
{"result":"Hello World"}
```

## List of Tutorials
- [Self Guide Tutorial One - Rego Basics](./tutorial1.md)
- [Self Guide Tutorial Two - Partial Eval](./tutorial2.md)
- [Self Guide Tutorial Three - WebAssembly Policy](./tutorial3.md)
- [Self Guide Tutorial Four - Rego Code Challenge](./tutorial4.md)

