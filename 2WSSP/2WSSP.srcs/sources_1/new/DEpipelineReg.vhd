----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2019 01:38:38 PM
-- Design Name: 
-- Module Name: DEpipelineReg - Behavioral
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

entity DEpipelineReg is
  Port (
            clk                 : in std_logic;
            haltExec            : in std_logic;
            ---asyncreset          : in std_logic;
            syncreset           : in std_logic;
            pcPLUS4_8D            : in std_logic_vector(31 downto 0);
            
            R1D1D                : in std_logic_vector(31 downto 0);
            R1D2D                : in std_logic_vector(31 downto 0);
            RS1D                 : in std_logic_vector(4 downto 0);
            RT1D                 : in std_logic_vector(4 downto 0);
            RD1D                 : in std_logic_vector(4 downto 0);
            instr1_ImmSignExtD   : in std_logic_vector(31 downto 0); 
            
            R2D1D                : in std_logic_vector(31 downto 0);
            R2D2D                : in std_logic_vector(31 downto 0);
            RS2D                 : in std_logic_vector(4 downto 0);
            RT2D                 : in std_logic_vector(4 downto 0);
            RD2D                 : in std_logic_vector(4 downto 0);
            instr2_ImmSignExtD   : in std_logic_vector(31 downto 0);
            
            
            regWrite1D         : in std_logic;  
            memtoReg1D         : in std_logic;
            MemWrite1D         : in std_logic;
            ALUControl1D       : IN std_logic_vector(3 downto 0);
            ALUSrc1D           : in std_logic;
            RegDst1D           : in std_logic;
            JalD             : in std_logic;
            Shifts1D           : in std_logic;
            
            regWrite2D         : in std_logic;  
            memtoReg2D         : in std_logic;
            MemWrite2D         : IN std_logic;
            ALUControl2D       : in std_logic_vector(3 downto 0);
            ALUSrc2D           : in std_logic;
            RegDst2D           : in std_logic;
            Shifts2D           : in std_logic;
            
            
            pcPLUS4_8E            : out std_logic_vector(31 downto 0);
            
            R1D1E                : OUT std_logic_vector(31 downto 0);
            R1D2E                : out std_logic_vector(31 downto 0);
            RS1E                 : out std_logic_vector(4 downto 0);
            RT1E                 : out std_logic_vector(4 downto 0);
            RD1E                 : out std_logic_vector(4 downto 0);
            instr1_ImmSignExtE   : out std_logic_vector(31 downto 0); 
            
            R2D1E                : out std_logic_vector(31 downto 0);
            R2D2E                : out std_logic_vector(31 downto 0);
            RS2E                 : out std_logic_vector(4 downto 0);
            RT2E                 : out std_logic_vector(4 downto 0);
            RD2E                 : out std_logic_vector(4 downto 0);
            instr2_ImmSignExtE   : out std_logic_vector(31 downto 0);
            
            regWrite1E         : out std_logic;  
            memtoReg1E         : out std_logic;
            MemWrite1E         : out std_logic;
            ALUControl1E       : out std_logic_vector(3 downto 0);
            ALUSrc1E           : out std_logic;
            RegDst1E           : out std_logic;
            JalE             : out std_logic;
            Shifts1E          : out std_logic;
                                 
            regWrite2E         : out std_logic;  
            memtoReg2E         : out std_logic;
            MemWrite2E         : out std_logic;
            ALUControl2E       : out std_logic_vector(3 downto 0);
            ALUSrc2E           : out std_logic;
            RegDst2E           : out std_logic;
            Shifts2E           : out std_logic
                        
        );
end DEpipelineReg;

architecture Behavioral of DEpipelineReg is
begin
      process(clk)
        begin
                
                if(rising_edge(clk))
                    then    
                        if(syncreset = '1')
                            then 
                                    pcPLUS4_8E          <= (others => '0');
                                    R1D1E                <= (others => '0');
                                    R1D2E                <= (others => '0');
                                    RS1E                 <= (others => '0');
                                    RT1E                 <= (others => '0');
                                    RD1E                 <= (others => '0');
                                    instr1_ImmSignExtE   <= (others => '0');
                                                                       
                                    R2D1E                <= (others => '0');
                                    R2D2E                <= (others => '0');
                                    RS2E                 <= (others => '0');
                                    RT2E                 <= (others => '0');
                                    RD2E                 <= (others => '0');
                                    instr2_ImmSignExtE   <= (others => '0');
                                    
                                    regWrite1E           <=  '0';
                                    memtoReg1E           <=  '0';
                                    MemWrite1E           <=  '0';
                                    ALUControl1E         <= ( others => '0');
                                    ALUSrc1E             <=  '0';
                                    RegDst1E             <=  '0';
                                    JalE                 <=  '0';
                                    shifts1E             <=  '0';
                                                         
                                    regWrite2E           <=  '0';
                                    memtoReg2E           <=  '0';
                                    MemWrite2E           <=  '0';
                                    ALUControl2E         <= ( others => '0');
                                    ALUSrc2E             <=  '0';
                                    RegDst2E             <=  '0';
                                    shifts2E             <=  '0';
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                         else
                                 if (haltExec = '0')
                                    then 
                                      pcPLUS4_8E          <=      pcPLUS4_8D;
                                      R1D1E                <=     R1D1D             ;
                                      R1D2E                <=     R1D2D             ;
                                      RS1E                 <=     RS1D              ;
                                      RT1E                 <=     RT1D              ;
                                      RD1E                 <=     RD1D              ;
                                      instr1_ImmSignExtE   <=     instr1_ImmSignExtD;
                                                                                 
                                      R2D1E                <=     R2D1D             ;
                                      R2D2E                <=     R2D2D             ;
                                      RS2E                 <=     RS2D              ;
                                      RT2E                 <=     RT2D              ;
                                      RD2E                 <=     RD2D              ;
                                      instr2_ImmSignExtE   <=     instr2_ImmSignExtD;
                                      instr2_ImmSignExtE   <=     instr2_ImmSignExtD;   
                                      
                                      
                                      regWrite1E           <=   regWrite1D    ;     
                                      memtoReg1E           <=   memtoReg1D    ;     
                                      MemWrite1E           <=   MemWrite1D    ;     
                                      ALUControl1E         <=   ALUControl1D  ;     
                                      ALUSrc1E             <=   ALUSrc1D      ;     
                                      RegDst1E             <=   RegDst1D      ;     
                                      JalE                 <=   JalD        ;  
                                      shifts1E             <=   shifts1D      ;     
                                                                                  
                                      regWrite2E           <=   regWrite2D    ;     
                                      memtoReg2E           <=   memtoReg2D    ;    
                                      MemWrite2E           <=   MemWrite2D    ;     
                                      ALUControl2E         <=   ALUControl2D  ;     
                                      ALUSrc2E             <=   ALUSrc2D      ;    
                                      RegDst2E             <=   RegDst2D      ;
                                      shifts2E             <=   shifts2D      ;   
                                end if;                                                                                                                                                                                                                                                                                                                                                                                
                       end if;                                                                                                                                                                                                                                                                                                                                                             
                end if;
       end process;
       

end Behavioral;
