package tutorials.t4
import data.tutorials.t4.orgData

employee1IsHigherLevelLeaderOfEmployee2 {
    input.employee1 = orgData[i].name
    input.employee2 = orgData[j].name
    orgData[j].left > orgData[i].left
    orgData[j].right < orgData[i].right
}

employee2IsHigherLevelLeaderOfEmployee1 {
    input.employee1 = orgData[i].name
    input.employee2 = orgData[j].name
    orgData[i].left > orgData[j].left
    orgData[i].right < orgData[j].right
}

employee1AndEmployee2SamePerson {
    input.employee1 = orgData[i].name
    input.employee2 = orgData[j].name
    i = j
}

compare[result] {
    employee1IsHigherLevelLeaderOfEmployee2
    result = "superior"
}

compare[result] {
    employee2IsHigherLevelLeaderOfEmployee1
    result = "inferior"
}

compare[result] {
    employee1AndEmployee2SamePerson
    result = "same"
}

compare[result] {
    not employee1IsHigherLevelLeaderOfEmployee2
    not employee2IsHigherLevelLeaderOfEmployee1
    not employee1AndEmployee2SamePerson
    result = "unrelated"
}