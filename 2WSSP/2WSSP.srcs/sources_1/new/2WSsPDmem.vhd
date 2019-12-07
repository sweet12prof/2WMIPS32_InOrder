----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2019 05:50:32 PM
-- Design Name: 
-- Module Name: 2WSsPDmem - Behavioral
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

entity WSsPDmem is
  Port ( 
            Adr1, Adr2: in std_logic_vector(31 downto 0);
            WD1, WD2 : in std_logic_vector(31 downto 0);
            RD1, RD2: out std_logic_vector(31 downto 0);
            WE1, WE2, clk : in std_logic
        );
end WSsPDmem;

architecture Behavioral of WSsPDmem is
    type mem_array is array(63 downto 0) of
                std_logic_vector(31 downto 0);
    
    signal MEM : mem_array; 
begin
    process(clk)
        begin
            if(rising_edge(clk)) then 
                if(WE1 = '1') then
                    MEM(to_integer(unsigned(Adr1(7 downto 2)))) <= WD1;
                 end if;
                if( WE2 = '1') then  
                    MEM(to_integer(unsigned(Adr2(7 downto 2)))) <= WD2;
                end if;
            end if;   
    end process; 
    
        RD1 <= MEM(to_integer(unsigned(Adr1(7 downto 2))));
        RD2 <= MEM(to_integer(unsigned(Adr2(7 downto 2))));

end Behavioral;
