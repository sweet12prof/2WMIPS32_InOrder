----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2019 06:47:14 PM
-- Design Name: 
-- Module Name: 2WSsPControlUnit - Behavioral
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

entity WSsPControlUnit is
  Port ( 
                CU1_memtoregD                   : out std_logic;
                CU1_pcSrcD                      : out std_logic_vector(3 downto 0);
                CU1_alusrcD                     : out std_logic;
                CU1_regDstD                     : out std_logic;
                CU1_regWriteD                   : out std_logic;
                CU1_memWriteD                   : out std_logic;
                CU1_BranchD                     : out std_logic;
                CU1_JumpD                       : out std_logic;
                CU1_shiftsD                     : out std_logic;
                CU1_jalD                        : out std_logic;
                CU1_jrD                         : out std_logic;
                CU1_aluControlD                 : out std_logic_vector(3 downto 0);
                CU1_opcodeD                     : in std_logic_vector(5 downto 0);
                CU1_functD                      : in std_logic_vector(5 downto 0);
                CU1_equalD                      : in std_logic;
                CU1_haltCPU                     : out std_logic;
                
                ---------wAY2---------------------------------
                CU2_memtoregD                   : out std_logic;
                CU2_alusrcD                     : out std_logic;
                CU2_regDstD                     : out std_logic;
                CU2_regWriteD                   : out std_logic;
                CU2_memWriteD                   : out std_logic;
                CU2_shiftsD                     : out std_logic;
                CU2_aluControlD                 : out std_logic_vector(3 downto 0);
                CU2_opcodeD                     : in std_logic_vector(5 downto 0);
                CU2_functD                      : in std_logic_vector(5 downto 0)
                
        );
end WSsPControlUnit;

architecture Behavioral of WSsPControlUnit is
component CU is
	port(
		op                    : in std_logic_vector(5 downto 0);
		funct                 : in std_logic_vector(5 downto 0);
		equal                 : in std_logic;
		memWrite              : out std_logic;
		memtoReg              : out std_logic;
		regWrite              : out std_logic;
		regDst                : out std_logic;
		alusrc                :   out std_logic;
		jump                  : out std_logic;
		branch                : out std_logic;
		shifts                : out std_logic;
		jal                   : out std_logic; 
		jr                    : out std_logic;
		pcSrc                 : out std_logic_vector(3 downto 0);
		alucontrol            : out std_logic_vector(3 downto 0);
		haltCPU               : out std_logic
		);   
end component;
begin
    
    CUForWay1 : CU port map(
                                
                                op           =>   CU1_opcodeD,         
                                funct        =>   CU1_FUNCTd,
                                equal        =>   CU1_equalD,
                                memWrite     =>   CU1_memWriteD,
                                memtoReg     =>   CU1_memtoregD,
                                regWrite     =>   CU1_regWriteD,
                                regDst       =>   CU1_regDstD,       
                                alusrc       =>   CU1_alusrcD,
                                jump         =>   CU1_JumpD,
                                branch       =>   CU1_BranchD, 
                                shifts       =>   CU1_shiftsD,
                                jal          =>   CU1_jalD,    
                                jr           =>   CU1_jrD,
                                pcSrc        =>   CU1_pcSrcD,
                                alucontrol   =>   CU1_aluControlD,
                                haltCPU      =>   CU1_haltCPU                                                                                    
                            );
     
     CUForWay2 : CU port map(
                                
                                op           =>   CU2_opcodeD,         
                                funct        =>   CU2_FUNCTd,
                                equal        =>   '0',
                                memWrite     =>   CU2_memWriteD,
                                memtoReg     =>   CU2_memtoregD,
                                regWrite     =>   CU2_regWriteD,
                                regDst       =>   CU2_regDstD,       
                                alusrc       =>   CU2_alusrcD,
                                jump         =>   open,
                                branch       =>   open, 
                                shifts       =>   CU2_shiftsD,
                                jal          =>   open,    
                                jr           =>   open,
                                pcSrc        =>   open,
                                alucontrol   =>   CU2_aluControlD,
                                haltCPU      =>   open                                                                                    
                            );                       
    
    
end Behavioral;
