## Tutorial Three - Compile Wasm Policy

Open policy agent comes with tools that allow you to compile your policy logic into [WebAssembly binary](https://en.wikipedia.org/wiki/WebAssembly) so that the policy decision can be made locally with OPA instance.

It might be useful for use cases that requires low latency / real time decision reponse.

### Tutorial Task

You are required to write a command line program that:
- load WebAssembly policy binary compiled for policy: [policies/object/document/allow.rego](./policies/object/document/allow.rego)
- read a input.json file in current directory as policy evaluation context data
- Evalute the policy and print out the evaluation result (`true` or `false`)

As WebAssembly is a portable binary code format, you should be able to complete the program in most common languages you choose (e.g. C/C++, C#/.Net, Java/Scala, Javascript etc.). 

#### More info if you choose to complete the task using NodeJs

NodeJs comes with WebAssembly API support since verison 8:

```bash
$ node
> WebAssembly.instantiate
[Function: instantiate]
> 
```

Details of WebAssembly api can be found from [here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/instantiate) or [here](http://webassembly.github.io/spec/js-api/index.html).

There is also a NodeJs package [@open-policy-agent/opa-wasm](https://www.npmjs.com/package/@open-policy-agent/opa-wasm) available. To save some effort, you can use this package instead of talking to policy wasm via WebAssembly api directly.

