## Tutorial One - Rego Basic

> Given base documents that are available at [data/sampleData](./policies/sampleData): 

### Task 1

- Create a policy that output all possible hostname.
- Access this policy in REPL and verify your result
- Access this policy via HTTP API and verify your result

#### Expect Result:
```json
[
  "hydrogen",
  "helium",
  "lithium",
  "beryllium",
  "boron",
  "carbon",
  "nitrogen",
  "oxygen"
]
```

### Task 2

- Create a policy that output all possible app name & hostname combination.
- Access this policy in REPL and verify your result
- Access this policy via HTTP API and verify your result

#### Expect Result:

```json
[
  [
    "web",
    "hydrogen"
  ],
  [
    "web",
    "helium"
  ],
  [
    "web",
    "beryllium"
  ],
  [
    "web",
    "boron"
  ],
  [
    "web",
    "nitrogen"
  ],
  [
    "mysql",
    "lithium"
  ],
  [
    "mysql",
    "carbon"
  ],
  [
    "mongodb",
    "oxygen"
  ]
]
```

### Task 3

- Create a policy (named `allowExternalAccess`) that:
  - Given input of a hostname
  - the policy return `true` when the hostname is part of production deployment
  - otherwise return `false`
  - e.g. the policy should 
    - return `true` for hostname `hydrogen`
    - return `false` for hostname `beryllium`
- Write test case and run your test cases to  verify your result
- Access this policy via HTTP API, supply different hostnames as `input` in your requests and verify your result


### Task 4

- Create a policy (named `task4`) that return a list of apps that are usually deployed together.
    - Hint: Self Join
- Access this policy in REPL and verify your result
- Access this policy via HTTP API and verify your result

#### Expect Result:

```json
[
  [
    "mysql",
    "web"
  ],
  [
    "mongodb",
    "web"
  ]
]
```