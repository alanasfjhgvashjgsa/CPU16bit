-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
-- CREATED		"Sun Oct 30 03:00:09 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Register_1bit IS 
	PORT
	(
		LOAD :  IN  STD_LOGIC;
		A0 :  IN  STD_LOGIC;
		CLR :  IN  STD_LOGIC;
		CLK :  IN  STD_LOGIC;
		Q :  OUT  STD_LOGIC;
		Q_NOT :  OUT  STD_LOGIC
	);
END Register_1bit;

ARCHITECTURE bdf_type OF Register_1bit IS 

COMPONENT dff_vhdl
	PORT(PRE : IN STD_LOGIC;
		 CLR : IN STD_LOGIC;
		 CLK : IN STD_LOGIC;
		 D : IN STD_LOGIC;
		 Q : OUT STD_LOGIC;
		 Q_NOT : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;


BEGIN 
Q <= SYNTHESIZED_WIRE_1;



b2v_inst : dff_vhdl
PORT MAP(CLR => CLR,
		 CLK => CLK,
		 D => SYNTHESIZED_WIRE_0,
		 Q => SYNTHESIZED_WIRE_1,
		 Q_NOT => Q_NOT);


SYNTHESIZED_WIRE_4 <= SYNTHESIZED_WIRE_1 AND SYNTHESIZED_WIRE_2;


SYNTHESIZED_WIRE_3 <= LOAD AND A0;


SYNTHESIZED_WIRE_0 <= SYNTHESIZED_WIRE_3 OR SYNTHESIZED_WIRE_4;


SYNTHESIZED_WIRE_2 <= NOT(LOAD);



END bdf_type;