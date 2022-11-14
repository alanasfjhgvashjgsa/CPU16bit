--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : BufferedRegister_4bit_VHDL				  			  					==
--== Notes		: 							  								  						==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY BufferedRegister_4bit_VHDL IS 
	PORT
	(
		A 		:  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		E 		:	IN STD_LOGIC;
		CLR 	:	IN STD_LOGIC;
		LOAD 	:  IN STD_LOGIC;
		CLK 	:  IN STD_LOGIC;
		S 		:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END BufferedRegister_4bit_VHDL;

ARCHITECTURE bhv_buffreg4 OF BufferedRegister_4bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	COMPONENT Register_4bit_VHDL
		PORT
			(
				A		: 	IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
				CLR 	:  IN  STD_LOGIC;
				LOAD 	:  IN  STD_LOGIC;
				CLK 	:  IN  STD_LOGIC;
				s 		:  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
	END COMPONENT;
	
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
SIGNAL buffer_in	:	STD_LOGIC_VECTOR(3 DOWNTO 0);

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
	reg4 : Register_4bit_VHDL
		PORT MAP 
			( 
				CLR 				=> CLR,
				LOAD 				=> LOAD,
				CLK 				=> CLK,
				A(3 DOWNTO 0) 	=> A(3 DOWNTO 0),
				S(3 DOWNTO 0)	=> buffer_in(3 DOWNTO 0)
			);
	
	buff4 : Buffer_4bit_VHDL
		PORT MAP 
			( 
				E					=>	E,
				D(3 DOWNTO 0)	=>	buffer_in(3 DOWNTO 0),
				Q(3 DOWNTO 0)	=>	S(3 DOWNTO 0)
			);
	
END bhv_buffreg4;
