## Tutorial Three - Compile Wasm Policy

Open policy agent allows you to compile your policies into a [WebAssembly binaries](https://en.wikipedia.org/wiki/WebAssembly). The WebAssembly binaries can be run locally via [WebAssembly Runtimes](https://github.com/appcypher/awesome-wasm-runtimes) available for various languages and embeded into your project.

This allows the access control decision to be made locally and might be useful for use cases that require low latency / real time decision reponse.

### Tutorial Task

You are required to write a command line program that:
- load WebAssembly policy binary compiled for policy: [policies/object/document/allow.rego](./policies/object/document/allow.rego)
- read a input.json file in current directory as policy evaluation context data
- Evalute the policy and print out the evaluation result (`true` or `false`)

As WebAssembly is a portable binary code format, you should be able to complete the program in most common languages you choose (e.g. C/C++, C#/.Net, Java/Scala, Python, Javascript, Rust, Go etc.) via [WebAssembly Runtimes](https://github.com/appcypher/awesome-wasm-runtimes) available for your language.


#### To Compile Policy to WASM Binary

You can use `opa` executable to compile your policy:

```bash
opa build "data.object.document.allow == true" -d "../policies/object/document/allow.rego"
```

More usage info:
```bash
opa build --help
```

#### If you choose to complete the task using Javascript (in NodeJs / Web Browser)

NodeJs comes with native WebAssembly API support since verison 8:

```bash
$ node
> WebAssembly.instantiate
[Function: instantiate]
> 
```

More info of the stardard WebAssembly api can be found from [here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/instantiate) or [here](http://webassembly.github.io/spec/js-api/index.html).

There is also a NodeJs package [@open-policy-agent/opa-wasm](https://www.npmjs.com/package/@open-policy-agent/opa-wasm) available. To save some effort, you can use this package instead of talking to policy wasm binaries via WebAssembly api directly.


#### If you choose to complete the task using other languages

You will need to talk to the policy WASM binary directly. Here is the info of the common APIs comes with policy WASM binary.

##### Imports

A WASM module can declare a sequence of imports which are provided, at instantiation time, by the host environment. Opa policy binaries expect you to supply the following imports:

- Linear Memory: 
  - Since WASM function paremeters / return values can only be numbers (INT32, INT64, FLOAT32, FLOAT64), Opa policy binary will use the shared memory you supplied for passing string data.
  - WebAssembly memory are counted in WebAssembly pages. A WebAssembly page has a constant size of 65,536 bytes, i.e., 64KiB.
  - At this moment, opa policy binaries requires imported memory comes with 2 pages initial size (recommend 5) and support at least 60 max pages size.
- Function `opa_abort`: 
  - You can supply a function that will be called when an error occurs when eval your policy.
  - Parameter: address (INT32); the address (index) of error message string in shared memory
  - return value: none

##### Exports

- Function `opa_malloc`
  - You need to call this function to allocate an address to store your non-number parameter in the shared memory.
  - parameter: size (INT32); required storage size.
  - return value: INT32; address of the allocated memory space.
- Function `eval`
  - Evalute the policy
  - parameter: 
    - Address (INT32): input json string address in shared memory. You need to call `opa_malloc` above to allocate an address
    - Length (INT32): input json string length
  - Return value: Boolean; Whether or not the policy is met based on input context data.


### Sample Code

If you can't work it out, you can choose to have a try with the sample code in this repo:
- [NodeJs Sample Code](./tutorial3App/README.md)
- [Sample Code in Scala](./tutorial3-scala/README.md)