----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2019 02:38:25 PM
-- Design Name: 
-- Module Name: hazardDetectionUnit - Behavioral
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


library IEEE; use IEEE.STD_LOGIC_1164.all;

entity HU1_INTERPATH is -- hazard unit
port(		
		rsD, rtD, rsE, rtE, rt2E: in STD_LOGIC_VECTOR(4 downto 0);
		
		 writeregM, writeregW: in STD_LOGIC_VECTOR(4 downto 0);
		 regwriteM, regwriteW: in STD_LOGIC;
		
		memtoreg2E : in STD_LOGIC;
		
		branchD       : in std_logic;
		writeRegE     : in std_logic_vector(4 downto 0);
		regWriteE     : in std_logic;
		memtoregM     : in std_logic;
		
		BranchForwardCD, BranchForwardDD : out std_logic;
		forwardCE, forwardDE: out STD_LOGIC_VECTOR(1 downto 0);
		
		stallF, flushE: out STD_LOGIC;
		stallD: inout STD_LOGIC
		);
end HU1_INTERPATH;

architecture behave of HU1_INTERPATH is
		signal lwstallD : STD_LOGIC;
		signal branchstallD : std_logic;
begin
			BranchForwardCD <= '1' when ((rsD /= "00000") and (rsD = writeregM) and(regwriteM = '1'))
				else '0';
					BranchForwardDD <= '1' when ((rtD /= "00000") and (rtD = writeregM) and (regwriteM = '1'))
						else '0';				
						
						
-- forwarding sources to E stage (ALU)
process(rsE, writeregM,rsD, writeregW, regwritem, regwritew, rte) begin
		forwardCE <= "00"; forwardDE <= "00"; 
				if (rsE /= "00000")
					then
						if ((rsE = writeregM) and (regwriteM = '1'))
							then
								forwardCE <= "10";
						elsif ((rsE = writeregW) and (regwriteW = '1')) 
							then
								forwardCE <= "01";
						end if;
				end if;
				
				if (rtE /= "00000") 
					then
						if ((rtE = writeregM) and (regwriteM = '1')) 
							then
								forwardDE <= "10";
						elsif ((rtE = writeregW) and (regwriteW = '1')) 
							then
								forwardDE <= "01";
						end if;
				end if;
				
				
				
				
				
				
end process;

branchstallD <= '1' when ((branchD = '1') and (((regwriteE = '1') and ((writeregE = rsD) or 
(writeregE = rtD))) or ((memtoregM = '1') and((writeregM = rsD) or (writeregM = rtD)))))
else '0';

-- stalls
lwstallD <= '1' when ((memtoreg2E = '1') and ((rt2E = rsD) or (rt2E = rtD)))
	else '0';
stallD <= lwstallD or branchstallD after 1 ns;	
stallF <= stallD after 1 ns; -- stalling D stalls all previous stages
flushE <= stallD    after 1 ns;-- stalling D flushes next stage
-- not necessary to stall D stage on store if source comes from load;
-- instead, another bypass network could be added from W to M
end behave;

