--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : Register_4bit_VHDL                                           ==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY Register_4bit_VHDL IS
  	PORT
		(
			A		: 	IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			CLR 	:  IN  STD_LOGIC;
			LOAD 	:  IN  STD_LOGIC;
			CLK 	:  IN  STD_LOGIC;
			s 		:  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
   	);
END Register_4bit_VHDL;


ARCHITECTURE bhv_reg4 OF Register_4bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	
	COMPONENT Register_1bit_VHDL
		PORT
			(
				LOAD 	:  IN  STD_LOGIC;
				CLR 	:  IN  STD_LOGIC;
				CLK 	:  IN  STD_LOGIC;
				A0 	:  IN  STD_LOGIC;
				Q 		:  OUT  STD_LOGIC
				--Q_NOT :  OUT  STD_LOGIC
			);
	END COMPONENT;
	
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------

BEGIN

   --------------------------------------------------------------------------------
   -- Here all input connections are defined                                     --
   --------------------------------------------------------------------------------
   
   --------------------------------------------------------------------------------
   -- Here all output connections are defined                                    --
   --------------------------------------------------------------------------------

   --------------------------------------------------------------------------------
   -- Here all normal components are defined                                     --
   --------------------------------------------------------------------------------
	reg_0 : Register_1bit_VHDL
		PORT MAP 
			( 
				LOAD 	=> LOAD,
				CLR 	=> CLR,
				CLK 	=> CLK,
				A0 	=> A(0),
				Q 		=> S(0)
			);
		 
	reg_1 : Register_1bit_VHDL
		PORT MAP
			( 
				LOAD 	=> LOAD,
				CLR 	=> CLR,
				CLK 	=> CLK,
				A0 	=> A(1),
				Q 		=> S(1)
			);

	reg_2 : Register_1bit_VHDL
		PORT MAP
			(
				LOAD 	=> LOAD,
				CLR 	=> CLR,
				CLK 	=> CLK,
				A0 	=> A(2),
				Q 		=> S(2)
			);
			 
	reg_3 : Register_1bit_VHDL
		PORT MAP
			(
				LOAD 	=> LOAD,
				CLR 	=> CLR,
				CLK 	=> CLK,
				A0 	=> A(3),
				Q 		=> S(3)
			);


END bhv_reg4;
