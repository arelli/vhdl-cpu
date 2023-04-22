# vhdl-cpu
This is a simple MIPS-like CPU simulated on VHDL. It includes a complete Arithmetic Logic Unit(ALU), a Register File(RF), an Instruction Fetch(IF) stage, Memory etc. 
It is developed for a class at my university. It has no real life use except teaching the basics of simple CPU. It is made using Xilinx ISE 14.7(on VM or Win10), and not Vivado.
Note that only the VHDL files are provided. The two Single Block memories we were asked to implement using Core-Gen can not be initialized on their own, and need system specific implementation: they keep their setup in a myriad of files I was not able to reveng. Just initialize them from the beginning: Single Block RAM, 1024 depth, 32 width, Read first the MEM, Write First the IMEM(instruction memory), and use the .coe file to initialize them.
![image](https://user-images.githubusercontent.com/19637856/233767520-d60d2ce9-85df-4ccb-b23c-4d9174f8c40d.png)


