package tutorials.t1
import data.sampleData.sites

default task3 = false

task3 {
    input.hostname = sites[i].servers[_].hostname
    sites[i].name = "prod"
}