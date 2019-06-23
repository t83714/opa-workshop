package tutorials.t1

test_host_hydrogen {
    task3 with input as {
        "hostname" : "hydrogen"
    }
}

test_host_helium {
    task3 with input as {
        "hostname" : "helium"
    }
}

test_host_lithium {
    task3 with input as {
        "hostname" : "lithium"
    }
}

test_host_beryllium {
    not task3 with input as {
        "hostname" : "beryllium"
    }
}