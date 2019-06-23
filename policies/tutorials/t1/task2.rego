package tutorials.t1
import data.sampleData.sites
import data.sampleData.apps

task2[[appName, hostname]] {
    appName := apps[i].name
    server := apps[i].servers[_]
    sites[j].servers[k].name == server
    hostname := sites[j].servers[k].hostname
}