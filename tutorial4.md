## Tutorial Four - Rego Code Challenge

### Tutorial Task One

You are required to:
- Write a JSON document that represent the organization chart below. 
  - This JSON document will be used by the rego rule that you are required to complete.
  - You can choose any data structure to represent the tree structure in your JSON document. However, the data structure you used should be generic enough to handle a different organization chart.
- Write a Rego Rule that
  - Given an employee name (e.g. `Bert`) via input data `input.employee` from the request context data, return a list of all subordinates. i.e. all employees he supervises. (e.g. `Jane`, `Joe` & `Max`)

```
                        +---------+
                        |  Albert |
                        +----+----+
                             |
          +------------------+--------------+
          |                                 |
      +---+-----+                      +----+----+
      |   Bert  |                      |  Chuck  |
      +----+----+                      +----+----+
           |                                |
    +------+------+           +--------------------------+
    |             |           |             |            |
+---+-----+  +----+----+  +---+-----+  +----+----+  +----+----+
|   Jane  |  |   Joe   |  |  Donna  |  |  Eddie  |  |   Fred  |
+---------+  +----+----+  +---------+  +---------+  +---------+
                  |
             +----+----+
             |   Max   |
             +---------+
```
#### How to verify your result

Suppose your rule name is `getAllSubordinates` and your rule package name is `tutorials.t4`, the following request:
```bash
curl -X POST \
  http://localhost:8181/v1/data/tutorials/t4/getAllSubordinates \
  -H 'Content-Type: application/json' \
  -d '{"input":{"employee": "Bert"}}'
```
should return response:
```json
{"result":["Jane","Joe","Max"]}
```

The following request:
```bash
curl -X POST \
  http://localhost:8181/v1/data/tutorials/t4/getAllSubordinates \
  -H 'Content-Type: application/json' \
  -d '{"input":{"employee": "Chuck"}}'
```
should return response:
```json
{"result":["Donna","Eddie","Fred"]}
```

### Tutorial Task Two

You are required to:

- Write a Rego Rule that
  - Still use the JSON document that created in task one as source data
  - Given two employee names: employee1 & employee2:
    - If employee1 is the superior of employee2, return `superior`
    - If employee1 is the inferior of employee2, return `inferior`
    - If employee1 and employee2 are the same person, return `same`
    - If employee1 and employee2 are unrelated (i.e. there is no path can be found between employee1 and employee2 in the tree), return `unrelated` 

#### How to verify your result

Suppose your rule name is `compare` and your rule package name is `tutorials.t4`, the following request:

```bash
curl -X POST \
  http://localhost:8181/v1/data/tutorials/t4/compare \
  -H 'Content-Type: application/json' \
  -d '{"input":{"employee1":"Bert","employee2":"Max"}}'
```
should return response:
```json
{"result":["superior"]}
```

The following request:
```bash
curl -X POST \
  http://localhost:8181/v1/data/tutorials/t4/compare \
  -H 'Content-Type: application/json' \
  -d '{"input":{"employee1":"Max","employee2":"Bert"}}'
```
should return response:
```json
{"result":["inferior"]}
```

The following request:
```bash
curl -X POST \
  http://localhost:8181/v1/data/tutorials/t4/compare \
  -H 'Content-Type: application/json' \
  -d '{"input":{"employee1":"Max","employee2":"Fred"}}'
```
should return response:
```json
{"result":["unrelated"]}
```

#### Sample Solution

Sample Solution and more info can found from [here](./t4.md)

