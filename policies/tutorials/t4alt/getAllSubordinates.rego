package tutorials.t4alt
import data.tutorials.t4alt.orgData

# Direct children
lv0Children[id] { 
    input.employee = orgData[i].name
    id = orgData[i].children[_]
}

# Direct children's children
lv1Children[id]{
    lv0Children[_] = orgData[i].id
    orgData[i].children[_] = id
}

lv2Children[id]{
    lv1Children[_] = orgData[i].id
    orgData[i].children[_] = id
}

lv3Children[id]{
    lv2Children[_] = orgData[i].id
    orgData[i].children[_] = id
}

# the union of the result from all above
allChildren = lv0Children | lv1Children | lv2Children | lv3Children

getAllSubordinates[subordinate] {
    orgData[i].id = allChildren[_]
    subordinate = orgData[i].name
}
