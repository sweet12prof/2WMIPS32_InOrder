# 2WMIPS32
## General Info
Design of a 2-Way scalar, 5-stage pieline, **IN-ORDER** processor based on a subset(15 instructions) of the MIPS instruction set.

## Behavior(Elaborate explanations in presentation files)
* The processor implements instruction level parallelism by employing both pipelinning and superscalar techniques.
* It is an **IN-ORDER,** 2-issue(Way), 5-stage, super-pipelined 32-bit dynamically scheduled MIPS based processor.
* It is Dynamic scheduled which implies the scheduler is implemented in hardware. 
* With the help of an instruction scheduler, the processor executes a pair of instructions in program order when 
  there are no data or output dependences between them.
* For an ideal case, where all pair of instructions, from the top of the instruction memory, are not dependent on   
  the other, the CPU records a CPI = 1, an IPC > 1 and also twice the throughput of a single scalar pipeline 
  design.
* In the case of a data dependency, the sceond instruction in the pair shuffled out and replaced by a nop,
  and the pc set to point to the swapped instruction.
* In the worst case scenario, where all pairs are dependent, the processor acts as a single-scalar pipeline.
* The design compels the ff instructions(Beq, J, Jal and Jr) to be executed on the 1st path(Way).The 
  instruction scheduler makes sure of this. 
* You can find out how it does this by checking out the presentation files or checking out the instruction 
  scheduler project. 
 

## Instruction Set
* Instructions are a subset of the MIPS32 ISA 
* Architecture of these instructions in exception of the halt instruction are adopted from that ISA
* To halt the CPU simply use the instruction x"F-------"('-' refer to dont cares)
* No way to put the processor back into operation yet

|  Instruction |  Operation  | 
|--------------| ------------| 
|  add      |  addition |
| sub      |  subtraction |
|  and      |  bitwise AND |
|   or      |   bitwise OR |
|   xor      |  bitwise XOR |
|   sll      |  Shift Left Logical |
|   srl      |  Shift right Logical |
|   slt      |  Shift Left Logical |
|  addi     | add imeddiate |
|   lw        | Load word |
|   sw        | store word |
|   beq       | branch on equal |
|   J         | Jump |
|   Jal       | Jump and Link |
|  Jr |   Jump register |
|Halt| Halt CPU 

## Design Methodolgy
 * Schematic created for design is included in project directory.
 * VHDL used to describe design in vivado webpack
 * Design is based on the havard archiutecture( Working on a Von Neumann Equivalent )
 * Design contains the ff architectural state elements sufficient for an instruction pair
     * register File with 4 read ports and 2 write ports.
     * Instruction memory(Imem), issues 2 instructions based on address
     * Data Mem (Dmem) holds data, implemented as a simple Dual port ram
     * Instruction Scheduler, determines if execution pair are a valid pair for execution. 
     * Control Unit
     * Hazard Detection and Resolution Unit
     * Pair of ALU

## Testing/Simulation(Pre- Synthesis)
  * Open the xise project File, or add the vhd files to your new project.
  * The program in the instruction memory(Imem.vhd), consists of a MIPS program translated into hex.
  * The program is an implementation of the "ADD-SHIFT" multiplication Algorithm to multiply 2 numbers
  * The numbers in the particular program are 40 and 5, hence a result of 200 is expected at the end of the program 
  * The program exits execution by saving the result into memory Location 100
  * A simple run of the testbench file reveals this. 
  * To run a different program with the tesbench, do as follows : 
      * Write a mips program based on the implemented subset
      * Assemble it and generate a hex file 
      * Edit the Imem file 
      * Edit tesbench according to the outputs expected by your program
      * Run and compare results
      
 ## Synthesis For FPGA
  * The registerFile used in the design couldn't be synthesised using block RAMS
  * This forces usage of registers by the synthesiser and utilizes a lot of resources
  * The design synthesises successfully for a basys 3 artix 7 FPGA, this can be used for a standard if you intend to 
    synthesise for an fpga
  * Don't synthesise the tesbench won't work
  * The top module is what you're looking for, as for I/O, The unbounded Outputs include memory Address and data ports 
    this can be changed by editing all the way from the datapath file through to the top level module 
  
   
  
  
 
    
    
  
  
  
     
     
