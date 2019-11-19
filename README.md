# CompArch Lab 4: Multi-Cycle CPU

The goal of this lab is to design, create, and test a 32-bit multi-cycle CPU.

## To Run ##

We have dumped the instruction text for our assembly tests manually an included them in the `asmtest` folder.

To choose which test you would like to run, please change the line `cpu.t.v` file in the line `$readmemh("asmtest/branch.text", cpu.memory.mem,0);` to incorporate the test you would like to run. Other tests are `arithmetic_memory.text`,`jump.text`, and `slt_xori.text`.

In the command line, run:

`$ iverilog -o cpu.vvp cpu.t.v`

`$ ./cpu.vvp`

`$ gtkwave cpu.vcd`
