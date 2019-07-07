## Tutorial Four - Rego Code Challenge

### Tutorial Task

You are required to:
- Write a JSON document that represent the organization chart below. 
  - This JSON document will be used as input of the rego rule that you are required to complete.
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

Suppose your rule name is `getAllSubordinates` and your rule package name is `tutorials.t4.orgChart`, the following request:
```bash
curl -X POST \
  http://localhost:8181/v1/data/tutorials/t4/orgChart/getAllSubordinates \
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
  http://localhost:8181/v1/data/tutorials/t4/orgChart/getAllSubordinates \
  -H 'Content-Type: application/json' \
  -d '{"input":{"employee": "Chuck"}}'
```
should return response:
```json
{"result":["Donna","Eddie","Fred"]}
```


#### Sample Solution

Sample Solution and more info can found from [here](./t4.md)

