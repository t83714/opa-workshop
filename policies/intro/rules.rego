package intro.rules
import data.sampleData.sites

# rule value: 123
t11 = 123

# rule value: 123
t12 = 123 { true}

# rule value: true
t13 { true } 

# rule value: undefined (Not matched)
t14 { false } 

# Default rule:
# Defines rule value when all rule definition are eval to undefined
default t15 = true
t15 { false } 
# rule t15 value is `true`

# Define Variable / Head Terms:

q1[name] { name = sites[_].name }
# or q1[name] { name = sites[i].name }