--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : Buffer_4bit_VHDL															==
--== Notes		: "As in eddiewastaken's logisim CPU, we have also decided		==
--==              to design up to a 4-bit buffer in order to reflect the		==
--==              real IC chips that are used in physical CPU's."         	   ==
--==                                                                          == 
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY Buffer_4bit_VHDL IS
	PORT
		(
				E			:	IN  STD_LOGIC;
				D 		 	:  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);	-- 'A' in eddie doc
				Q 			:  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)	-- 'S' in eddie doc
		);
END Buffer_4bit_VHDL;


ARCHITECTURE bhv_buffer4 OF Buffer_4bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
		-- n/a components
	
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------
	-- n/a signals

	BEGIN

   --------------------------------------------------------------------------------
   -- Here all input connections are defined                                     --
   --------------------------------------------------------------------------------
		-- n/a
	
   --------------------------------------------------------------------------------
   -- Here all output connections are defined                                    --
   --------------------------------------------------------------------------------
		-- n/a
	
   --------------------------------------------------------------------------------
   -- Here all normal components are defined                                     --
   --------------------------------------------------------------------------------

	PROCESS(D(0),E)
		BEGIN
			if (E = '1') THEN
				Q(0) <= D(0);
			ELSE
				Q(0) <= 'Z';					-- 'Z' is high impedance signal 
			END IF;								-- (to force no output from input)
	END PROCESS;


	PROCESS(D(1),E)
		BEGIN
			if (E = '1') THEN
				Q(1) <= D(1);
			ELSE
				Q(1) <= 'Z';
			END IF;
	END PROCESS;

	PROCESS(D(2),E)
		BEGIN
			if (E = '1') THEN
				Q(2) <= D(2);
			ELSE
				Q(2) <= 'Z';
			END IF;
	END PROCESS;

	PROCESS(D(3),E)
		BEGIN
			if (E = '1') THEN
				Q(3) <= D(3);
			ELSE
				Q(3) <= 'Z';
			END IF;
	END PROCESS;


END bhv_buffer4;
