----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2019 02:10:08 PM
-- Design Name: 
-- Module Name: 2WSspInstrScheduler - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WSspInstrScheduler is
Port (
           Instr1, Instr2 : in std_logic_vector(31 downto 0);
           EX_Instr1, EX_Instr2 : out std_logic_vector(31 downto 0);
           prePCAdderMux : out std_logic
       );
end WSspInstrScheduler;

architecture Behavioral of WSspInstrScheduler is
    signal opCode1, opCode2, funct1, funct2 : std_logic_vector(5 downto 0);
    signal rs1, rs2, rt1, rt2, rd1, rd2 : std_logic_vector(4 downto 0);
    constant Beq      : std_logic_vector(5 downto 0) :=  "000100";
    constant J        : std_logic_vector(5 downto 0) :=  "000010";
    constant Jal      : std_logic_vector(5 downto 0) :=  "000011";
    constant JrFunct  : std_logic_vector(5 downto 0) :=  "001000";
    constant RType    : std_logic_vector(5 downto 0) :=  "000000";
    constant addi     : std_logic_vector(5 downto 0) :=  "001000";
    constant lw       : std_logic_vector(5 downto 0) :=  "100011";
    constant sw       : std_logic_vector(5 downto 0) :=  "101011";
    constant haltCPU  : std_logic_vector(5 downto 0) :=  "111111";
begin
       opCode1 <= Instr1(31 downto 26);
       opCode2 <= Instr2(31 downto 26);
       
       funct1 <= Instr1(5 downto 0);
       funct2 <= Instr2(5 downto 0);
       
       rs1 <= instr1(25 downto 21);
       rs2 <= instr2(25 downto 21);
       
       rt1 <= instr1(20 downto 16);
       rt2 <= instr2(20 downto 16);
       
       rd1 <= instr1(15 downto 11);
       rd2 <= instr2(15 downto 11);
       
     
       CheckForJumpsAndBranchsInWAY1 : process(opCode1, opCode2, rt1, rt2, rs1, rs2, rd1, rd2, funct1, funct2, instr1, instr2)
                 begin 
                if( ((opCode1 = Beq) or (opCode1 = J) or  (opCode1 = Jal) or (opCode1 = haltCPU)) 
                                    or ((opCode1 = RType) and (funct1 = JrFunct))) then 
                    EX_Instr1 <= Instr1;    
                    EX_Instr2 <= x"00000000";
                    prePCAdderMux <= '1';
               else 
                    if (   ((opCode2 = Beq) and (rs2 /= rs1) and (rs2 /= rt1) and (rt2 /= rs1 ) and (rt2 /= rt1)) or (opCode2 = J)  or  (opCode2 = Jal) 
                                    or (((opCode2 = RType) and (funct2 = JrFunct)) and (rs2 /= rs1) and (rs2 /= rt1) and (rs2 /= rd1)  )  ) then               
                            EX_Instr1 <= Instr2;    
                             EX_Instr2 <=  Instr1;
                            prePCAdderMux <= '0'; 
                       elsif( opCode2 = haltCPU)
                            then 
                            EX_Instr1 <= Instr1;     
                            EX_Instr2 <= x"00000000";
                            prePCAdderMux <= '1';    
                                                                            
                        elsif((opCode1 = Rtype) and (opCode2 = RType) and (Rd1 /= rs2) and (Rd1 /= rt2) and (rd1 /= rd2))
                            then
                                EX_Instr1 <= Instr1;    
                                EX_Instr2 <=  Instr2;
                                 prePCAdderMux <= '0';
                        elsif( (opCode1 = RType) and ((opCode2 = addi) or (opCode2 = lw) or (opCode2 = sw)) and (rd1 /= rt2) and (rd1 /= rs2)) 
                            then 
                                EX_Instr1 <= Instr1;    
                                EX_Instr2 <=  Instr2;
                                prePCAdderMux <= '0';
                        elsif ( ((opCode1 = addi) or (opCode1 = lw)) and (opCode2 = RType) and (rt1 /= rd2) and (rt1 /= rs2) and (rt1 /= rt2) )
                            then 
                                EX_Instr1 <= Instr1;    
                                EX_Instr2 <=  Instr2;
                                prePCAdderMux <= '0';
                        elsif( ((opCode1 = addi) or (opCode1 = lw)) and ((opCode2 = addi) or (opCode2 = lw)) and (rt1 /= rt2) and (rt1 /= rs2) ) then 
                                EX_Instr1 <= Instr1;    
                                EX_Instr2 <=  Instr2;
                                prePCAdderMux <= '0';
                        elsif( ((opCode1 = addi) or (opCode1 = lw)) and (opCode2 = sw) and (rt1 /= rt2) and (rt1 /= rs2) )
                            then 
                                EX_Instr1 <= Instr1;    
                                EX_Instr2 <=  Instr2;
                                prePCAdderMux <= '0';
                        elsif((opCode1 = sw) and (opCode2 = sw) and (rt1 /= rt2))
                            then 
                                EX_Instr1 <= Instr1;    
                                EX_Instr2 <=  Instr2; 
                                prePCAdderMux <= '0';
                        elsif((opCode1 = sw) and (opCode2 /= sw))
                            then
                                EX_Instr1 <= Instr1;    
                                EX_Instr2 <=  Instr2; 
                                prePCAdderMux <= '0';
                        else
                                EX_Instr1 <= Instr1;    
                                EX_Instr2 <= x"00000000";   
                                prePCAdderMux <= '1';              
                    end if;
                           
                end if;
            end process;               
end Behavioral;
