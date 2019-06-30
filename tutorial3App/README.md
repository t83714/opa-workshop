### How to run

#### Install Dependencies

```bash
yarn install
```

#### Compile Policy to WebAssembly binary

```bash
opa build "data.object.document.allow == true" -d "../policies/object/document/allow.rego"
```

OR 
```bash
yarn build-wasm
```

More usage info:
```bash
opa build --help
```

#### Run

```bash
yarn start
```
