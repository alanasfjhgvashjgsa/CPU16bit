--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : BufferedRegister_16bit_VHDL				  			  					==
--== Notes		: 							  								  						==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY BufferedRegister_16bit_VHDL IS 
	PORT
	(
		A 		:  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		E 		:	IN STD_LOGIC;
		CLR 	:  IN  STD_LOGIC;
		LOAD 	:  IN  STD_LOGIC;
		CLK 	:  IN  STD_LOGIC;
		S 		:  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END BufferedRegister_16bit_VHDL;

ARCHITECTURE bhv_buffreg16 OF BufferedRegister_16bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	COMPONENT BufferedRegister_4bit_VHDL
		PORT
			(
				A		: 	IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				E		:	IN	STD_LOGIC;
				CLR 	:  IN  STD_LOGIC;
				LOAD 	:  IN  STD_LOGIC;
				CLK 	:  IN  STD_LOGIC;
				s 		:  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
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

	
	buffreg4_0to3 : BufferedRegister_4bit_VHDL
		PORT MAP 
			( 
				A(3 DOWNTO 0)	=> A(3 DOWNTO 0),
				E 					=>	E,
				CLR 				=>	CLR,
				LOAD 				=>	LOAD,
				CLK 				=> CLK,
				S(3 DOWNTO 0)	=> S(3 DOWNTO 0)
			);
			
	buffreg4_4to7 : BufferedRegister_4bit_VHDL
		PORT MAP 
			( 
				A(3 DOWNTO 0)	=> A(7 DOWNTO 4),
				E 					=>	E,	
				CLR 				=>	CLR,
				LOAD 				=> LOAD,
				CLK 				=> CLK,
				S(3 DOWNTO 0)	=> S(7 DOWNTO 4)  
			);
			
	buffreg4_8to11 : BufferedRegister_4bit_VHDL
		PORT MAP 
			( 
				A(3 DOWNTO 0)	=> A(11 DOWNTO 8),
				E 					=>	E,
				CLR 				=>	CLR,
				LOAD 				=> LOAD,
				CLK 				=> CLK,
				S(3 DOWNTO 0)	=> S(11 DOWNTO 8)  
			);
			
	buffreg4_12to15 : BufferedRegister_4bit_VHDL
		PORT MAP 
			( 
				A(3 DOWNTO 0)	=> A(15 DOWNTO 12),
				E 					=>	E,
				CLR 				=>	CLR,
				LOAD 				=> LOAD,
				CLK 				=> CLK,
				S(3 DOWNTO 0)	=> S(15 DOWNTO 12) 
			);
	
END bhv_buffreg16;
