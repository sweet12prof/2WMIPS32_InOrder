----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2019 08:11:12 AM
-- Design Name: 
-- Module Name: twoWaySsProcessor - Behavioral
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

entity twoWaySsProcessor is
 Port ( 
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
                memWrite2                       : out std_logic
            
       );
end twoWaySsProcessor;

architecture Behavioral of twoWaySsProcessor is
    component WSsPControlUnit is
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
    end component;
    
    component WSsPHazardUnit is
         Port (     
                                HU1_StallF                      : out std_logic;                          
                                HU1_StallD                      : out std_logic;                          
                                HU1_FlushE                      : out std_logic;                          
                                HU1_ForwardAD                   : out std_logic;                          
                                HU1_ForwardBD                   : out std_logic; 
                                
                                HU1_BranchForwardCD                   : out std_logic;
                                HU1_BranchForwardDD                   : out std_logic;                         
                                
                                HU1_ForwardAE                   : out std_logic_vector(1 downto 0);       
                                HU1_ForwardBE                   : out std_logic_vector(1 downto 0);  
                                
                                HU1_ForwardCE                   : out std_logic_vector(1 downto 0);
                                HU1_ForwardDE                   : out std_logic_vector(1 downto 0);
                                     
                                HU1_ForwardCD                   : out std_logic_vector(1 downto 0);       
                                HU1_BranchD                     : in std_logic;                         
                                HU1_JumpD                       : in std_logic;                         
                                HU1_JrD                         : in std_logic;                         
                                HU1_memtoRegE                   : in std_logic;                         
                                HU1_memtoRegM                   : in std_logic;                         
                                HU1_RegWriteE                   : in std_logic;                         
                                HU1_RegWriteM                   : in std_logic;                         
                                HU1_regWriteW                   : in std_logic;                         
                                HU1_writeRegE                   : in std_logic_vector(4 downto 0);      
                                HU1_writeRegM                   : in std_logic_vector(4 downto 0);      
                                HU1_writeRegW                   : in std_logic_vector(4 downto 0);      
                                HU1_RsD                         : in std_logic_vector(4 downto 0);      
                                HU1_RtD                         : in std_logic_vector(4 downto 0);      
                                HU1_RsE                         : in std_logic_vector(4 downto 0);      
                                HU1_RtE                         : in std_logic_vector(4 downto 0);      
                                                                                                         
                                                                                                         
                                HU2_StallF                      : out std_logic;
                                HU2_StallD                      : out std_logic;
                                HU2_FlushE                      : out std_logic;
                                HU2_ForwardAE                   : out std_logic_vector(1 downto 0);
                                HU2_ForwardBE                   : out std_logic_vector(1 downto 0);
                                
                                HU2_ForwardCE                   : out std_logic_vector(1 downto 0);
                                HU2_ForwardDE                   : out std_logic_vector(1 downto 0);
                                
                                HU2_memtoRegE                   : in std_logic;
                                HU2_memtoRegM                   : in std_logic;
                                
                                HU2_regwriteE                   : in std_logic;
                                HU2_RegWriteM                   : in std_logic;
                                HU2_regWriteW                   : in std_logic;
                                
                                HU2_writeRegE                   : in std_logic_vector(4 downto 0);
                                HU2_writeRegM                   : in std_logic_vector(4 downto 0);
                                HU2_writeRegW                   : in std_logic_vector(4 downto 0);
                                HU2_RsD                         : in std_logic_vector(4 downto 0);
                                HU2_RtD                         : in std_logic_vector(4 downto 0);
                                HU2_RsE                         : in std_logic_vector(4 downto 0);
                                HU2_RtE                         : in std_logic_vector(4 downto 0)
                    );
        end component;
        
  component Datapath
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
                                HU2_memtoRegM                   : out std_logic;
                                
                                HU2_RegWriteE                   : out std_logic;
                                HU2_RegWriteM                   : out std_logic;
                                HU2_regWriteW                   : out std_logic;
                                
                                HU2_writeRege                   : out std_logic_vector(4 downto 0);
                                HU2_writeRegM                   : out std_logic_vector(4 downto 0);
                                HU2_writeRegW                   : out std_logic_vector(4 downto 0);
                                HU2_RsD                         : out std_logic_vector(4 downto 0);
                                HU2_RtD                         : out std_logic_vector(4 downto 0);
                                HU2_RsE                         : out std_logic_vector(4 downto 0);
                                HU2_RtE                         : out std_logic_vector(4 downto 0)
                        );
    end component;
        
        signal                CU1_memtoregD                   :  std_logic;
        signal                CU1_pcSrcD                      :  std_logic_vector(3 downto 0);
        signal                CU1_alusrcD                     :  std_logic;
        signal                CU1_regDstD                     :  std_logic;
        signal                CU1_regWriteD                   :  std_logic;
        signal                CU1_memWriteD                   :  std_logic;
        signal                CU1_BranchD                     :  std_logic;
        signal                CU1_JumpD                       :  std_logic;
        signal                CU1_shiftsD                     :  std_logic;
        signal                CU1_jalD                        :  std_logic;
        signal                CU1_jrD                         :  std_logic;
        signal                CU1_aluControlD                 :  std_logic_vector(3 downto 0);
        signal                CU1_opcodeD                     : std_logic_vector(5 downto 0);
        signal                CU1_functD                      : std_logic_vector(5 downto 0);
        signal                CU1_equalD                      : std_logic;
        signal                CU1_haltCPU                     :  std_logic;
                       
                        ---------wAY2------------------------------
        signal                CU2_memtoregD                   :  std_logic;
        signal                CU2_alusrcD                     :  std_logic;
        signal                CU2_regDstD                     :  std_logic;
        signal                CU2_regWriteD                   :  std_logic;
        signal                CU2_memWriteD                   :  std_logic;
        signal                CU2_shiftsD                     :  std_logic;
        signal                CU2_aluControlD                 :  std_logic_vector(3 downto 0);
        signal                CU2_opcodeD                     : std_logic_vector(5 downto 0);
        signal                CU2_functD                      : std_logic_vector(5 downto 0);
        
        
          signal                      HU1_StallF                      :  std_logic;                          
          signal                      HU1_StallD                      :  std_logic;                          
          signal                      HU1_FlushE                      :  std_logic;                          
          signal                      HU1_ForwardAD                   :  std_logic;                          
          signal                      HU1_ForwardBD                   :  std_logic;      
          SIGNAL                      HU1_BranchForwardCD                   :  std_logic;
           SIGNAL                     HU1_BranchForwardDD                   :  std_logic;                      
          signal                      HU1_ForwardAE                   :  std_logic_vector(1 downto 0);       
          signal                      HU1_ForwardBE                   :  std_logic_vector(1 downto 0); 
               
          signal                      HU1_ForwardCE                   :  std_logic_vector(1 downto 0);       
          signal                      HU1_ForwardDE                   :  std_logic_vector(1 downto 0);   
            
          signal                      HU1_ForwardCD                   :  std_logic_vector(1 downto 0);       
          signal                      HU1_BranchD                     : std_logic;                         
          signal                      HU1_JumpD                       : std_logic;                         
          signal                      HU1_JrD                         : std_logic;                         
          signal                      HU1_memtoRegE                   : std_logic;                         
          signal                      HU1_memtoRegM                   : std_logic;                         
          signal                      HU1_RegWriteE                   : std_logic;                         
          signal                      HU1_RegWriteM                   : std_logic;                         
          signal                      HU1_regWriteW                   : std_logic;                         
          signal                      HU1_writeRegE                   : std_logic_vector(4 downto 0);      
          signal                      HU1_writeRegM                   : std_logic_vector(4 downto 0);      
          signal                      HU1_writeRegW                   : std_logic_vector(4 downto 0);      
          signal                      HU1_RsD                         : std_logic_vector(4 downto 0);      
          signal                      HU1_RtD                         : std_logic_vector(4 downto 0);      
          signal                      HU1_RsE                         : std_logic_vector(4 downto 0);      
          signal                      HU1_RtE                         : std_logic_vector(4 downto 0);      
                                                                                                     
                                                                                                     
          signal                      HU2_StallF                      :  std_logic;
          signal                      HU2_StallD                      :  std_logic;
          signal                      HU2_FlushE                      :  std_logic;
          signal                      HU2_ForwardAE                   :  std_logic_vector(1 downto 0);
          signal                      HU2_ForwardBE                   :  std_logic_vector(1 downto 0);
          
          signal                      HU2_ForwardCE                   :  std_logic_vector(1 downto 0);       
          signal                      HU2_ForwardDE                   :  std_logic_vector(1 downto 0);  
          
          signal                      HU2_memtoRegE                   : std_logic;
          signal                      HU2_memtoRegm                   : std_logic;
                               
          signal                      HU2_RegWritee                   : std_logic;
          signal                      HU2_RegWriteM                   : std_logic;
          signal                      HU2_regWriteW                   : std_logic;
          
          signal                      HU2_writeRege                   : std_logic_vector(4 downto 0);                     
          signal                      HU2_writeRegM                   : std_logic_vector(4 downto 0);
          signal                      HU2_writeRegW                   : std_logic_vector(4 downto 0);
          signal                      HU2_RsD                         : std_logic_vector(4 downto 0);
          signal                      HU2_RtD                         : std_logic_vector(4 downto 0);
          signal                      HU2_RsE                         : std_logic_vector(4 downto 0);
          signal                      HU2_RtE                         : std_logic_vector(4 downto 0);
        
        
        
        


begin
        CU: WSsPControlUnit  port map  ( 
                        CU1_memtoregD        =>    CU1_memtoregD,             
                        CU1_pcSrcD           =>    CU1_pcSrcD      ,             
                        CU1_alusrcD          =>    CU1_alusrcD     ,             
                        CU1_regDstD          =>    CU1_regDstD     ,             
                        CU1_regWriteD        =>    CU1_regWriteD   ,             
                        CU1_memWriteD        =>    CU1_memWriteD   ,             
                        CU1_BranchD          =>    CU1_BranchD     ,             
                        CU1_JumpD            =>    CU1_JumpD       ,             
                        CU1_shiftsD          =>    CU1_shiftsD     ,             
                        CU1_jalD             =>    CU1_jalD        ,             
                        CU1_jrD              =>    CU1_jrD         ,             
                        CU1_aluControlD      =>    CU1_aluControlD ,             
                        CU1_opcodeD          =>    CU1_opcodeD     ,             
                        CU1_functD           =>    CU1_functD      ,             
                        CU1_equalD           =>    CU1_equalD      ,             
                        CU1_haltCPU          =>    CU1_haltCPU     ,             
                                                                   
                        ---------wAY2--------=>    ---------wAY2---,-------------
                        CU2_memtoregD        =>    CU2_memtoregD   ,             
                        CU2_alusrcD          =>    CU2_alusrcD     ,             
                        CU2_regDstD          =>    CU2_regDstD     ,             
                        CU2_regWriteD        =>    CU2_regWriteD   ,             
                        CU2_memWriteD        =>    CU2_memWriteD   ,             
                        CU2_shiftsD          =>    CU2_shiftsD     ,             
                        CU2_aluControlD      =>    CU2_aluControlD ,             
                        CU2_opcodeD          =>    CU2_opcodeD     ,             
                        CU2_functD           =>    CU2_functD                   
                        
                );
       
       
       HU : WSsPHazardUnit port map(
       
                                            HU1_StallF                 =>        HU1_StallF     , 
                                            HU1_StallD                 =>        HU1_StallD     , 
                                            HU1_FlushE                 =>        HU1_FlushE     , 
                                            HU1_BranchForwardCD        =>        HU1_BranchForwardCD ,
                                            HU1_BranchForwardDD        =>        HU1_BranchForwardDD ,
                                            HU1_ForwardAD              =>        HU1_ForwardAD  , 
                                            HU1_ForwardBD              =>        HU1_ForwardBD  , 
                                            HU1_ForwardAE              =>        HU1_ForwardAE  , 
                                            HU1_ForwardBE              =>        HU1_ForwardBE  , 
                                            
                                            
                                            
                                            HU1_ForwardcE              =>        HU1_ForwardcE  , 
                                            HU1_ForwarddE              =>        HU1_ForwarddE  , 
                                            
                                            HU1_ForwardCD              =>        HU1_ForwardCD  , 
                                            HU1_BranchD                =>        HU1_BranchD    , 
                                            HU1_JumpD                  =>        HU1_JumpD      , 
                                            HU1_JrD                    =>        HU1_JrD        , 
                                            HU1_memtoRegE              =>        HU1_memtoRegE  , 
                                            HU1_memtoRegM              =>        HU1_memtoRegM  , 
                                           
                                            HU1_RegWriteE              =>        HU1_RegWriteE  , 
                                            HU1_RegWriteM              =>        HU1_RegWriteM  , 
                                            HU1_regWriteW              =>        HU1_regWriteW  , 
                                            HU1_writeRegE              =>        HU1_writeRegE  , 
                                            HU1_writeRegM              =>        HU1_writeRegM  , 
                                            HU1_writeRegW              =>        HU1_writeRegW  , 
                                            HU1_RsD                    =>        HU1_RsD        , 
                                            HU1_RtD                    =>        HU1_RtD        , 
                                            HU1_RsE                    =>        HU1_RsE        , 
                                            HU1_RtE                    =>        HU1_RtE        , 
                                                                                                
                                                                                             
                                            HU2_StallF                 =>        HU2_StallF     , 
                                            HU2_StallD                 =>        HU2_StallD     , 
                                            HU2_FlushE                 =>        HU2_FlushE     , 
                                            HU2_ForwardAE              =>        HU2_ForwardAE  , 
                                            HU2_ForwardBE              =>        HU2_ForwardBE  , 
                                            
                                            HU2_ForwardcE              =>        HU2_ForwardcE  , 
                                            HU2_ForwarddE              =>        HU2_ForwarddE  , 
                                            
                                            HU2_memtoRegE              =>        HU2_memtoRegE  , 
                                            HU2_memtoRegm              =>        HU2_memtoRegm  , 
                                            
                                            HU2_RegWritee              =>        HU2_RegWritee  ,                                                     
                                            HU2_RegWriteM              =>        HU2_RegWriteM  , 
                                            HU2_regWriteW              =>        HU2_regWriteW  , 
                                                                                                
                                            HU2_writeRege              =>        HU2_writeRege  ,
                                            HU2_writeRegM              =>        HU2_writeRegM  , 
                                            HU2_writeRegW              =>        HU2_writeRegW  , 
                                            HU2_RsD                    =>        HU2_RsD        , 
                                            HU2_RtD                    =>        HU2_RtD        , 
                                            HU2_RsE                    =>        HU2_RsE        , 
                                            HU2_RtE                    =>        HU2_RtE         
                                    
                                    );
                
      
     TwoSsPDatapath: Datapath  Port map ( 
                --------------------    INPUTS    ----------------------------------            
                                clk                               =>   clk,
                                reset                             =>   reset,
                                                                  
                                pc                                =>   pc        ,
                                instr1                            =>   instr1    ,
                                instr2                            =>   instr2    ,
                                aluOut1                           =>   aluOut1   ,
                                aluOut2                           =>   aluOut2   ,
                                writedata1                        =>   writedata1,
                                writedata2                        =>   writedata2,
                                readData1                         =>   readData1 ,
                                readData2                         =>   readData2 ,
                                memWrite1                         =>   memWrite1 ,
                                memWrite2                         =>   memWrite2 ,
                                                                  
                                                                  
                                -------WAY 1--------------------  =>
                                CU1_memtoregD                     =>      CU1_memtoregD,     
                                CU1_pcSrcD                        =>      CU1_pcSrcD      ,  
                                CU1_alusrcD                       =>      CU1_alusrcD     ,  
                                CU1_regDstD                       =>      CU1_regDstD     ,  
                                CU1_regWriteD                     =>      CU1_regWriteD   ,  
                                CU1_memWriteD                     =>      CU1_memWriteD   ,  
                                CU1_BranchD                       =>      CU1_BranchD     ,  
                                CU1_JumpD                         =>      CU1_JumpD       ,  
                                CU1_shiftsD                       =>      CU1_shiftsD     ,  
                                CU1_jalD                          =>      CU1_jalD        ,  
                                CU1_jrD                           =>      CU1_jrD         ,  
                                CU1_aluControlD                   =>      CU1_aluControlD ,  
                                CU1_opcodeD                       =>      CU1_opcodeD     ,  
                                CU1_functD                        =>      CU1_functD      ,  
                                CU1_equalD                        =>      CU1_equalD      ,  
                                CU1_haltCPU                       =>      CU1_haltCPU     ,  
                                                                
                                ---------wAY2-------------------          ---------wAY2---,--
                                CU2_memtoregD                     =>      CU2_memtoregD   ,  
                                CU2_alusrcD                       =>      CU2_alusrcD     ,  
                                CU2_regDstD                       =>      CU2_regDstD     ,  
                                CU2_regWriteD                     =>      CU2_regWriteD   ,  
                                CU2_memWriteD                     =>      CU2_memWriteD   ,  
                                CU2_shiftsD                       =>      CU2_shiftsD     ,  
                                CU2_aluControlD                   =>      CU2_aluControlD ,  
                                CU2_opcodeD                       =>      CU2_opcodeD     ,  
                                CU2_functD                        =>      CU2_functD ,        
                                                                  
                                                                  
                                HU1_StallF                        =>       HU1_StallF     , 
                                HU1_StallD                        =>       HU1_StallD     , 
                                HU1_FlushE                        =>       HU1_FlushE     , 
                                HU1_ForwardAD                     =>       HU1_ForwardAD  , 
                                HU1_ForwardBD                     =>       HU1_ForwardBD  , 
                                HU1_BranchForwardCD               =>   HU1_BranchForwardCD ,                  
                                HU1_BranchForwardDD               =>   HU1_BranchForwardDD ,                  
                                
                                HU1_ForwardAE                     =>       HU1_ForwardAE  , 
                                HU1_ForwardBE                     =>       HU1_ForwardBE  , 
                                
                                HU1_ForwardcE                     =>       HU1_ForwardcE  , 
                                HU1_ForwarddE                     =>       HU1_ForwarddE  , 
                                
                                HU1_ForwardCD                     =>       HU1_ForwardCD  , 
                                HU1_BranchD                       =>       HU1_BranchD    , 
                                HU1_JumpD                         =>       HU1_JumpD      , 
                                HU1_JrD                           =>       HU1_JrD        , 
                                HU1_memtoRegE                     =>       HU1_memtoRegE  , 
                                HU1_memtoRegM                     =>       HU1_memtoRegM  , 
                                HU1_RegWriteE                     =>       HU1_RegWriteE  , 
                                HU1_RegWriteM                     =>       HU1_RegWriteM  , 
                                HU1_regWriteW                     =>       HU1_regWriteW  , 
                                HU1_writeRegE                     =>       HU1_writeRegE  , 
                                HU1_writeRegM                     =>       HU1_writeRegM  , 
                                HU1_writeRegW                     =>       HU1_writeRegW  , 
                                HU1_RsD                           =>       HU1_RsD        , 
                                HU1_RtD                           =>       HU1_RtD        , 
                                HU1_RsE                           =>       HU1_RsE        , 
                                HU1_RtE                           =>       HU1_RtE        , 
                                
                                                                 
                                HU2_StallF                        =>       HU2_StallF     , 
                                HU2_StallD                        =>       HU2_StallD     , 
                                HU2_FlushE                        =>       HU2_FlushE     , 
                                HU2_ForwardAE                     =>       HU2_ForwardAE  , 
                                HU2_ForwardBE                     =>       HU2_ForwardBE  , 
                                
                                HU2_ForwardcE                     =>       HU2_ForwardcE  , 
                                HU2_ForwarddE                     =>       HU2_ForwarddE  , 
                                
                                HU2_memtoRegE                     =>       HU2_memtoRegE  , 
                                HU2_memtoRegm                     =>       HU2_memtoRegm  , 
                                
                                HU2_RegWritee                     =>       HU2_RegWritee  ,                                   
                                HU2_RegWriteM                     =>       HU2_RegWriteM  , 
                                HU2_regWriteW                     =>       HU2_regWriteW  , 
                                
                                HU2_writeRege                     =>       HU2_writeRege  ,                                                                                      
                                HU2_writeRegM                     =>       HU2_writeRegM  , 
                                HU2_writeRegW                     =>       HU2_writeRegW  , 
                                HU2_RsD                           =>       HU2_RsD        , 
                                HU2_RtD                           =>       HU2_RtD        , 
                                HU2_RsE                           =>       HU2_RsE        , 
                                HU2_RtE                           =>       HU2_RtE          
                        );






















































































































end Behavioral;
