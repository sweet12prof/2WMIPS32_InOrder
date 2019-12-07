------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 12/01/2019 05:30:17 PM
---- Design Name: 
---- Module Name: TestScheduler - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

entity TestScheduler is
  Port ( 
            clk    : in std_logic; 
            reset  : in std_logic;
            Instr1 : out std_logic_vector(31 downto 0);
            Instr2 : out std_logic_vector(31 downto 0)
        );
end TestScheduler;

architecture Behavioral of TestScheduler is
--    signal dSig, qSig, inInstr1, inInstr2, AdderInput2: std_logic_vector(31 downto 0);
--    signal muxIn : std_logic;
--    component WSspImem 
--        Port ( 
--                Adr : in std_logic_vector(5 downto 0);
--                Rd1 : out std_logic_vector(31 downto 0);
--                Rd2 : out std_logic_vector(31 downto 0)
--            );
--    end component;
    
--    component  WSspProgramCounter is
--        Port (
--                clk, reset, stallF : in std_logic;
--                d : in std_logic_vector(31 downto 0); 
--                q : out std_logic_vector(31 downto 0)
--             );
--    end component;
    
--    component Adder32 
--        port(
--                Add32i1, Add32i2 : in std_logic_vector(31 downto 0);
--                Cin32 : in std_logic;
--                Add32Sum : out std_logic_vector(31 downto 0);
--                Cout32 : out std_logic
--        );
--    end component;
    
--    component WSsP_2InputMux_32 is
--          Port (    
--                i1, i2 : std_logic_vector(31 downto 0);
--                iSel : in std_logic;
--                iOut : out std_logic_vector(31 downto 0)
--                );
--    end component;
    
--    component WSspInstrScheduler is 
--        Port (
--                Instr1, Instr2 : in std_logic_vector(31 downto 0);
--                EX_Instr1, EX_Instr2 : out std_logic_vector(31 downto 0);
--                prePCAdderMux : out std_logic 
--            );
--    end component;
begin
--    PC : WSspProgramCounter PORT MAP(
--                                        clk     => CLK, 
--                                        reset   => reset, 
--                                        stallF  => '0',
--                                        d       => dSig,
--                                        q       => qSig
--                                    );
   
--   Imem:  WSspImem port map         (
--                                       Adr => qSig(7 downto 2),       
--                                       Rd1 => inInstr1, 
--                                       Rd2 => inInstr2
--                                     );
   
--   Scheduler: WSspInstrScheduler port map(                                              
--                                               Instr1                => inInstr1,
--                                               Instr2                => inInstr2,
--                                               EX_Instr1             => Instr1,
--                                               EX_Instr2             => Instr2,
--                                               prePCAdderMux         => muxIn                                                  
--                                          );
  
--  preAdderMUX: WSsP_2InputMux_32 port map(
--                                              i1     => x"00000008",
--                                              i2     => x"00000004",
--                                              iSel   => muxIn,   
--                                              iOut   => AdderInput2                                                 
--                                            );
                                           
-- Adder: Adder32 PORT MAP (
--                              Add32i1  =>  qSig,
--                              Add32i2  =>  AdderInput2, 
--                              Cin32    =>  '0',
--                              Add32Sum =>  dSig,
--                              Cout32   =>  open                             
--                          );
   

end Behavioral;
