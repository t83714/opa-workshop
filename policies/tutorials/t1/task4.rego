package tutorials.t1
import data.sampleData.sites
import data.sampleData.apps

task4[{appName1, appName2}] {
    appName1 := apps[i].name
    appName2 := apps[k].name
    server := apps[i].servers[_]
    server == sites[j].servers[_].name
    other_server := sites[j].servers[_].name
    server != other_server
    other_server == apps[k].servers[_]
    appName1 != appName2
}