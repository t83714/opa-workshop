### How to run

#### Prerequisites

You need to the followings to run the scala program:

-   [Java 8 JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) - To run the JVM components, and to build the small amount of Java code.
-   [sbt](http://www.scala-sbt.org/) - To build the Scala components.


#### Compile Policy to WebAssembly binary

```bash
opa build "data.object.document.allow == true" -d "../policies/object/document/allow.rego"
```

More usage info:
```bash
opa build --help
```

#### Run

```bash
sbt run
```

You're expected to see the following output from console:
```
The evaluation result is `true` for the following input: 
{
    "user": {
        "name": "Joe Blogger",
        "roles": [
            {
                "name": "document readers"
            }
        ]
    },
    "document": {
        "classificationLevel": 1,
        "ownerName": "Joe Blogger"
    }
}
```
