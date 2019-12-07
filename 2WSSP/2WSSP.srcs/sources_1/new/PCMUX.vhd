----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2019 08:57:07 AM
-- Design Name: 
-- Module Name: PCMUX - Behavioral
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

entity PCMUX is
  Port ( 
            i1 : in std_logic_vector(31 downto 0);
            i2 : in std_logic_vector(31 downto 0);
            i3 : in std_logic_vector(31 downto 0);
            i4 : in std_logic_vector(31 downto 0);
            i5 : in std_logic_vector(31 downto 0);
            iSel : in std_logic_vector(3 downto 0);           
            iOut : out std_logic_vector(31 downto 0)
        );
end PCMUX;

architecture Behavioral of PCMUX is

begin
    with iSel select iOut <= 
        i1 when "0000",
        i2 when "0001",
        i3 when "0010",
        i4 when "0100",
        i5 when "1000",
        x"00000000" when others;
end Behavioral;
