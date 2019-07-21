package tutorials.t4alt
import data.tutorials.t4alt.orgData

lv0Children1[id] { 
    input.employee1 = orgData[i].name
    id = orgData[i].children[_]
}

lv1Children1[id]{
    lv0Children1[_] = orgData[i].id
    orgData[i].children[_] = id
}

lv2Children1[id]{
    lv1Children1[_] = orgData[i].id
    orgData[i].children[_] = id
}

lv3Children1[id]{
    lv2Children1[_] = orgData[i].id
    orgData[i].children[_] = id
}

# get all children Ids for employee 1
allChildren1 = lv0Children1 | lv1Children1 | lv2Children1 | lv3Children1

lv0Children2[id] { 
    input.employee2 = orgData[i].name
    id = orgData[i].children[_]
}

lv1Children2[id]{
    lv0Children2[_] = orgData[i].id
    orgData[i].children[_] = id
}

lv2Children2[id]{
    lv1Children2[_] = orgData[i].id
    orgData[i].children[_] = id
}

lv3Children2[id]{
    lv2Children2[_] = orgData[i].id
    orgData[i].children[_] = id
}

# get all children Ids for employee 2
allChildren2 = lv0Children2 | lv1Children2 | lv2Children2 | lv3Children2

employee1IsHigherLevelLeaderOfEmployee2 {
    input.employee2 = orgData[i].name
    employeeId = orgData[i].id
    allChildren1[_] = employeeId
}

employee2IsHigherLevelLeaderOfEmployee1 {
    input.employee1 = orgData[i].name
    employeeId = orgData[i].id
    allChildren2[_] = employeeId
}

employee1AndEmployee2SamePerson {
    input.employee1 = orgData[i].name
    employee1Id = orgData[i].id
    input.employee2 = orgData[j].name
    employee2Id = orgData[j].id
    employee1Id = employee2Id
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