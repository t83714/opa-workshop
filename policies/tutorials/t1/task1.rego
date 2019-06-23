package tutorials.t1
import data.sampleData.sites

task1[hostname] {
    hostname := sites[_].servers[_].hostname
}