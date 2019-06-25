## Tutorial Two - Partial Eval

You are provided [sample code](./tutorial2App) for data filter in both PostgreSQL Database & Elasticsearch.

You can run the provided test cases to obverse the sample code behaviour and set breakpoints to intercept the communications between OPA and different services to understand more how partial eval works.

You are also provided a set of new requirements that require you to modify the current policy logic and observe how the existing data filtering code still works with new policy logic without adjustments.


### Prerequisite Installation

To run the demo program in this tutorial, you need to install the following:

- Docker Desktop: 
  - You can download and install from:
    - https://www.docker.com/products/docker-desktop
  - Used to run PostgreSQL Database & Elasticsearch instance via docker images
- NodeJs & NPM: 
  - Demo program is written in typescript
  - You can download and install from:
    - https://nodejs.org/en/
- Yarn:
  - https://yarnpkg.com/en/
- VSCode:
  - https://code.visualstudio.com/download 
  - You will need vscode to debug provided test cases using [provided launch configurations](./.vscode/launch.json).


### Install NPM package

```bash
cd tutorial2App
yarn install
```

### Start / Stop Service

#### Start / Stop PostgreSQL Database

Start database:

```bash
cd tutorial2App
yarn start-db
```

The initial starting up may take some time as docker needs to download image from docker hub.

Stop database:

```bash
cd tutorial2App
yarn stop-db
```

#### Start / Stop Elasticsearch

Start Elasticsearch:

```bash
cd tutorial2App
yarn start-es
```

The initial starting up may take some time as docker needs to download image from docker hub.

You can use the following command to check if the elasticsearch has finished the starting up:

```bash
curl localhost:9200/_cat/health
```

Or use [Postman](https://www.getpostman.com/) to send a `GET` request to: http://localhost:9200/_cat/health

Stop Elasticsearch:

```bash
cd tutorial2App
yarn stop-es
```

####  Start / Stop Open Policy Agent

You need to make sure OPA excutable is available from command line path in order to run the following script.

Start OPA:

```bash
cd tutorial2App
yarn start-opa
```

Stop OPA:

Press Ctrl + C

#### Debug Test Cases using VSCode

You can use the preset vscode launch configuration `Mocha Debug Current File` to debug the current opened test case source code file and set break points.

![vscode](https://raw.githubusercontent.com/t83714/opa-workshop/master/vscode.png)

### Tutorial Task 1

Read the opa policy [policies/object/document/allow.rego](./policies/object/document/allow.rego) and understand the policy logic. 

Understand [getUserDocumentsFromDB.ts](./tutorial2App/getUserDocumentsFromDB.ts) functionality via test case [getUserDocumentsFromDB.spec.ts](./tutorial2App/test/getUserDocumentsFromDB.spec.ts):

- Start OPA Service
- Start PostgreSQL Database
- Run test case using vscode debugger to 
  - Understand `getUserDocumentsFromDB.ts` functionality and observe the OPA partial eval request / response.
  - Check the demo database structure & demo data
    - The demo db will be auto re-created before first test case run
  - Observe how SQL statement is generated from partial eval AST (Abstract Syntax Tree)

### Tutorial Task 2

Read the opa policy [policies/object/document/allow.rego](./policies/object/document/allow.rego) and understand the policy logic.

Understand [getUserDocumentsFromES.ts](./tutorial2App/getUserDocumentsFromES.ts) functionality via test case [getUserDocumentsFromES.spec.ts](./tutorial2App/test/getUserDocumentsFromES.spec.ts):

- Start OPA Service
- Start PostgreSQL Database
- Start Elasticsearch Database
- Run test case using vscode debugger to 
  - Understand `getUserDocumentsFromES.ts` functionality and observe the OPA partial eval request / response.
  - Check the demo database structure & demo data
    - The demo db will be auto re-created before first test case run
  - Check the demo data in elasticsearch
    - The demo data will be auto re-created before first test case run
  - Observe how Elasticsearch DSL query is generated from partial eval AST (Abstract Syntax Tree)

### Tutorial Task 3

- Modify the policy [policies/object/document/allow.rego](./policies/object/document/allow.rego) to meet the following new requirements:
    - The `accessLevel` column specifies user's access level
        - `-1` undefined access level
        - If a user's access level is defined (i.e. not `-1`)
        - User can't access documents of which `classificationLevel` is higher than the user's `accessLevel`
    - Users who have `admin` role can access any documents unless it's not permited due to `accessLevel` rule above
    - Users who have `document power readers` role can access any documents of which `classificationLevel` is no higher than `9`, unless it's not permited due to `accessLevel` rule above
    - Users who have `document readers` role can access any documents of which `classificationLevel` is no higher than `3` and `owner` is the current user, unless it's not permited due to `accessLevel` rule above

- Modify test cases ([getUserDocumentsFromDB.spec.ts](./tutorial2App/test/getUserDocumentsFromDB.spec.ts) & [getUserDocumentsFromES.spec.ts](./tutorial2App/test/getUserDocumentsFromES.spec.ts)) to verify the policy logic works as described above.