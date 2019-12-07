----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2019 02:07:39 PM
-- Design Name: 
-- Module Name: 2WSsP3InputMux - Behavioral
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

entity WSsP3InputMux is
    generic( width : positive);
 Port ( 
            i1, i2, i3 : in std_logic_vector(width - 1 downto 0);
            iSel : in std_logic_vector(1 downto 0);
            iOut : out std_logic_vector(width - 1 downto 0)
        );
end WSsP3InputMux;

architecture Behavioral of WSsP3InputMux is
        constant ZeroConst : std_logic_vector(width - 1 downto 0) := (others => '0');
begin
    with iSel select 
        iOut <= 
                i1 when "00",
                i2 when "01",
                i3 when "10",
                zeroConst when "11",
                zeroConst when others;

end Behavioral;
