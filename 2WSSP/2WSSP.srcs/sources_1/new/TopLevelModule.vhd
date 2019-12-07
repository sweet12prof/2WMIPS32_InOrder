----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2019 08:40:49 AM
-- Design Name: 
-- Module Name: TopLevelModule - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopLevelModule is
  Port (
             clk             : in std_logic;
             reset           : in std_logic;
             writeData1      : out std_logic_vector(7 downto 0);
             writeData2      : out std_logic_vector(7 downto 0);
             dataadr1         : out std_logic_vector(7 downto 0);
             dataadr2         : out std_logic_vector(7 downto 0)
                   
             
        );
end TopLevelModule;

architecture Behavioral of TopLevelModule is
    component WSsPDmem 
          Port ( 
                    Adr1    : in std_logic_vector(31 downto 0); 
                    Adr2    : in std_logic_vector(31 downto 0);
                    WD1     : in std_logic_vector(31 downto 0);
                    WD2     : in std_logic_vector(31 downto 0);
                    RD1     : out std_logic_vector(31 downto 0);
                    RD2     : out std_logic_vector(31 downto 0);
                    WE1     : in std_logic;
                    WE2     : in std_logic;
                    clk     : in std_logic
                );
   end component;
        
   component WSspImem is
              Port ( 
                     Adr : in std_logic_vector(5 downto 0);
                     Rd1 : out std_logic_vector(31 downto 0);
                     Rd2 : out std_logic_vector(31 downto 0)
              );
    end component;
    
    component twoWaySsProcessor 
             Port ( 
                            clk                             : in std_logic;
                            reset                           : in std_logic;
                            
                            pc                              : out std_logic_vector(31 downto 0);
                            instr1                          : in std_logic_vector(31 downto 0);
                            instr2                          : in std_logic_vector(31 downto 0);
                            aluOut1                         : out std_logic_vector(31 downto 0); 
                            aluOut2                         : out std_logic_vector(31 downto 0); 
                            writedata1                      : out std_logic_vector(31 downto 0); 
                            writedata2                      : out std_logic_vector(31 downto 0); 
                            readData1                       : in std_logic_vector(31 downto 0);
                            readData2                       : in std_logic_vector(31 downto 0);
                            memWrite1                       : out std_logic;
                            memWrite2                       : out std_logic
                        
                   );
      end component;
       signal                 aluOut1             : std_logic_vector(31 downto 0);
       signal                 aluOut2             : std_logic_vector(31 downto 0);
       signal                 writedata1sig       : std_logic_vector(31 downto 0);
       signal                 writedata2sig       : std_logic_vector(31 downto 0);
       signal                 readdata1           : std_logic_vector(31 downto 0);
       signal                 readdata2           : std_logic_vector(31 downto 0);
      
       signal                 memwrite1Sig        : std_logic;  
       signal                 memwrite2Sig        : std_logic;
       
       signal PC, instr1, instr2 : std_logic_vector(31 downto 0);
     
     
     
     
        
begin
  Dmem : WSsPDmem Port map ( 
                            Adr1     =>  aluOut1,
                            Adr2     =>  aluOut2,
                            WD1      =>  writedata1Sig,
                            WD2      =>  writedata2Sig,
                            RD1      =>  readdata1,
                            RD2      =>  readdata2,
                              
                            WE1      =>  memwrite1Sig,
                            WE2      =>  memwrite2Sig,
                            clk      => clk
                );
                
                
   Imem : WSspImem Port map ( 
                     Adr   =>  PC(7 downto 2),
                     Rd1   =>  instr1,
                     Rd2   =>  instr2
              );
              
   
    TwoWay_Ssp :  twoWaySsProcessor Port map ( 
                            clk                             =>    clk,
                            reset                           =>    reset,
                                                            
                            pc                              =>    pc,
                            instr1                          =>    instr1,
                            instr2                          =>    instr2,
                            aluOut1                         =>    aluout1,
                            aluOut2                         =>    aluOut2,
                            writedata1                      =>    writedata1Sig,
                            writedata2                      =>    writedata2Sig,
                            readData1                       =>    readdata1,
                            readData2                       =>    readdata2,
                            memWrite1                       =>    memwrite1Sig,
                            memWrite2                       =>    memwrite2Sig
                        
                   );
   

        
        writeData1    <= writedata1Sig(7 downto 0);
        writeData2    <= writedata2Sig(7 downto 0);
        dataadr1      <=  aluout1(7 downto 0);
        dataadr2      <=  aluOut2(7 downto 0);
    
end Behavioral;
