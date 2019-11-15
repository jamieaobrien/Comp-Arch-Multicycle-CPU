# CompArch Lab 3: Single Cycle CPU

The goal of this lab is to design, create, and test a 32-bit single cycle CPU.

## To Run ##

We have dumped the instruction text for our assembly tests manually an included them in the `asmtest` folder.

To choose which test you would like to run, please change the line `cpu.t.v` file in the line `$readmemh("asmtest/test2.text", cpu.memory.mem,0);` to incorporate the test you would like to run.

In the command line, run:

`$ iverilog -Wall -I ALU/ -o cpu.vvp cpu.t.v`

`$ ./cpu.vvp`

`$ gtkwave cpu.vcd`





