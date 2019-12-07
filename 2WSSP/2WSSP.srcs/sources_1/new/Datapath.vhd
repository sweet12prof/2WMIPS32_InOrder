----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2019 03:55:30 PM
-- Design Name: 
-- Module Name: Datapath - Behavioral
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

entity Datapath is
  Port ( 
--------------------    INPUTS    ----------------------------------            
                clk                             : in std_logic;
                reset                           : in std_logic;
                
                pc                              : out std_logic_vector(31 downto 0);
                instr1                          : in std_logic_vector(31 downto 0);
                instr2                          : in std_logic_vector(31 downto 0);
                aluOut1                         : out std_logic_vector(31 downto 0); 
                aluOut2                         : out std_logic_vector(31 downto 0); 
                writedata1                      : out std_logic_vector(31 downto 0); 
                writedata2                      : out std_logic_vector(31 downto 0); 
                readData1                       : in std_logic_vector(31 downto 0);
                readData2                       : in std_logic_vector(31 downto 0);
                memWrite1                       : out std_logic;
                memWrite2                       : out std_logic;
                
                
                
------------------------------------------------------------------------------------------------ 
                                 --From Control Unit
---------------------------------------------------------------------------------------------------------------
                
                -------WAY 1----------------------------------
                CU1_memtoregD                   : in std_logic;
                CU1_pcSrcD                      : in std_logic_vector(3 downto 0);
                CU1_alusrcD                     : in std_logic;
                CU1_regDstD                     : in std_logic;
                CU1_regWriteD                   : in std_logic;
                CU1_memWriteD                   : in std_logic;
                CU1_BranchD                     : in std_logic;
                CU1_JumpD                        : in std_logic;
                CU1_shiftsD                      : in std_logic;
                CU1_jalD                         : in std_logic;
                CU1_jrD                          : in std_logic;
                CU1_aluControlD                 : in std_logic_vector(3 downto 0);
                CU1_opcodeD                     : out std_logic_vector(5 downto 0);
                CU1_functD                      : out std_logic_vector(5 downto 0);
                CU1_equalD                      : out std_logic;
                CU1_haltCPU                     : in std_logic;
                
                ---------wAY2---------------------------------
                CU2_memtoregD                   : in std_logic;
                CU2_alusrcD                     : in std_logic;
                CU2_regDstD                     : in std_logic;
                CU2_regWriteD                   : in std_logic;
                CU2_memWriteD                   : in std_logic;
                CU2_shiftsD                     : in std_logic;
                CU2_aluControlD                 : in std_logic_vector(3 downto 0);
                CU2_opcodeD                     : out std_logic_vector(5 downto 0);
                CU2_functD                      : out std_logic_vector(5 downto 0);
                
                

------------------------------------------------------------------------------------------------ 
                                 --From And To Hazard Unit
---------------------------------------------------------------------------------------------------------------

                HU1_StallF                      : in std_logic;
                HU1_StallD                      : in std_logic;
                HU1_FlushE                      : in std_logic;
                
                HU1_ForwardAD                   : in std_logic;
                HU1_ForwardBD                   : in std_logic;
                
                HU1_BranchForwardCD                   : in std_logic;
                HU1_BranchForwardDD                   : in std_logic;
                
                
                HU1_ForwardAE                   : in std_logic_vector(1 downto 0);
                HU1_ForwardBE                   : in std_logic_vector(1 downto 0);
                
                HU1_ForwardCE                   : in std_logic_vector(1 downto 0);
                HU1_ForwardDE                   : in std_logic_vector(1 downto 0);
                
                HU1_ForwardCD                   : in std_logic_vector(1 downto 0);
                HU1_BranchD                     : out std_logic;
                HU1_JumpD                       : out std_logic;
                HU1_JrD                         : out std_logic;
                HU1_memtoRegE                   : out std_logic;
                HU1_memtoRegM                   : out std_logic;
                HU1_RegWriteE                   : out std_logic;
                HU1_RegWriteM                   : out std_logic;
                HU1_regWriteW                   : out std_logic;
                HU1_writeRegE                   : out std_logic_vector(4 downto 0);
                HU1_writeRegM                   : out std_logic_vector(4 downto 0);
                HU1_writeRegW                   : out std_logic_vector(4 downto 0);
                HU1_RsD                         : out std_logic_vector(4 downto 0);
                HU1_RtD                         : out std_logic_vector(4 downto 0);
                HU1_RsE                         : out std_logic_vector(4 downto 0);
                HU1_RtE                         : out std_logic_vector(4 downto 0);
                
                
                HU2_StallF                      : in std_logic;
                HU2_StallD                      : in std_logic;
                HU2_FlushE                      : in std_logic;
                HU2_ForwardAE                   : in std_logic_vector(1 downto 0);
                HU2_ForwardBE                   : in std_logic_vector(1 downto 0);
                
                HU2_ForwardCE                   : in std_logic_vector(1 downto 0);
                HU2_ForwardDE                   : in std_logic_vector(1 downto 0);                

                HU2_memtoRegE                   : out std_logic;
                HU2_memtoRegM                   : oUT std_logic;
                
                hu2_regWriteE                   : out std_logic;
                HU2_RegWriteM                   : out std_logic;
                HU2_regWriteW                   : out std_logic;
                
                HU2_writeRegE                   : out std_logic_vector(4 downto 0);
                HU2_writeRegM                   : out std_logic_vector(4 downto 0);
                HU2_writeRegW                   : out std_logic_vector(4 downto 0);
                HU2_RsD                         : out std_logic_vector(4 downto 0);
                HU2_RtD                         : out std_logic_vector(4 downto 0);
                HU2_RsE                         : out std_logic_vector(4 downto 0);
                HU2_RtE                         : out std_logic_vector(4 downto 0)
        );
end Datapath;

architecture Behavioral of Datapath is

    component Adder32 is
        port(
            Add32i1, Add32i2 : in std_logic_vector(31 downto 0);
            Cin32 : in std_logic;
            Add32Sum : out std_logic_vector(31 downto 0);
            Cout32 : out std_logic
        );
    end component;
    
    
    component WSsP_2InputMux_32 is
            generic(
                        width : positive
                   );
              Port (    
                        i1, i2 : in std_logic_vector(width - 1 downto 0);
                        iSel : in std_logic;
                        iOut : out std_logic_vector(width - 1 downto 0)
                    );
    end component;
    
    
    component WSspInstrScheduler is
        Port (
                   Instr1, Instr2 : in std_logic_vector(31 downto 0);
                   EX_Instr1, EX_Instr2 : out std_logic_vector(31 downto 0);
                   prePCAdderMux : out std_logic
               );
    end component;
    
    component  PCMUX is
          Port ( 
                    i1 : in std_logic_vector(31 downto 0);
                    i2 : in std_logic_vector(31 downto 0);
                    i3 : in std_logic_vector(31 downto 0);
                    i4 : in std_logic_vector(31 downto 0);
                    i5 : in std_logic_vector(31 downto 0);
                    iSel : in std_logic_vector(3 downto 0);           
                    iOut : out std_logic_vector(31 downto 0)
                );
    end component;
    
    
    component WSspProgramCounter is
         Port (
                    clk, reset, stallF : in std_logic;
                    d : in std_logic_vector(31 downto 0); 
                    q : out std_logic_vector(31 downto 0)
                 );
    end component;
    
    component FDpipelineReg is
                   Port ( 
                             clk             : in std_logic;
                        --     asyncReset      : in std_logic;
                             syncReset       : in std_logic;
                             stallD          : in std_logic;
    
                             instr1F         : in std_logic_vector(31 downto 0);
                             instr2F         : in std_logic_vector(31 downto 0);
                             PCplus4_8F      : in std_logic_vector(31 downto 0);
    
                             instr1D         : out std_logic_vector(31 downto 0);
                             instr2D         : out std_logic_vector(31 downto 0);
                             PCplus4_8D      : out std_logic_vector(31 downto 0)                       
                         );
     end component;
     
     
     component  WSsPregFile is
             Port ( 
                        clk, W1WE, W2WE : in std_logic;
                        W1A1, W1A2, W1WA  : in std_logic_vector(4 downto 0);
                        W1RD1, W1RD2  : out std_logic_vector(31 downto 0);
                        W1WD  : in std_logic_vector(31 downto 0);
                        
                        W2A1, W2A2, W2WA : in std_logic_vector(4 downto 0);
                        W2RD1, W2RD2 : out std_logic_vector(31 downto 0);
                        W2WD  : in std_logic_vector(31 downto 0)
                        
             );
    end component;
    
    component signExt is
              	port (
              		a : in std_logic_vector(15 downto 0);
              		y : out std_logic_vector(31 downto 0)
              	);
     end component;
     
     component sl2 is
            port(
                a : in std_logic_vector(31 downto 0);
                b : out std_logic_vector(31 downto 0)
            );
     end component;
     
    
     
     
     
     component WSsP3InputMux is
            generic( width : positive);
         Port ( 
                    i1, i2, i3 : in std_logic_vector(width - 1 downto 0);
                    iSel : in std_logic_vector(1 downto 0);
                    iOut : out std_logic_vector(width - 1 downto 0)
                );
     end component;
     
     
     component comparator is
            port(
                    com_i1  : in STD_LOGIC_VECTOR(31 downto 0); 
                    com_i2  : in STD_LOGIC_VECTOR(31 downto 0);
                    com_o1  : out STD_LOGIC
             );
     end component;
     
     
     component DEpipelineReg is
              Port (
                        clk                 : in std_logic;
                    --    asyncreset          : in std_logic;
                        haltExec            : in std_logic;
                        syncreset           : in std_logic;
                        
                        pcPLUS4_8D           : in std_logic_vector(31 downto 0);
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
                        shifts1D           : in std_logic;
                        
                        regWrite2D         : in std_logic;  
                        memtoReg2D         : in std_logic;
                        MemWrite2D         : IN std_logic;
                        ALUControl2D       : in std_logic_vector(3 downto 0);
                        ALUSrc2D           : in std_logic;
                        RegDst2D           : in std_logic;
                        shifts2D           : in std_logic;
                        
                        
                        pcPLUS4_8E           : out std_logic_vector(31 downto 0);
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
                        shifts1E           : out std_logic;
                                             
                        regWrite2E         : out std_logic;  
                        memtoReg2E         : out std_logic;
                        MemWrite2E         : out std_logic;
                        ALUControl2E       : out std_logic_vector(3 downto 0);
                        ALUSrc2E           : out std_logic;
                        RegDst2E           : out std_logic;
                        Shifts2E           : out std_logic
                                    
                    );
end component;
     

component ALU 
    port
	(
		ALUinput1,ALUinput2 : in STD_LOGIC_VECTOR(31 downto 0);
		ALUctrl :  in STD_LOGIC_VECTOR(3 downto 0);
		output  : out STD_LOGIC_VECTOR(31 downto 0);
		zero : out std_logic;
		carryOut: out STD_LOGIC
		);
end component;      
    

component EMpipelineReg is
 Port ( 
           clk              : in std_logic;
           --asyncreset       : in std_logic;
           
           pcPLUS4_8E       : in std_logic_vector(31 downto 0); 
           ALU1outE         : in std_logic_vector(31 downto 0);
           writeData1E      : in std_logic_vector(31 downto 0);
           writeReg1E       : in std_logic_vector(4 downto 0);
           
           ALU2outE         : in std_logic_vector(31 downto 0);
           writeData2E      : in std_logic_vector(31 downto 0);
           writeReg2E       : in std_logic_vector(4 downto 0);
           
           regWrite1E       : in std_logic;
           memtoReg1E       : in std_logic;
           MemWrite1E       : in std_logic;
           jalE             : in std_logic;
           
           regWrite2E       : in std_logic;
           memtoReg2E       : in std_logic;
           MemWrite2E       : in std_logic;
           
           pcPLUS4_8M       : out std_logic_vector(31 downto 0);
           ALU1outM         : out std_logic_vector(31 downto 0);
           writeData1M      : out std_logic_vector(31 downto 0);
           writeReg1M       : out std_logic_vector(4 downto 0);
           
           ALU2outM         : out std_logic_vector(31 downto 0);
           writeData2M      : out std_logic_vector(31 downto 0);
           writeReg2M       : out std_logic_vector(4 downto 0);
           
            regWrite1M  : out std_logic;
            memtoReg1M  : out std_logic;
            MemWrite1M  : out std_logic;
            jalM             : out std_logic;
                     
            regWrite2M  : out std_logic;
            memtoReg2M  : out std_logic;
            MemWrite2M  : out std_logic
            
        );
end component; 



component MWBpipelineReg 
  Port ( 
            clk                      : in std_logic; 
            --asyncreset               : in std_logic;
            
            readData1M           : in std_logic_vector(31 downto 0);
            ALUout1M             : in std_logic_vector(31 downto 0);
            
            readData2M           : in std_logic_vector(31 downto 0);
            ALUout2M             : in std_logic_vector(31 downto 0);
            
            regWrite1M           : in std_logic;  
            memtoReg1M           : in std_logic;
            writeReg1M           : in std_logic_vector(4 downto 0);  
                                                 
            regWrite2M           : in std_logic;  
            memtoReg2M           : in std_logic;
            writeReg2M           : in std_logic_vector(4 downto 0);  
                       
            readData1WB           : out std_logic_vector(31 downto 0);
            ALUout1WB             : out std_logic_vector(31 downto 0);
            
            readData2WB           : out std_logic_vector(31 downto 0);
            ALUout2WB             : out std_logic_vector(31 downto 0); 
            
            regWrite1WB           : out std_logic;
            memtoReg1WB           : out std_logic;
            writeReg1WB           : out std_logic_vector(4 downto 0); 
                                                
            regWrite2WB           : out std_logic;
            memtoReg2WB           : out std_logic;
            writeReg2WB           : out std_logic_vector(4 downto 0)  
                        
                    );
     end component;                
                    
 coMPONENT  newComp is
  Port ( 
            input1 : in std_logic_vector(31 downto 0);
            input2 : in std_logic_vector(31 downto 0);
            Output : out std_logic
  );
end COMPONENT;

  
    
    
    
    
     
    --------------------------------Fetch Stage Signal --------------------------------------  
    signal Exinstr1F, EXinstr2F :  std_logic_vector(31 downto 0);
    signal pcOut : std_logic_vector(31 downto 0);
    signal pcAdderMuxSel : std_logic;
    signal postpcAdderMux : std_logic_vector(31 downto 0);
    signal pcPlus4_8F : std_logic_vector(31 downto 0);
    signal pcIn : std_logic_vector(31 downto 0);
    signal FD_regStall : std_logic;
    signal PCFlopStall : std_logic;
    
    
    ------------------------------------------Decode Stage Signal --------------------------
    signal pcBranchD      : std_logic_vector(31 downto 0);
    signal pcJrD          : std_logic_vector(31 downto 0);
    signal pcJumpD        : std_logic_vector(31 downto 0);
    signal FDpipeRegClr   : std_logic;
    signal EXinstr1D      : std_logic_vector(31 downto 0);
    signal EXinstr2D      : std_logic_vector(31 downto 0);
    signal pcPlus4_8D     : std_logic_vector(31 downto 0);
    signal RD1D_1         : std_logic_vector(31 downto 0);     
    signal RD2D_1         : std_logic_vector(31 downto 0);
    signal RD1D_2         : std_logic_vector(31 downto 0);     
    signal RD2D_2         : std_logic_vector(31 downto 0);
    
    signal rs1D           : std_logic_vector(4 downto 0);           
    signal rt1D           : std_logic_vector(4 downto 0);  
    signal rD1D           : std_logic_vector(4 downto 0);
    signal Imm1           : std_logic_vector(15 downto 0);
    signal signExtImm1D    : std_logic_vector(31 downto 0);
    signal sl2signExt1D    : std_logic_vector(31 downto 0);
    signal shamtExt1D       : std_logic_vector(31 downto 0);
    
    signal rs2D           : std_logic_vector(4 downto 0);
    signal rt2D           : std_logic_vector(4 downto 0);
    signal rD2D           : std_logic_vector(4 downto 0);
    signal Imm2           : std_logic_vector(15 downto 0);
    signal signExtImm2D    : std_logic_vector(31 downto 0);
    signal shamtExt2D       : std_logic_vector(31 downto 0);
    signal instr1_JumpAddressD : std_logic_vector(25 downto 0); 
    signal DEreg_Flush   : std_logic;
    
    signal precompIn1 : std_logic_vector(31 downto 0);
    signal precompIn2 : std_logic_vector(31 downto 0);
    signal compIn1 : std_logic_vector(31 downto 0);
    signal compIn2 : std_logic_vector(31 downto 0);
    signal equal : std_logic;
    
    
    ------------------------------------Execute Signals ------------------------------------------
             signal               pcPLUS4_8E           :  std_logic_vector(31 downto 0);
             signal               R1D1E                :  std_logic_vector(31 downto 0); 
             signal               R1D2E                :  std_logic_vector(31 downto 0); 
             signal               RS1E                 :  std_logic_vector(4 downto 0);  
             signal               RT1E                 :  std_logic_vector(4 downto 0);  
             signal               RD1E                 :  std_logic_vector(4 downto 0);  
             signal               instr1_ImmSignExtE   :  std_logic_vector(31 downto 0); 
                                                                                  
             signal               R2D1E                :  std_logic_vector(31 downto 0); 
             signal               R2D2E                :  std_logic_vector(31 downto 0); 
             signal               RS2E                 :  std_logic_vector(4 downto 0);  
             signal               RT2E                 :  std_logic_vector(4 downto 0);  
             signal               RD2E                 :  std_logic_vector(4 downto 0);  
             signal               instr2_ImmSignExtE   :  std_logic_vector(31 downto 0); 
                                                                                      
             signal               regWrite1E         :  std_logic;                       
             signal               memtoReg1E         :  std_logic;                       
             signal               MemWrite1E         :  std_logic;                       
             signal               ALUControl1E       :  std_logic_vector(3 downto 0);    
             signal               ALUSrc1E           :  std_logic;                       
             signal               RegDst1E           :  std_logic;                       
             signal               JalE             :  std_logic;                       
             signal               shifts1E, someSig           :  std_logic;                       
                                                                                  
             signal               regWrite2E         :  std_logic;                       
             signal               memtoReg2E         :  std_logic;                       
             signal               MemWrite2E         :  std_logic;                       
             signal               ALUControl2E       :  std_logic_vector(3 downto 0);    
             signal               ALUSrc2E           :  std_logic;                       
             signal               RegDst2E           :  std_logic; 
             signal               shifts2e           :  std_logic;  
             
             
             Signal WAY1ShamtMUXinput0 :   std_logic_vector(31 downto 0);
             signal WAY2ShamtMUXinput0 :   std_logic_vector(31 downto 0); 
             
             signal WAY1SignImmMUXinput0    :   std_logic_vector(31 downto 0); 
             signal WAY2SignImmMUXinput0    :   std_logic_vector(31 downto 0);  
             
             signal ALU1input1               :   std_logic_vector(31 downto 0);
             signal ALU1input2               :   std_logic_vector(31 downto 0);
             signal ALU2input1               :   std_logic_vector(31 downto 0);
             signal ALU2input2               :   std_logic_vector(31 downto 0);
            
            
            signal ALUout1E      : std_logic_vector(31 downto 0);
            signal ALUout2E      : std_logic_vector(31 downto 0);
            signal WriteRegMuxIn  : std_logic_vector(4 downto 0); 
            signal WriteReg1E, WriteReg2E : std_logic_vector(4  downto 0);
             
            signal WAY1ShamtMUXinput0res        : std_logic_vector(31 downto 0);
            signal WAY2ShamtMUXinput0res        : std_logic_vector(31 downto 0);
                                                
            signal WAY1SignImmMUXinput0res      : std_logic_vector(31 downto 0);
            signal WAY2SignImmMUXinput0res      : std_logic_vector(31 downto 0);   
   
    -------------------------------------mEMory Stage Signals------------------------------------ 
    
    --signal ALUout1M      : std_logic_vector(31 downto 0);
    --signal ALUout2M      : std_logic_vector(31 downto 0);
    signal ALUout1Mres   : std_logic_vector(31 downto 0);
    
    
    signal       pcPLUS4_8M       :  std_logic_vector(31 downto 0);
    signal       ALU1outM         :  std_logic_vector(31 downto 0);
    signal       writeData1M      :  std_logic_vector(31 downto 0);
    signal       writeReg1M       :  std_logic_vector(4 downto 0);
          
    signal       ALU2outM         :  std_logic_vector(31 downto 0);
    signal       writeData2M      :  std_logic_vector(31 downto 0);
    signal       writeReg2M       :  std_logic_vector(4 downto 0);
         
    signal        regWrite1M      :  std_logic;
    signal        memtoReg1M      :  std_logic;
    signal        MemWrite1M      :  std_logic;
    signal        jalM             : std_logic;
                    
    signal        regWrite2M      :  std_logic;
    signal        memtoReg2M      :  std_logic;
    signal        MemWrite2M      :  std_logic;
    
    
    -----------------------------------------WriteBack Signals -------------------------------
    signal writeReg1WB     : std_logic_vector(4 downto 0); 
    signal writeReg2WB     : std_logic_vector(4 downto 0);
    SIGNAL result1W       : std_logic_vector(31 downto 0);
    signal result2W       : std_logic_vector(31 downto 0); 
    
    
    
    
     signal      readData1WB           :  std_logic_vector(31 downto 0);    
     signal      ALUout1WB             :  std_logic_vector(31 downto 0);    
                                                                     
     signal      readData2WB           :  std_logic_vector(31 downto 0);    
     signal      ALUout2WB             :  std_logic_vector(31 downto 0);    
                                                                     
     signal      regWrite1WB           :  std_logic;                        
     signal      memtoReg1WB           :  std_logic;                        
                                                                   
     signal      regWrite2WB           :  std_logic;                        
     signal      memtoReg2WB           :  std_logic;                         
    
begin


--------------------------- -------------------------------------------------------------------------------- 
                           --- Fetch Stage 
------------------------------------------------------------------------------------------------------------\
    ScoreBoardScheduler : WSspInstrScheduler port map(
                                                           Instr1           =>  instr1,
                                                           Instr2           =>  instr2,
                                                           EX_Instr1        =>  Exinstr1F,
                                                           EX_Instr2        =>  EXinstr2F,
                                                           prePCAdderMux    =>  pcAdderMuxSel                  
                                                     );
    
    
    
    PCplus4_8AdderMUX : WSsP_2InputMux_32 generic map(32) port map (
                                                                      i1       =>  x"00000008",  
                                                                      i2       =>  x"00000004",
                                                                      iSel     =>  pcAdderMuxSel,
                                                                      iOut     =>  postpcAdderMux                                                                                                            
                                                                    );
    
    
    PCplus4_8Adder : Adder32 port map(
                                         Add32i1    => pcOut,
                                         Add32i2    => postpcAdderMux,
                                         Cin32      => '0',
                                         Add32Sum   => pcPlus4_8F,
                                         Cout32     => open                                    
                                        );
     
    pc <= pcOut;
    
    
    pcMUX1 :  PCMUX port map(
                                i1   =>  pcPlus4_8F,
                                i2   =>  pcBranchD,
                                i3   =>  pcJumpD,
                                i4   =>  pcJumpD, -- Jal, and J have the same Address field
                                i5   =>  pcJrD,
                                iSel =>  CU1_pcSrcD,
                                iOut =>  pcIn                                
                             );
                             
    PCFlopStall <= HU1_StallF or HU2_StallF OR CU1_haltCPU;
    
    
    PCFlopr  : WSspProgramCounter port map (
                                                clk         =>  clk, 
                                                reset       =>  reset,
                                                stallF      =>  PCFlopStall,           
                                                d           =>  pcIn,
                                                q           =>  pcOut                 
                                           );
    
    FDpipeRegClr <= CU1_pcSrcD(3) or CU1_pcSrcD(2) or CU1_pcSrcD(1)  when FD_regStall = '1' else 
    CU1_pcSrcD(3) or CU1_pcSrcD(2) or CU1_pcSrcD(1) or CU1_pcSrcD(0);
    
    FD_regStall <= HU1_StallD or HU2_StallD or CU1_haltCPU;
                                           
    FDREG : FDpipelineReg port  map ( 
    
                             clk            =>      clk,
                             --asyncReset     =>      open,
                             syncReset      =>      FDpipeRegClr,
                             stallD         =>      FD_regStall,
                                            
                             instr1F        =>      Exinstr1F,
                             instr2F        =>      EXinstr2F, 
                             PCplus4_8F     =>      pcPlus4_8F, 
                                           
                             instr1D        =>      EXinstr1D,   
                             instr2D        =>      EXinstr2D,
                             PCplus4_8D     =>      pcPlus4_8D                 
                         );
                         
                         
                         
 ------------------------------------------------------------------------------------------------------------
                                ------------Decode Stage ------------------------
 --------------------------------------------------------------------------------------------------------------
   CU1_opcodeD       <=   Exinstr1D(31 downto 26);
   CU1_functD        <=   Exinstr1D(5 downto 0);
   CU2_opcodeD       <=   Exinstr2D(31 downto 26);                    
   CU2_functD        <=   Exinstr2D(5 downto 0);
   
   HU1_BranchD <= CU1_BranchD;
   HU1_JumpD <= CU1_JumpD;
   HU1_JrD  <= CU1_JrD;
   
   RF : WSsPregFile Port map ( 
                                clk         => clk,
                                W1WE        => regWrite1WB,
                                W2WE        => regWrite2WB,
                                W1A1        => EXinstr1D(25 downto 21),
                                W1A2        => EXinstr1D(20 downto 16),
                                W1WA        => writeReg1WB,
                                W1RD1       => RD1D_1,
                                W1RD2       => RD2D_1,
                                W1WD        => result1W,
                               
                                W2A1        => EXinstr2D(25 downto 21),
                                W2A2        => EXinstr2D(20 downto 16),
                                W2WA        => writeReg2WB,
                                W2RD1       => RD1D_2,
                                W2RD2       => RD2D_2,
                                W2WD        => result2W                     
             );
             
     rs1D           <=      EXinstr1D(25 downto 21);
     rt1D           <=      EXinstr1D(20 downto 16);
     rD1D           <=      EXinstr1D(15 downto 11);
     Imm1           <=      EXinstr1D(15 downto 0);
     instr1_JumpAddressD <= EXinstr1D(25 downto 0);
                    
     rs2D           <=      EXinstr2D(25 downto 21);
     rt2D           <=      EXinstr2D(20 downto 16);
     rD2D           <=      EXinstr2D(15 downto 11);  
     Imm2           <=      EXinstr2D(15 downto 0);
     
    
    signExtenderWAY1 : signExt port map(
                                        a  => Imm1,
                                        y  => signExtImm1D                                     
                                    );
                                    
    
    sl2WAY1 :    sl2 port map (
                                    a =>    signExtImm1D,
                                    b =>    sl2signExt1D
                               );                            
   
   
   PCBranchAdder : Adder32 port map(
                                         Add32i1    => sl2signExt1D,
                                         Add32i2    => pcPlus4_8D, 
                                         Cin32      => '0',
                                         Add32Sum   => pcBranchD, 
                                         Cout32     => open                                    
                                        ); 
   
                                    
    pcJumpD <=    pcPlus4_8D(31 downto 28) & instr1_JumpAddressD & "00";
    HU1_RsD  <=  rs1D;
    HU1_RtD  <=  rt1D;
    
    HU2_RsD  <= rs2D;
    HU2_RtD  <= rs2D;
    
     signExtenderWAY2 : signExt port map(
                                        a  => Imm2,
                                        y  => signExtImm2D                                     
                                    );
                                    
                                    
     
     PCjrDMUX : WSsP3InputMux generic map(32) port map(
                                                            i1   => RD1D_1,
                                                            i2   => result1W,
                                                            i3   => ALUout1Mres,
                                                            iSel => HU1_ForwardCD,
                                                            iOut => pcJrD                                                                                                                       
                                                        );
     
     
     pre_preComparatorin1MUX : WSsP_2InputMux_32 generic map(32) port map (
                                                                          i1    => RD1D_1,
                                                                          i2    => ALUout1Mres,
                                                                          iSel  => HU1_ForwardAD,
                                                                          iOut  => precompIn1         
                                                                        );
                                                                        
     pre_preComparatorin2MUX : WSsP_2InputMux_32 generic map(32) port map (
                                                                          i1    => RD2D_1,
                                                                          i2    => ALUout1Mres,
                                                                          iSel  => HU1_ForwardBD,
                                                                          iOut  => precompIn2         
                                                                        ); 
        
    preComparatorin1MUX : WSsP_2InputMux_32 generic map(32) port map (
                                                                          i1    => precompIn1,
                                                                          i2    => ALU2outM,
                                                                          iSel  => HU1_BranchForwardCD,
                                                                          iOut  => compIn1         
                                                                        ); 
   
   preComparatorin2MUX : WSsP_2InputMux_32 generic map(32) port map (
                                                                          i1    => precompIn2,
                                                                          i2    => ALU2outM,
                                                                          iSel  => HU1_BranchForwardDD,
                                                                          iOut  => compIn2         
                                                                        );                                                                
                                                                        
                                                                        
                                                                        
    comparatorWay1 :     newComp 
                                  Port map ( 
                                            input1  => compIn1,
                                            input2  => compIn2,
                                            Output  => CU1_equalD 
                                  );                                                      
                                                                                                    
     
     
    DEreg_Flush <=  HU1_FlushE or HU2_FlushE;                             
     
     DEreg :        DEpipelineReg   port map (      
                                                        clk                     => clk,         
                                                       -- asyncreset              => open,
                                                       haltExec                 => CU1_haltCPU,
                                                        syncreset               => DEreg_Flush,
                                                        
                                                        pcPLUS4_8D              =>  pcPlus4_8D,
                                                        R1D1D                   =>  RD1D_1,
                                                        R1D2D                   =>  RD2D_1,
                                                        RS1D                    =>  rs1D,         
                                                        RT1D                    =>  rt1D,    
                                                        RD1D                    =>  rD1D,
                                                        instr1_ImmSignExtD      =>  signExtImm1D,
                                                
                                                        R2D1D                   =>   RD1D_2,      
                                                        R2D2D                   =>   RD2D_2,      
                                                        RS2D                    =>   rs2D,        
                                                        RT2D                    =>   rt2D,        
                                                        RD2D                    =>   rD2D,        
                                                        instr2_ImmSignExtD      =>   signExtImm2D,
                                                
                                                
                                                        regWrite1D              =>   CU1_regWriteD,
                                                        memtoReg1D              =>   CU1_memtoRegD,
                                                        MemWrite1D              =>   CU1_memWriteD,
                                                        ALUControl1D            =>   CU1_aluControlD,
                                                        ALUSrc1D                =>   CU1_aluSrcD,
                                                        RegDst1D                =>   CU1_regDstD,
                                                        JalD                    =>   CU1_JalD,   
                                                        Shifts1D                =>   CU1_shiftsD,
                                                
                                                        regWrite2D              =>   CU2_regWriteD,
                                                        memtoReg2D              =>   CU2_memtoRegD,
                                                        MemWrite2D              =>   CU2_memWriteD,
                                                        ALUControl2D            =>   CU2_aluControlD,
                                                        ALUSrc2D                =>   CU2_alusrcD,
                                                        regDst2D                =>   CU2_regDstD,
                                                        shifts2D                =>   CU2_shiftsD,
                                                
                                                        pcPLUS4_8E              =>   pcPLUS4_8E,
                                                        R1D1E                   =>   R1D1E,
                                                        R1D2E                   =>   R1D2E,
                                                        RS1E                    =>   RS1E,
                                                        RT1E                    =>   RT1E,
                                                        RD1E                    =>   RD1E,
                                                        instr1_ImmSignExtE      =>   instr1_ImmSignExtE,
                                                                                
                                                        R2D1E                   =>      R2D1E             ,
                                                        R2D2E                   =>      R2D2E             ,
                                                        RS2E                    =>      RS2E              ,
                                                        RT2E                    =>      RT2E              ,
                                                        RD2E                    =>      RD2E              ,
                                                        instr2_ImmSignExtE      =>      instr2_ImmSignExtE,
                                                                                                          
                                                        regWrite1E              =>      regWrite1E        ,
                                                        memtoReg1E              =>      memtoReg1E        ,
                                                        MemWrite1E              =>      MemWrite1E        ,
                                                        ALUControl1E            =>      ALUControl1E      ,
                                                        ALUSrc1E                =>      ALUSrc1E          ,
                                                        RegDst1E                =>      RegDst1E          ,
                                                        JalE                    =>      JalE              ,
                                                        shifts1E                =>      shifts1E          ,
                                                                                                          
                                                        regWrite2E              =>      regWrite2E        ,
                                                        memtoReg2E              =>      memtoReg2E        ,
                                                        MemWrite2E              =>      MemWrite2E        ,
                                                        ALUControl2E            =>      ALUControl2E      ,
                                                        ALUSrc2E                =>      ALUSrc2E          ,
                                                        RegDst2E                =>      RegDst2E          ,
                                                        Shifts2E                =>      Shifts2E                  
                                                );
 
 
 
  ------------------------------------------------------------------------------------------------------------
                                ------------Execute Stage ------------------------
 -------------------------------------------------------------------------------------------------------------
 
 
                 ----------------------------------------------------------------------
                                 --WAY1 pre SHAMT MUX and pre SignImmM MUX
                 ----------------------------------------------------------------------
 WAY1preWAY1_WAY2ForwardMUX_MUX :      WSsP3InputMux generic map(32) port map(
                                                            i1   =>   R1D1E,
                                                            i2   =>   result1W,
                                                            i3   =>   ALUout1Mres,
                                                            iSel =>   HU1_ForwardAE,  
                                                            iOut =>   WAY1ShamtMUXinput0                                                                                                            
                                                        );
 
 WAY1preWAY1_WAY2ForwardMUX2_MUX :   WSsP3InputMux generic map(32) port map(
                                                            i1   =>   R1D2E,
                                                            i2   =>   result1W,
                                                            i3   =>   ALUout1Mres,
                                                            iSel =>   HU1_ForwardBE,  
                                                            iOut =>   WAY1SignImmMUXinput0                                                                                                             
                                                        );
 
 
 WAY1_WAY2ForwardMUX :  WSsP3InputMux generic map(32) port map(
                                                            i1   =>   WAY1ShamtMUXinput0,
                                                            i2   =>   result2W,
                                                            i3   =>   ALU2outM,
                                                            iSel =>   HU1_ForwardCE,  
                                                            iOut =>   WAY1ShamtMUXinput0res                                                                                                            
                                                        );
 
 WAY1_WAY2ForwardMUX2  :  WSsP3InputMux generic map(32) port map(
                                                            i1   =>   WAY1SignImmMUXinput0,
                                                            i2   =>   result2W,
                                                            i3   =>   ALU2outM,
                                                            iSel =>   HU1_ForwardDE,  
                                                            iOut =>   WAY1SignImmMUXinput0res                                                                                                            
                                                        );
 
 
 
 
 
 
                    ----------------------------------------------------------------------  
                                    --WAY2 pre SHAMT MUX and pre SignImmM  MUX                    
                    ----------------------------------------------------------------------  
                
 WAY2preWAY2_WAY1ForwardMUX_MUX  :        WSsP3InputMux generic map(32) port map(
                                                            i1   =>   R2D1E,
                                                            i2   =>   result2W,
                                                            i3   =>   ALU2outM,
                                                            iSel =>   HU2_ForwardAE,  
                                                            iOut =>   WAY2ShamtMUXinput0                                                                                                            
                                                        );
 
 WAY2preWAY2_WAY1ForwardMUX2_MUX   :      WSsP3InputMux generic map(32) port map(
                                                            i1   =>   R2D2E,
                                                            i2   =>   result2W,
                                                            i3   =>   ALU2outM,
                                                            iSel =>   HU2_ForwardBE,  
                                                            iOut =>   WAY2SignImmMUXinput0                                                                                                             
                                                        );


WAY2_WAY1ForwardMUX_MUX  :        WSsP3InputMux generic map(32) port map(
                                                            i1   =>   WAY2ShamtMUXinput0,
                                                            i2   =>   result1W,
                                                            i3   =>   ALUout1Mres,
                                                            iSel =>   HU2_ForwardCE,  
                                                            iOut =>   WAY2ShamtMUXinput0res                                                                                                            
                                                        );
                                                        

WAY2_WAY1ForwardMUX2_MUX   :      WSsP3InputMux generic map(32) port map(
                                                            i1   =>   WAY2SignImmMUXinput0,
                                                            i2   =>   result1W,
                                                            i3   =>   ALUout1Mres,
                                                            iSel =>   HU2_ForwardDE,   
                                                            iOut =>   WAY2SignImmMUXinput0res                                                                                                             
                                                        );


                                                            
                    ----------------------------------------------------------------------                                        
                                    --WAY1  SHAMT MUX    AND Sign Mux                                                    
                    ----------------------------------------------------------------------                                      
                                                        
 WAY1ShamtMUX          :        WSsP_2InputMux_32 generic map(32) port map (
                                                                              i1    => WAY1ShamtMUXinput0res,
                                                                              i2    => instr1_ImmSignExtE,
                                                                              iSel  => shifts1E,
                                                                              iOut  => ALU1input1         
                                                                        ); 
                                                                        
                                                                        
 WAY1SignImmMUX          :        WSsP_2InputMux_32 generic map(32) port map (
                                                                              i1    => WAY1SignImmMUXinput0res,
                                                                              i2    => instr1_ImmSignExtE,
                                                                              iSel  => aluSrc1E,
                                                                              iOut  => ALU1input2         
                                                                        ); 
                                                                        
                                                                        
                      ----------------------------------------------------------------------  
                                    --WAY2 SHAMT MUX  SignImmM  MUX                  
                    ----------------------------------------------------------------------                                                    
                                                                        
 
 
 WAY2ShamtMUX          :        WSsP_2InputMux_32 generic map(32) port map (
                                                                              i1    => WAY2ShamtMUXinput0res,
                                                                              i2    => instr2_ImmSignExtE,
                                                                              iSel  => shifts2E,
                                                                              iOut  => ALU2input1         
                                                                        ); 
                                                                        
                                                                        
 WAY2SignImmMUX          :        WSsP_2InputMux_32 generic map(32) port map (
                                                                              i1    => WAY2SignImmMUXinput0res,
                                                                              i2    => instr2_ImmSignExtE,
                                                                              iSel  => aluSrc2E,
                                                                              iOut  => ALU2input2         
                                                                        ); 
                                                                        
                                                                        
                                                                        
                        ----------------------------------------------------------------------  
                                     --WAY1 ALUOUT                  
                        ----------------------------------------------------------------------                                                  
                                                                        
 WAY1ALU                :       ALU port map (
                                                        ALUinput1   =>  ALU1input1,
                                                        ALUinput2   =>  ALU1input2,
                                                        ALUctrl     =>  aluControl1E,
                                                        output      =>  ALUout1E,
                                                        zero        =>  open,
                                                        carryOut    => open                        
                                                );    
                                                
                                                
                       ----------------------------------------------------------------------  
                                     --WAY1  ALUOUT                  
                        ----------------------------------------------------------------------                                                  
                                                                        
 WAY2ALU                :       ALU port map (
                                                        ALUinput1   =>  ALU2input1,
                                                        ALUinput2   =>  ALU2input2,
                                                        ALUctrl     =>  aluControl2E,
                                                        output      =>  ALUout2E,
                                                        zero        =>  open,
                                                        carryOut    => open                        
                                                );   
                                                
                     HU1_RsE  <=     rs1E;                       
                     HU1_RtE  <=     rt1E;
                     
                     HU2_rsE  <=     rs2E;
                     HU2_rTE  <=     rt2E;                       
                                                
                        ----------------------------------------------------------------------  
                                     --WAY1 prewriteRegMUX            
                        ---------------------------------------------------------------------- 
prewriteRegMUX :       WSsP_2InputMux_32 generic map(5) port map (
                                                                              i1    => rt1E,
                                                                              i2    => rd1E,
                                                                              iSel  => regDst1E,
                                                                              iOut  => WriteRegMuxIn         
                                                                        );                          
                        
                        
                        ----------------------------------------------------------------------  
                                     --WAY1 writeRegMUX                
                        ---------------------------------------------------------------------- 
  WAY1_WriteRegMux  :       WSsP_2InputMux_32 generic map(5) port map (
                                                                              i1    => WriteRegMuxIn,
                                                                              i2    => (others => '1'),
                                                                              iSel  => JalE,
                                                                              iOut  => WriteReg1E         
                                                                 );                             
                        
                        
                        ----------------------------------------------------------------------  
                                     --WAY2 writeRegMUX                 
                        ---------------------------------------------------------------------- 
WAY2_WriteRegMux  :       WSsP_2InputMux_32 generic map(5) port map (
                                                                              i1    => rt2E,
                                                                              i2    => rd2E,
                                                                              iSel  => regDst2E,
                                                                              iOut  => WriteReg2E         
                                                                 );                                                         
                                                                                                                                                                                                                                                  
  HU1_writeRegE <= WriteReg1E;
  HU1_regWriteE <= regWrite1E;
  HU1_memtoRegE <= memtoReg1E;
  
  
  HU2_memtoRegE <= memtoReg2E; 
  HU2_writeRegE <= writeReg2E;
  hu2_regwriteE <= regWrite2e;
 
 
EMREG : EMpipelineReg Port  map( 
 
                   clk                              => clk,  
                   --asyncreset                       => open,
                  
                   pcPLUS4_8E                       =>  pcPLUS4_8E,
                   ALU1outE                         =>  ALUout1E,
                   writeData1E                      =>  WAY1SignImmMUXinput0res,
                   writeReg1E                       =>  WriteReg1E,                 
                  
                   ALU2outE                         => ALUout2E,
                   writeData2E                      => WAY2SignImmMUXinput0res,
                   writeReg2E                       => WriteReg2E,
                  
                   regWrite1E                       => regWrite1E,
                   memtoReg1E                       => memtoReg1E,
                   MemWrite1E                       => memWrite1E,
                   jalE                             => jalE,
                  
                   regWrite2E                       => regWrite2E,
                   memtoReg2E                       => memtoReg2E,
                   MemWrite2E                       => memWrite2E, 
                  
                   pcPLUS4_8M     =>   pcPLUS4_8M,   
                   ALU1outM       =>   ALU1outM,     
                   writeData1M    =>   writeData1M,   
                   writeReg1M     =>   writeReg1M,   
                                               
                   ALU2outM       =>   ALU2outM ,   
                   writeData2M    =>   writeData2M,   
                   writeReg2M     =>   writeReg2M,   
                                                
                    regWrite1M    =>    regWrite1M, 
                    memtoReg1M    =>    memtoReg1M, 
                    MemWrite1M    =>    MemWrite1M, 
                    jalM          =>    jalM     ,   
                                                
                    regWrite2M    =>    regWrite2M, 
                    memtoReg2M    =>    memtoReg2M, 
                    MemWrite2M    =>    MemWrite2M
           
        );
       

  ------------------------------------------------------------------------------------------------------------
                                ------------Memory Stage ------------------------
 -------------------------------------------------------------------------------------------------------------  
                
 
            aluOut1        <=   ALU1outM;     
            aluOut2        <=   ALU2outM;
            writedata1     <=   writeData1M;
            writedata2     <=   writeData2M;        
            memWrite1      <=    MemWrite1M;
            memWrite2      <=    MemWrite2M;
            
            HU1_memtoRegM <= memtoReg1M;          
            HU1_writeRegM <= writeReg1M;
            
            
            hu2_MEMTOrEGm <= memtoreg2m;
            HU2_WriteRegM <= writeReg2M;
            
            
 
            ----------------------------------------------------------------------  
                                     --WAY1 ALUout1Mres MUX                 
            ----------------------------------------------------------------------       
             
  preALUout1Mres_MUX   :    WSsP_2InputMux_32 generic map(32) port map (
                                                                              i1    =>  ALU1outM,
                                                                              i2    =>  pcPLUS4_8M,
                                                                              iSel  => JalM,
                                                                              iOut  =>  ALUout1Mres         
                                                                 );                             
                                
               
            HU1_RegWriteM               <=              regWrite1M;
            HU2_RegWriteM               <=              regWrite2M;
               
                             
             
MWBREG :    MWBpipelineReg Port MAP ( 
                                        clk                     => CLK,      
                                        --asyncreset              => open,
                                       
                                        readData1M              => readData1,
                                        ALUout1M                => ALUout1Mres,
                                       
                                        readData2M              => readData2, 
                                        ALUout2M                => ALU2outM,
                                       
                                        regWrite1M              => regWrite1M,      
                                        memtoReg1M              => memtoReg1M,
                                        writeReg1M              => writeReg1M,
                                                            
                                        regWrite2M              => regWrite2M,
                                        memtoReg2M              => memtoReg2M,
                                        writeReg2M              => writeReg2M,
                                                  
                                        readData1WB             =>  readData1WB,
                                        ALUout1WB               =>   ALUout1WB   ,
                                                                                 
                                        readData2WB             =>   readData2WB ,
                                        ALUout2WB               =>   ALUout2WB   ,
                                                                                 
                                        regWrite1WB             =>   regWrite1WB , 
                                        memtoReg1WB             =>   memtoReg1WB ,
                                        writeReg1WB              => writeReg1WB,
                                                                                 
                                        regWrite2WB             =>   regWrite2WB ,
                                        memtoReg2WB             =>   memtoReg2WB ,
                                        writeReg2WB              =>  writeReg2WB
                                                    
                              );
  
  
  -----------------------------------------------------------------------------------------------------------
                                ------------WriteBack Stage ------------------------
 -------------------------------------------------------------------------------------------------------------                              

                     HU1_RegWriteW               <=              regWrite1WB;
                     HU2_RegWriteW               <=              regWrite2WB;
                     HU2_WriteRegW <= writeReg2WB; 
                     HU1_WriteRegW <= writeReg1WB;
    
                    
   WAY1_RESULT1W_MUX :     WSsP_2InputMux_32 generic map(32) port map (
                                                                              i1    =>  ALUout1WB, 
                                                                              i2    =>  readData1WB,  
                                                                              iSel  =>  memtoReg1WB,
                                                                              iOut  =>  result1W        
                                                                 );   
                                                                 
  WAY2_RESULT1W_MUX :     WSsP_2InputMux_32 generic map(32) port map (
                                                                              i1    =>  ALUout2WB, 
                                                                              i2    =>  readData2WB,  
                                                                              iSel  =>  memtoReg2WB,
                                                                              iOut  =>  result2W        
                                                                 );                                                                             
                                                        
  end Behavioral;          