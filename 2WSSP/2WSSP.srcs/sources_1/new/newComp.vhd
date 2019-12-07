----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2019 05:57:57 PM
-- Design Name: 
-- Module Name: newComp - Behavioral
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

entity newComp is
  Port ( 
            input1 : in std_logic_vector(31 downto 0);
            input2 : in std_logic_vector(31 downto 0);
            Output : out std_logic
  );
end newComp;

architecture Behavioral of newComp is
   signal andRes : std_logic_vector(31 downto 0);
begin
            andRes <= input1 xor input2;
            
            process(andRes)
                begin 
                    Output <= '0';
                     
                     if(andRes = x"00000000")
                            then 
                                Output <= '1';
                     else 
                                Output <= '0';
                     end if;
                end process;
             
 
end Behavioral;
