package intro.variables
import data.sampleData.sites

q[name] { name := sites[_].name }

# Try to find out the value following: 
# q
# q["dev"]
# q["xxx"]
# sites[i].servers[j].hostname
# sites[_].servers[_].hostname

## What's value of sites[i].servers[i].hostname ?