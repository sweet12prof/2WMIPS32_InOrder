----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2019 05:31:35 PM
-- Design Name: 
-- Module Name: 2WSspImem - Behavioral
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

entity WSspImem is
  Port ( 
         Adr : in std_logic_vector(5 downto 0);
         Rd1 : out std_logic_vector(31 downto 0);
         Rd2 : out std_logic_vector(31 downto 0)
  );
end WSspImem;

architecture Behavioral of WSspImem is
        type mem_array is array (0 to 64) of 
                std_logic_vector(31 downto 0);
        
        signal MEM : mem_array := (
                                        x"20040028",
                                        x"20050005",
                                        x"200b0000",
                                        x"20060020",
                                        x"20070001",
                                        x"20080001",
                                        x"200a0000",
                                        x"20090000",
                                        x"00a84824",
                                        x"20e70001",
                                        x"112a0001",
                                        x"008b5820",
                                        x"00052842",
                                        x"00042040",
                                        x"10e60002",
                                        x"0c000c08",
                                        x"08000c12",
                                        x"03e00008",
                                        x"ac0b0064",
                                        x"ffffffff",
                                        others => x"00000000"
                                    );
begin 
    async_Read : process(Adr)               
                begin
                     Rd1 <= MEM(to_integer(unsigned(Adr)));
                     Rd2 <= MEM(to_integer(unsigned(Adr) + 1));
    end process;  
end Behavioral;
