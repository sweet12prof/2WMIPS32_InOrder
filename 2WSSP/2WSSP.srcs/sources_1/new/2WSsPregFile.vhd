----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2019 06:44:35 PM
-- Design Name: 
-- Module Name: 2WSsPregFile - Behavioral
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

entity WSsPregFile is
 Port ( 
            clk, W1WE, W2WE : in std_logic;
            W1A1, W1A2, W1WA  : in std_logic_vector(4 downto 0);
            W1RD1, W1RD2  : out std_logic_vector(31 downto 0);
            W1WD  : in std_logic_vector(31 downto 0);
            
            W2A1, W2A2, W2WA : in std_logic_vector(4 downto 0);
            W2RD1, W2RD2 : out std_logic_vector(31 downto 0);
            W2WD  : in std_logic_vector(31 downto 0)
            
 );
end WSsPregFile;

architecture Behavioral of WSsPregFile is
        type ramtype is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);	
		signal mem: ramtype;
begin
    
    sync_Write_Way1 : process(clk)
                         begin
                            if(falling_edge(clk)) then 
                                if(W1WE = '1') then 
                                    MEM(to_integer(unsigned(W1WA))) <= W1WD ;
                                end if;
                                
                                if(W2WE = '1') then 
                                    MEM(to_integer(unsigned(W2WA))) <= W2WD ;
                                end if;                                                              
                            end if;
                         end process;
    
--    sync_Write_Way2 : process(clk)
--                         begin
--                            if(falling_edge(clk)) then                                                            
--                                if(W2WE = '1') then 
--                                    MEM(to_integer(unsigned(W2WA))) <= W2WD ;
--                                end if;
--                            end if;
--                         end process;
                         
                         
     async_READWAY_1 : process(W1A1, W1A2, mem)
                          begin 
                                if(W1A1 = "00000")
                                    then
                                       W1RD1 <=  x"00000000";
                                else 
                                      W1RD1 <= MEM(to_integer(unsigned(W1A1))); 
                                end if;
                                
                                if(W1A2 = "00000")
                                    then 
                                        W1RD2 <=  x"00000000";
                                else 
                                        W1RD2 <= MEM(to_integer(unsigned(W1A2)));
                                end if;
                          end process;     
                          
                          
      async_READWAY_2 : process(W2A1, W2A2, mem)
                          begin 
                                if(W2A1 = "00000")
                                    then
                                       W2RD1 <=  x"00000000";
                                else 
                                      W2RD1 <= MEM(to_integer(unsigned(W2A1))); 
                                end if;
                                
                                if(W2A2 = "00000")
                                    then 
                                        W2RD2 <=  x"00000000";
                                else 
                                        W2RD2 <= MEM(to_integer(unsigned(W2A2)));
                                end if;
                          end process;                                                
    
end Behavioral;
