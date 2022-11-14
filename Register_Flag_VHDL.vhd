--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : Register_Flag_VHDL															==
--== Notes		: "Design is based on a one bit register. The no. inputs have	==
--==              been increased to two bits for the two flags. Here, I have	==
--==              opted to make the most effect of VHDL by ignoring the 		==
--==              logic+dff components. Instead, the register is directly		==
--==              implemented based on the simple desired outcome (truth		==
--==              table)."                                                    == 
--==              "One thing to note is the pull up resistor in 				==
--==              eddiewashere's logic circuit. Investigation into their		==
--==              schematic may be necessary later.                           ==                                              ==	
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY Register_Flag_VHDL IS 
	PORT
	(
		FLAG_CLR 	:  IN  STD_LOGIC;
		CLK 			:  IN  STD_LOGIC;
		FLAG_LOAD	:  IN  STD_LOGIC;
		CARRY			:  IN  STD_LOGIC;
		ZERO			:  IN  STD_LOGIC;
		CF				:  OUT  STD_LOGIC;
		ZF				:	OUT  STD_LOGIC
	);
END Register_Flag_VHDL;

ARCHITECTURE bhv_regflag OF Register_Flag_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
		-- n/a
	
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------
SIGNAL cf_signal	:	STD_LOGIC;
SIGNAL zf_signal	:	STD_LOGIC;
	
	BEGIN 
	
   --------------------------------------------------------------------------------
   -- Here all input connections are defined                                     --
   --------------------------------------------------------------------------------
		-- n/a
	
   --------------------------------------------------------------------------------
   -- Here all output connections are defined                                    --
   --------------------------------------------------------------------------------
	CF <= cf_signal;
	ZF <= zf_signal;
	
   --------------------------------------------------------------------------------
   -- Here all normal components are defined                                     --
   --------------------------------------------------------------------------------
	PROCESS(FLAG_CLR, CLK, FLAG_LOAD)
		BEGIN
			IF (FLAG_CLR = '1') THEN							-- clear flags
				cf_signal 	<= '0';
				zf_signal  	<= '0';
			ELSIF (RISING_EDGE(CLK)) THEN				
				IF (FLAG_LOAD = '1') THEN						-- load value
					cf_signal <= CARRY;
					zf_signal <= ZERO;
				ELSE
					cf_signal <= '0';
					zf_signal <= '0';
				END IF;
			END IF;											-- retain old values if no if case succeeds
	END PROCESS;


END bhv_regflag;
