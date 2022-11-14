--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : Register_1bit_VHDL															==
--== Notes		: "Using the dff in eddiewastaken's CPU, a one bit register		==
--==              is given by the VHDL code here."										==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY Register_1bit_VHDL IS 
	PORT
	(
		LOAD 	:  IN  STD_LOGIC;
		CLR 	:  IN  STD_LOGIC;
		CLK 	:  IN  STD_LOGIC;
		A0 	:  IN  STD_LOGIC;
		Q 		:  OUT  STD_LOGIC;
		Q_NOT :  OUT  STD_LOGIC
	);
END Register_1bit_VHDL;

ARCHITECTURE bhv_reg OF Register_1bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	COMPONENT dff_VHDL
		PORT
			(
				--PRE 	: IN STD_LOGIC;	-- not using preset in register design
				CLR 	: IN STD_LOGIC;
				CLK 	: IN STD_LOGIC;
				D	 	: IN STD_LOGIC;
				Q 		: OUT STD_LOGIC;
				Q_NOT : OUT STD_LOGIC
			);
	END COMPONENT;	
	
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------
SIGNAL	d_signal 		:  STD_LOGIC;
SIGNAL	q_signal 		:  STD_LOGIC;
SIGNAL	not_load 		:  STD_LOGIC;
SIGNAL	load_and_a0 	:  STD_LOGIC;
SIGNAL	q_and_notload 	:  STD_LOGIC;

	BEGIN 
	
   --------------------------------------------------------------------------------
   -- Here all input connections are defined                                     --
   --------------------------------------------------------------------------------
	q_and_notload 	<= q_signal AND not_load;
	load_and_a0 	<= LOAD AND A0;
	d_signal 		<= load_and_a0 OR q_and_notload;
	not_load 		<= NOT(LOAD);
	
   --------------------------------------------------------------------------------
   -- Here all output connections are defined                                    --
   --------------------------------------------------------------------------------
	Q <= q_signal;
	
   --------------------------------------------------------------------------------
   -- Here all normal components are defined                                     --
   --------------------------------------------------------------------------------
	dff_0 : dff_VHDL
	PORT MAP
		(
			CLR 	=> CLR,
			CLK 	=> CLK,
			D 		=> d_signal,
			Q 		=> q_signal,
			Q_NOT => Q_NOT
		);

END bhv_reg;
