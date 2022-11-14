--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : Adder_4bit_VHDL                                              ==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY Adder_4bit_VHDL IS
  	PORT
		(
			C_IN  :  IN  STD_LOGIC;
			A 	   :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			B     :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			S     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
			C_OUT :  OUT  STD_LOGIC
   	);
END Adder_4bit_VHDL;


ARCHITECTURE bhv_add4 OF Adder_4bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	
	COMPONENT Adder_1bit_VHDL
		PORT
		(
			A 		: IN STD_LOGIC;
			B 		: IN STD_LOGIC;
			C_IN 	: IN STD_LOGIC;
			S 		: OUT STD_LOGIC;
			C_OUT : OUT STD_LOGIC
		);
	END COMPONENT;
	
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------
	SIGNAL	carry1, carry2, carry3 : STD_LOGIC;

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
	add_0 : Adder_1bit_VHDL
		PORT MAP 
			( 
				A		 => A(0),
				B 		=> B(0),
				C_IN 	=> C_IN,
				S 		=> S(0),
				C_OUT => carry1
			);
		 
	add_1 : Adder_1bit_VHDL
		PORT MAP
			( 
				A 		=> A(1),
				B 		=> B(1),
				C_IN 	=> carry1,
				S 		=> S(1),
				C_OUT => carry2
			);

	add_2 : Adder_1bit_VHDL
		PORT MAP
			(
				A 		=> A(2),
				B 		=> B(2),
				C_IN 	=> carry2,
				S 		=> S(2),
				C_OUT => carry3
			);
			 
	add_3 : Adder_1bit_VHDL
		PORT MAP
			(
				A 		=> A(3),
				B 		=> B(3),
				C_IN 	=> carry3,
				S 		=> S(3),
				C_OUT => C_OUT
			);


END bhv_add4;
