--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : Adder_1bit_VHDL                                              ==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Adder_1bit_VHDL IS 
	PORT
	(
		A :  IN  STD_LOGIC;
		B :  IN  STD_LOGIC;
		C_IN :  IN  STD_LOGIC;
		S :  OUT  STD_LOGIC;
		C_OUT :  OUT  STD_LOGIC
	);
END Adder_1bit_VHDL;


ARCHITECTURE bhv_adder of Adder_1bit_VHDL is


BEGIN 


S <= (A XOR B) XOR C_IN;


C_OUT <= (A AND B) OR (C_IN AND (A XOR B));


END bhv_adder;