----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2019 07:04:49 PM
-- Design Name: 
-- Module Name: 2WSsPHazardUnit - Behavioral
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

entity WSsPHazardUnit is
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
                        
                        HU2_regWriteE                   : in std_logic;
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
end WSsPHazardUnit;


architecture Behavioral of WSsPHazardUnit is
        signal stallDSig1         : std_logic;
        signal stallDSig2         : std_logic;
        
        --signal HU1_flushESIG : STD_LOGIC
        
        
        
        SIGNAL stallFSIGNAL_HU1    : std_logic;
        SIGNAL stallFSIGNAL_HU2    : std_logic; 
        
        signal flushesignal_HU1    : STD_LOGIC;
        SIGNAL flushesignal_HU2    : STD_LOGIC;
        
        
        
        SIGNAL stallFSIGNAL_INTpath1 :  STD_LOGIC;
        SIGNAL flushE_intpath1          : std_logic; 
        SIGNAL stallD_intpath1          : std_logic; 
            
        SIGNAL stallFSIGNAL_INTpath2 : std_logic; 
        SIGNAL flushE_intpath2 : std_logic; 
        SIGNAL stallD_intpath2 : std_logic; 
        
        
        
        component  HU is -- hazard unit
                   port(		
                   		rsD            : in STD_LOGIC_VECTOR(4 downto 0); 
                   		rtD            : in STD_LOGIC_VECTOR(4 downto 0); 
                   		rsE            : in STD_LOGIC_VECTOR(4 downto 0); 
                   		rtE            : in STD_LOGIC_VECTOR(4 downto 0);
        
                   		writeregE      : in STD_LOGIC_VECTOR(4 downto 0); 
                   		writeregM      : in STD_LOGIC_VECTOR(4 downto 0); 
                   		writeregW      : in STD_LOGIC_VECTOR(4 downto 0);
                   		regwriteE      :in STD_LOGIC; 
                   		regwriteM      :in STD_LOGIC; 
                   		regwriteW      :in STD_LOGIC;
        
                   		memtoregE      : in STD_LOGIC; 
                   		memtoregM      : in STD_LOGIC; 
                   		branchD        : in STD_LOGIC; 
                   		jumpD          : in STD_LOGIC; 
                   		jrD            : in STD_LOGIC;
        
                   		forwardaD      : out STD_LOGIC;
                   		forwardbD      : out STD_LOGIC;
                   		forwardaE      : out STD_LOGIC_VECTOR(1 downto 0); 
                   		forwardbE      : out STD_LOGIC_VECTOR(1 downto 0); 
                   		newForwardAE   : out STD_LOGIC_VECTOR(1 downto 0);
        
                   		stallF         : out STD_LOGIC; 
                   		flushE         : out STD_LOGIC;
                   		stallD         : inout STD_LOGIC
                   		);
        end component;
        
        
        
        component HU2 is -- hazard unit
                    port(		
                            rsD             : in STD_LOGIC_VECTOR(4 downto 0); 
                            rtD             : in STD_LOGIC_VECTOR(4 downto 0); 
                            rsE             : in STD_LOGIC_VECTOR(4 downto 0); 
                            rtE             : in STD_LOGIC_VECTOR(4 downto 0);
                            
                            
                            writeregM       : in STD_LOGIC_VECTOR(4 downto 0); 
                            writeregW       : in STD_LOGIC_VECTOR(4 downto 0);
                            
                            regwriteM       : in STD_LOGIC; 
                            regwriteW       : in STD_LOGIC;
                            
                            memtoregE       : in STD_LOGIC; 
                            
                            
                            
                            forwardaE       : out STD_LOGIC_VECTOR(1 downto 0);
                            forwardbE       : out STD_LOGIC_VECTOR(1 downto 0);
                            
                            stallF          : out STD_LOGIC; 
                            flushE          : out STD_LOGIC;
                            stallD          : inout STD_LOGIC
                            );
        end component;
        
        component HU_INTERPATH is -- hazard unit
            port(		
                            rsD             : in STD_LOGIC_VECTOR(4 downto 0); 
                            rtD             : in STD_LOGIC_VECTOR(4 downto 0); 
                            rsE             : in STD_LOGIC_VECTOR(4 downto 0); 
                            rtE             : in STD_LOGIC_VECTOR(4 downto 0);
                            
                             rt2E             : in STD_LOGIC_VECTOR(4 downto 0);
                            
                            
                            writeregM       : in STD_LOGIC_VECTOR(4 downto 0); 
                            writeregW       : in STD_LOGIC_VECTOR(4 downto 0);
                            
                            regwriteM       : in STD_LOGIC; 
                            regwriteW       : in STD_LOGIC;
                            
                            memtoreg2E       : in STD_LOGIC; 
                            
                            
                            
                            forwardCE       : out STD_LOGIC_VECTOR(1 downto 0);
                            forwardDE       : out STD_LOGIC_VECTOR(1 downto 0);
                            
                            stallF          : out STD_LOGIC; 
                            flushE          : out STD_LOGIC;
                            stallD          : inout STD_LOGIC
                    );
            end component;
            
            component HU1_INTERPATH is -- hazard unit
            port(		
                            rsD             : in STD_LOGIC_VECTOR(4 downto 0); 
                            rtD             : in STD_LOGIC_VECTOR(4 downto 0); 
                            rsE             : in STD_LOGIC_VECTOR(4 downto 0); 
                            rtE             : in STD_LOGIC_VECTOR(4 downto 0);
                            
                             rt2E             : in STD_LOGIC_VECTOR(4 downto 0);
                            
                            
                            writeregM       : in STD_LOGIC_VECTOR(4 downto 0); 
                            writeregW       : in STD_LOGIC_VECTOR(4 downto 0);
                            
                            regwriteM       : in STD_LOGIC; 
                            regwriteW       : in STD_LOGIC;
                            
                            memtoreg2E       : in STD_LOGIC;
                            
                            branchD       : in std_logic;                     
                            writeRegE     : in std_logic_vector(4 downto 0);  
                            regWriteE     : in std_logic;                     
                            memtoregM     : in std_logic;                      
                            
                            
                            BranchForwardCD  : out std_logic; 
                            BranchForwardDD  : out std_logic;
                            forwardCE       : out STD_LOGIC_VECTOR(1 downto 0);
                            forwardDE       : out STD_LOGIC_VECTOR(1 downto 0);
                            
                            stallF          : out STD_LOGIC; 
                            flushE          : out STD_LOGIC;
                            stallD          : inout STD_LOGIC
                    );
            end component;
begin

         WAY1HU:   HU port MAP (		
                   		rsD              =>   HU1_RsD  ,
                   		rtD              =>   HU1_RtD  ,
                   		rsE              =>   HU1_RsE  ,
                   		rtE              =>   HU1_RtE  ,
                                         
                   		writeregE        =>   HU1_writeRegE,
                   		writeregM        =>   HU1_writeRegM,
                   		writeregW        =>   HU1_writeregW,
                   		regwriteE        =>   HU1_regWriteE,
                   		regwriteM        =>   HU1_regWriteM,
                   		regwriteW        =>   HU1_regWriteW,
                                         
                   		memtoregE        =>   HU1_memtoRegE,
                   		memtoregM        =>   HU1_memtoRegM,
                   		branchD          =>   HU1_branchD,
                   		jumpD            =>   HU1_JumpD,
                   		jrD              =>   HU1_JrD,
                                          
                   		forwardaD        =>   HU1_forwardAD,
                   		forwardbD        =>   HU1_forwardBD,
                   		forwardaE        =>   HU1_forwardAE,
                   		forwardbE        =>   hu1_forwardBE,
                   		newForwardAE     =>   HU1_forwardCD,
                                         
                   		stallF           =>   stallFSIGNAL_HU1,
                   		flushE           =>   flushesignal_HU1,
                   		stallD           =>   stallDSig1
                   		);
                   		
                   		
                   		
       WAY2HU:   HU2 port MAP (		
                                            rsD           =>   HU2_RsD,
                                            rtD           =>   HU2_Rtd,
                                            rsE           =>   HU2_RsE,
                                            rtE           =>   HU2_RtE,
                                                          
                                            
                                            writeregM     =>   HU2_writeRegM,
                                            writeregW     =>   HU2_writeRegW,
                                            
                                            regwriteM     =>   HU2_regWriteM,
                                            regwriteW     =>   HU2_regWriteW,
                                                          
                                            memtoregE     =>   HU2_memtoRegE,
                                            
                                                          
                                                           
                                            forwardaE     =>   HU2_forwardAE,
                                            forwardbE     =>   HU2_forwardBE,
                                                           
                                            stallF        =>   stallFSIGNAL_HU2,
                                            flushE        =>   flushesignal_HU2,
                                            stallD        =>   stallDSig2                                                                		                        		       
                   		);
                   	
                   	HU1_StallF  <= stallFSIGNAL_HU1 or stallFSIGNAL_INTpath1;
                   	HU2_StallF  <= stallFSIGNAL_HU2 or stallFSIGNAL_INTpath2;
                   	
                   	
                   	
                   	HU1_StallD  <= stallDSig1 or stallD_intpath1 ;
                   	HU2_StallD 	<= stallDSig2 or stallD_intpath2 ;
                   	
                   	HU1_FlushE  <=  flushesignal_HU1 OR  flushE_intpath1;
                   	HU2_FlushE  <=  flushesignal_HU2 OR  flushE_intpath2;
                   	
                   	
                   	
                   	
 HU_INTERPATH1:        HU1_INTERPATH  port MAP(	
 	
                            rsD             =>     HU1_RsD,
                            rtD             =>     HU1_Rtd,
                            rsE             =>     HU1_RsE,
                            rtE             =>     HU1_RtE,
                            
                            rt2E            =>     HU2_RtE,
                           
                           
                            writeregM      =>   HU2_writeRegM,  
                            writeregW      =>   HU2_writeRegW,  
                           
                            regwriteM      =>   HU2_regWriteM,  
                            regwriteW      =>   HU2_regWriteW,  
                           
                            memtoreg2E      =>   HU2_memtoRegE,
                            
                             branchD       => hu1_BRANCHd,
                            
                             writeRegE     => HU2_WRITEREGE,
                             
                             regWriteE     => HU2_regwriteE, 
                            
                             memtoregM     => HU2_memtoreGm,
                           
                           
                            forwardCE      =>   HU1_ForwardCE,  
                            forwardDE      =>   HU1_forwardDE, 
                            BranchForwardCD  =>    HU1_BranchForwardCD  ,
                            BranchForwardDD  =>    HU1_BranchForwardDD  ,
                            stallF         =>    stallFSIGNAL_INTpath1,   
                            flushE         =>    flushE_intpath1      ,   
                            stallD         =>    stallD_intpath1         
                    );
                    
                    
HU_INTERPATH2:        HU_INTERPATH  port MAP(	
 	
                            rsD             =>     HU2_RsD,
                            rtD             =>     HU2_Rtd,
                            rsE             =>     HU2_RsE,
                            rtE             =>     HU2_RtE,
                            
                            rt2E            =>     HU1_RtE,
                           
                           
                            writeregM      =>   HU1_writeRegM,  
                            writeregW      =>   HU1_writeRegW,  
                           
                            regwriteM      =>   HU1_regWriteM,  
                            regwriteW      =>   HU1_regWriteW,  
                           
                            memtoreg2E      =>   HU1_memtoRegE,  
                           
                           
                           
                            forwardCE      =>   HU2_ForwardCE,  
                            forwardDE      =>   Hu2_forwardDE,  
                           
                            stallF         =>    stallFSIGNAL_INTpath2,   
                            flushE         =>    flushE_intpath2      ,   
                            stallD         =>    stallD_intpath2         
                    );
                   	
                   	
                   	
                   	
          

        
end Behavioral;
