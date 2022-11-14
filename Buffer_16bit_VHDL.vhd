--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : Buffer_16bit_VHDL															==
--== Notes		: "As in eddiewastaken's logisim CPU, we have also decided		==
--==              to design up to a 4-bit buffer in order to reflect the		==
--==              real IC chips that are used in physical CPU's.         	   ==
--==              16-bit = x4 4-bit."                                         ==
--==                                                                          ==  
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY Buffer_16bit_VHDL IS
	PORT
		(
				E			:	IN  STD_LOGIC;									
				D 		 	:  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);		-- A in eddie
				Q 			:  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)		--	S in eddie
		);
END Buffer_16bit_VHDL;


ARCHITECTURE bhv_buffer16 OF Buffer_16bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	COMPONENT Buffer_4bit_VHDL
		PORT
			(
				E			:	IN  STD_LOGIC;
				D 		 	:  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
				Q 			:  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
	END COMPONENT;
	
	
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
	buff4_0to3 : Buffer_4bit_VHDL
		PORT MAP 
			( 
				E 					=>	E,
				D(3 DOWNTO 0)	=> D(3 DOWNTO 0),
				Q(3 DOWNTO 0)	=> Q(3 DOWNTO 0)
			);
			
	buff4_4to7 : Buffer_4bit_VHDL
		PORT MAP 
			(  
				E 					=>	E,
				D(3 DOWNTO 0)	=> D(7 DOWNTO 4),
				Q(3 DOWNTO 0)	=> Q(7 DOWNTO 4)
			);
			
	buff4_8to11 : Buffer_4bit_VHDL
		PORT MAP 
			( 
				E 					=>	E,
				D(3 DOWNTO 0)	=> D(11 DOWNTO 8),
				Q(3 DOWNTO 0)	=> Q(11 DOWNTO 8) 
			);
			
	buff4_12to15 : Buffer_4bit_VHDL
		PORT MAP 
			( 
				E 					=>	E,
				D(3 DOWNTO 0)	=>	D(15 DOWNTO 12),
				Q(3 DOWNTO 0)	=> Q(15 DOWNTO 12)
			);


END bhv_buffer16;
