--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : dff_VHDL																		==
--== Notes		: "As in eddiewastaken's logisim CPU, the dff here behaves		==
--==              as a 'Dual D-Type Positive-Edge-Triggered Flip-Flops			==
--==              With Preset And Clear', see truth table in eddiewastaken's  ==
--==              CPU design document for reference (when PRE and CLR = '1',  ==   
--==              then both Q and Q' = '1')."                                 ==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY dff_VHDL IS
	PORT
	(
		PRE 	:  IN  STD_LOGIC;
		CLR 	:  IN  STD_LOGIC;
		CLK 	:  IN  STD_LOGIC;
		D 		:  IN  STD_LOGIC;
		Q 		:  OUT  STD_LOGIC;
		Q_NOT :  OUT  STD_LOGIC
	);
END dff_VHDL;


ARCHITECTURE bhv_dff OF dff_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
		-- n/a components
	
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------
SIGNAL	dff_q, dff_not_q	: STD_LOGIC;

	BEGIN

   --------------------------------------------------------------------------------
   -- Here all input connections are defined                                     --
   --------------------------------------------------------------------------------
		-- n/a
	
   --------------------------------------------------------------------------------
   -- Here all output connections are defined                                    --
   --------------------------------------------------------------------------------
	Q <= dff_q;
	Q_NOT <= dff_not_q;
	
   --------------------------------------------------------------------------------
   -- Here all normal components are defined                                     --
   --------------------------------------------------------------------------------
	PROCESS(PRE, CLR, CLK)
		BEGIN
			IF (CLR = '1') AND (PRE = '1') THEN		-- clear and preset q
				dff_q    	<= '1';
				dff_not_q 	<= '1';
			ELSIF (CLR = '1') THEN						-- clear q
				dff_q    	<= '0';
				dff_not_q 	<= '1';
			ELSIF (PRE = '1') THEN						-- preset q
				dff_q    	<= '1';
				dff_not_q	<= '0';
			ELSIF (RISING_EDGE(CLK)) THEN				-- record d if clk active
				dff_q 		<= D;
				dff_not_q	<= NOT(D);
			END IF;											-- retain old values if no if case succeeds
	END PROCESS;


END bhv_dff;
