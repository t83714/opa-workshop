package intro.incremental

ti[x] { x=1 }
ti[x] { x=2 }
ti[x] { 
    x = 3 
    false
}

ti2 { false }
default ti2 = false
ti2 { ti[3] = 3} 
ti2 { ti[2] = 2}
## Or ti2 = true { ti[2] = 2}
## Or ti2 { ti[2] }
## Or ti2 { ti[1] = 1; ti[2] = 2 }


