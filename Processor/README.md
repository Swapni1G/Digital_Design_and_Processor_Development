This repository contains the Verilog code, simulation results and demonstration videos for synthesis of a pipelined processor on FPGA.
A 5-stage pipelined processor, implementing RISC (Reduced Instruction Set Computer) architecture has been developed.
For FPGA synthesis video, kindly refer to:
https://drive.google.com/file/d/1xLEbVj8tgnbiUMWfR86hAAiCJwD7aEKM/view?usp=sharing
(note: output is diplayed in hexadecimal format)

The computations performed are as follows:
Register R1 <= 10
Register R2 <= 20
Register R3 <= 25
Register R4 <= R1+R2  // 1e in hex.
Register R5 <= R4+R3  // 37 in hex.


During simulation, it takes approximately 10 clock cycles for the value of R5 to be updated due to pipeline latency.
In synthesis (using 1Hz clock), this translates to around 10 seconds of real-time delay before the final output is visible on the 7-segment display.
This confirms both the logical correctness and timing behavior of the pipelined design.
