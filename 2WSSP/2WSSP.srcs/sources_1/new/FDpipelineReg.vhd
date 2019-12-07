----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2019 12:46:23 PM
-- Design Name: 
-- Module Name: FDpipelineReg - Behavioral
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

entity FDpipelineReg is
  Port ( 
            clk             : in std_logic;
            
            syncReset       : in std_logic;
            stallD          : in std_logic;
            
            instr1F         : in std_logic_vector(31 downto 0);
            instr2F         : in std_logic_vector(31 downto 0);
            PCplus4_8F      : in std_logic_vector(31 downto 0);
            
            instr1D         : out std_logic_vector(31 downto 0);
            instr2D         : out std_logic_vector(31 downto 0);
            PCplus4_8D      : out std_logic_vector(31 downto 0)                       
        );
end FDpipelineReg;

architecture Behavioral of FDpipelineReg is
begin
Sync_Read_SyncandAsync_Reset : process(clk)
        begin 
           
                 
              if( rising_edge(clk)) then
                      if(syncReset = '1') then 
                           instr1D         <= (others => '0'); 
                           instr2D         <= (others => '0');
                           PCplus4_8D      <= (others => '0');
                      else
                           if(stallD = '0')  
                                then 
                                    instr1D         <= instr1F; 
                                    instr2D         <= instr2F;
                                    PCplus4_8D      <= PCplus4_8F;
                           end if;
                      end if; 
               end if;
                             
                                   
                            
         
end process;

end Behavioral;
