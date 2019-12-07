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

entity HU2 is -- hazard unit
port(		
		rsD, rtD, rsE, rtE: in STD_LOGIC_VECTOR(4 downto 0);
		
		 writeregM, writeregW: in STD_LOGIC_VECTOR(4 downto 0);
		 regwriteM, regwriteW: in STD_LOGIC;
		
		memtoregE : in STD_LOGIC;
		
		
		forwardaE, forwardbE: out STD_LOGIC_VECTOR(1 downto 0);
		
		stallF, flushE: out STD_LOGIC;
		stallD: inout STD_LOGIC
		);
end HU2;

architecture behave of HU2 is
		signal lwstallD : STD_LOGIC;
begin
			
						
-- forwarding sources to E stage (ALU)
process(rsE, writeregM,rsD, writeregW, regwritem, regwritew, rte) begin
		forwardaE <= "00"; forwardbE <= "00"; 
				if (rsE /= "00000")
					then
						if ((rsE = writeregM) and (regwriteM = '1'))
							then
								forwardaE <= "10";
						elsif ((rsE = writeregW) and (regwriteW = '1')) 
							then
								forwardaE <= "01";
						end if;
				end if;
				
				if (rtE /= "00000") 
					then
						if ((rtE = writeregM) and (regwriteM = '1')) 
							then
								forwardbE <= "10";
						elsif ((rtE = writeregW) and (regwriteW = '1')) 
							then
								forwardbE <= "01";
						end if;
				end if;
				
				
				
				
				
				
end process;
-- stalls
lwstallD <= '1' when ((memtoregE = '1') and ((rtE = rsD) or (rtE = rtD)))
	else '0';
stallD <= lwstallD after 1 ns;	
stallF <= stallD after 1 ns; -- stalling D stalls all previous stages
flushE <= stallD    after 1 ns;-- stalling D flushes next stage
-- not necessary to stall D stage on store if source comes from load;
-- instead, another bypass network could be added from W to M
end behave;

