# Synthesizable Radix-1 Divider using Recurrance for Integer Division

This repository includes the System Verilog files for a variable bit,
synthesizable, radix-1 divider module for integer division.

## Directory Structure
    * `src/` : Module source files
    * `tb/`  : Testbench
    * `do/`  : DO file

## Simulating
The flow used in the Makefile uses Siemens (was Mentor Graphics)
ModelSim to run the simulation enviornment. If you want to use another
simulation enviornment then modifications would need to be made to the Makefile.
To simulate using ModelSim, just run:

```
make
```


Currently, the DO file has **A LOT** of waves added to it, most of which aren't
that important, but are useful for debugging. Feel free to remove any if it's
to cluttered inside ModelSim.


## The Division Algorithm
The quotient, $q$, is obtained by first setting the partial remainder $w$ and
$q$ to 0. Following are the operations to calculate 1 bit of the quotient, which
are then repeated N times for an N-bit dividen $x$ and divisor $d$. 
    1. Shift the MSB of $q$ into $w$. 
    2. Subtract $d$ from $w$
    3. If $w-d < 0$, 0 is set in the LSB of $q$ and the value of $w$ is
       restored to before the subtraction. If $w-d > 0$, 1 is set in the LSB of
       $q$ and $w$ is not restored.

The operations repeats N times, with $q$ being the final quotient and $w$ being
the final remainder.


