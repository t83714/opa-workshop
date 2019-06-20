package object.document

test_document_access_class_level_higher_than_1 {
    not allow with input as {
        "user": {
            "name": "Joe Blogger",
            "roles": [{
                "name": "document readers"
            }]
        },
        "document": {
            "ownerName": "Joe Blogger",
            "classificationLevels": 2
        }
    }
}

test_document_access_class_level_equal_1 {
    allow with input as {
        "user": {
            "name": "Joe Blogger",
            "roles": [{
                "name": "document readers"
            }]
        },
        "document": {
            "classificationLevels": 1,
            "ownerName": "Joe Blogger"
        }
    }
}