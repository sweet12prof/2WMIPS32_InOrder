----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2019 02:17:20 PM
-- Design Name: 
-- Module Name: EMpipelineReg - Behavioral
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

entity EMpipelineReg is
 Port ( 
           clk              : in std_logic;
           
           pcPLUS4_8E       : in std_logic_vector(31 downto 0); 
           ALU1outE         : in std_logic_vector(31 downto 0);
           writeData1E      : in std_logic_vector(31 downto 0);
           writeReg1E       : in std_logic_vector(4 downto 0);
           
           ALU2outE         : in std_logic_vector(31 downto 0);
           writeData2E      : in std_logic_vector(31 downto 0);
           writeReg2E       : in std_logic_vector(4 downto 0);
           
           regWrite1E       : in std_logic;
           memtoReg1E       : in std_logic;
           MemWrite1E       : in std_logic;
           jalE             : in std_logic;
           
           regWrite2E       : in std_logic;
           memtoReg2E       : in std_logic;
           MemWrite2E       : in std_logic;
           
           pcPLUS4_8M       : out std_logic_vector(31 downto 0);
           ALU1outM         : out std_logic_vector(31 downto 0);
           writeData1M      : out std_logic_vector(31 downto 0);
           writeReg1M       : out std_logic_vector(4 downto 0);
           
           ALU2outM         : out std_logic_vector(31 downto 0);
           writeData2M      : out std_logic_vector(31 downto 0);
           writeReg2M       : out std_logic_vector(4 downto 0);
           
            regWrite1M  : out std_logic;
            memtoReg1M  : out std_logic;
            MemWrite1M  : out std_logic;
            jalM             : out std_logic;
                     
            regWrite2M  : out std_logic;
            memtoReg2M  : out std_logic;
            MemWrite2M  : out std_logic
            
        );
end EMpipelineReg;

architecture Behavioral of EMpipelineReg is

begin
           process(clk) 
           begin 
                if(rising_edge(clk))
                    then 
                        pcPLUS4_8M   <=    pcPLUS4_8E;
                        ALU1outM     <=    ALU1outE    ;
                        writeData1M  <=    writeData1E ;
                        writeReg1M   <=    writeReg1E  ;
                                                       
                        ALU2outM     <=    ALU2outE    ;
                        writeData2M  <=    writeData2E ;
                        writeReg2M   <=    writeReg2E  ;
                        writeReg2M   <=    writeReg2E  ;
                        writeReg2M   <=    writeReg2E  ;
                        
                        
                        regWrite1M   <=  regWrite1E ;
                        memtoReg1M   <=  memtoReg1E ;
                        MemWrite1M   <=  MemWrite1E ;
                        jalM         <= jalE;
                                   
                        regWrite2M   <=  regWrite2E ;
                        memtoReg2M   <=  memtoReg2E ;
                        MemWrite2M   <=  MemWrite2E ;
                end if;     
           end process;
           

end Behavioral;
