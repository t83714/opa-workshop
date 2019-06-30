const fs = require("fs");
const chalk = require("chalk");
const Rego = require("@open-policy-agent/opa-wasm");
const input = require("./input.json");

(async () => {
    let policyWasm;
    try {
        policyWasm = fs.readFileSync("./policy.wasm");
    } catch (e) {
        console.log(
            chalk.red(
                "Failed to read the wasm file. \nDid you forget to run `yarn build-wasm` to build the policy WebAssembly binary?"
            )
        );
        throw e;
    }
    const rego = new Rego();
    const policy = await rego.load_policy(policyWasm);
    // --- please note: eval input only accepts JSON string
    const allowed = policy.eval_bool(JSON.stringify(input));
    console.log(
        "The evaluation result is `" +
            chalk.yellow(allowed) +
            "` for the following input: "
    );
    console.log(JSON.stringify(input, null, 2));
})().catch(e => {
    console.log(chalk.red(`Error: ${e}`));
});
