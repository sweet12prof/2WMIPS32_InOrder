----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2019 02:39:21 PM
-- Design Name: 
-- Module Name: MWBpipelineReg - Behavioral
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

entity MWBpipelineReg is
  Port ( 
            clk                      : in std_logic; 
--            asyncreset               : in std_logic;
            
            readData1M           : in std_logic_vector(31 downto 0);
            ALUout1M             : in std_logic_vector(31 downto 0);
            
            readData2M           : in std_logic_vector(31 downto 0);
            ALUout2M             : in std_logic_vector(31 downto 0);
            
            regWrite1M           : in std_logic;  
            memtoReg1M           : in std_logic; 
            writeReg1M          : in std_logic_vector(4 downto 0); 
                                                 
            regWrite2M           : in std_logic;  
            memtoReg2M           : in std_logic;
            writeReg2M          : in std_logic_vector(4 downto 0);   
                       
            readData1WB           : out std_logic_vector(31 downto 0);
            ALUout1WB             : out std_logic_vector(31 downto 0);
            
            readData2WB           : out std_logic_vector(31 downto 0);
            ALUout2WB             : out std_logic_vector(31 downto 0); 
            
            regWrite1WB           : out std_logic;
            memtoReg1WB           : out std_logic;
            writeReg1WB          : OUT std_logic_vector(4 downto 0); 
                                                
            regWrite2WB           : out std_logic;
            memtoReg2WB           : out std_logic;
            writeReg2WB          : OUT std_logic_vector(4 downto 0)
                        
                    );
end MWBpipelineReg;

architecture Behavioral of MWBpipelineReg is
begin
    process (clk)
        begin                
           if(rising_edge(clk)) then 
            
                  readData1WB    <=  readData1M; 
                  ALUout1WB      <=  ALUout1M ;  
                                               
                  readData2WB    <=  readData2M ;
                  ALUout2WB      <=  ALUout2M  ; 
                  ALUout2WB      <=  ALUout2M ;
                  
                  regWrite1WB   <=  regWrite1M ;
                  memtoReg1WB   <=  memtoReg1M ;
                  writeReg1WB   <= writeReg1M;
                                               
                  regWrite2WB   <=  regWrite2M ; 
                  memtoReg2WB   <=  memtoReg2M ;
                  writeReg2WB   <= writeReg2M;
            end if;
       end process;

end Behavioral;
