# 2WMIPS32
## General Info
Design of a 2-Way scalar 5-stage pieline processor based on a subset(15 instructions) of the MIPS instruction set.

## Behavior
* The processor implements instruction level parallelism by employing both pipelinning and superscalar techniques.
* It is an **IN-ORDER,** 2-issue(Way), 5-stage, super-pipelined 32-bit dynamically scheduled MIPS based processor.
* Dynamic scheduling is based on scoreboarding techniques
* With the help of an instruction scheduler, the processor executes a pair of instructions in program order when 
  there are no data or output dependences between them.
* For an ideal case, where all pair of instructions, from the top of the instruction memory, are not dependent on   
  the other, the CPU records a CPI < 1, an IPC > 1 and also twice the throughput of a single scalar pipeline 
  design.
* In the case of a data dependency, the sceond instruction in the pair shuffled out and replaced by a nop,
  and the pc set to point to the swapped instruction.
* In the worst case scenario, where all pairs are dependent, the processor acts as a single-scalar pipeline.
* The design compels the ff instructions(Beq, J, Jal and Jr) to be executed on the 1st path(Way).The 
  instruction scheduler makes sure of this by ensuring ;
    * In the case of no data dependency between these instructions and other instruction types                                      
        (forming an execution pair), the Beq, J, Jal or Jr make use of the first path whilst the other instruction
         takes the second execution slot. 
    * In the case of a data dependency whilst Beq, J, Jal or Jr holds the second slot, they are shuffled out with
        a nop.

## Instruction Set

|  Instruction |  Operation  | OpCode |
|--------------| ------------| -----------|
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

## Testing 
  * The program in the instruction memory, consists of a MIPS program translated into hex.
  * The program is an implementation of the "ADD-SHIFT" multiplication Algorithm to multiply 2 numbers
  * The numbers in the particular program are 40 and 5, hence a result of 200 is expected at the end of the program 
  * The program exits execution by saving the result into memory Location 100
 
    
    
  
  
  
     
     
