--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : mux4to1_4bit_VHDL			  			  									==
--== Notes		: 							  								  						==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY mux4to1_4bit_VHDL IS 
	PORT
	(
		A			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
		B			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
		C			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
		D			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
		S			:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
		ENABLE	:	IN		STD_LOGIC;
		Q			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END mux4to1_4bit_VHDL;

ARCHITECTURE bhv_mux4to1_4bit OF mux4to1_4bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	COMPONENT mux_2to1_4bit
		PORT
			(
				A0			: 	IN		STD_LOGIC;
				A1			: 	IN		STD_LOGIC;
				A2			: 	IN		STD_LOGIC;
				A3			: 	IN		STD_LOGIC;
				B0			: 	IN		STD_LOGIC;
				B1			: 	IN		STD_LOGIC;
				B2			: 	IN		STD_LOGIC;
				B3			: 	IN		STD_LOGIC;
				ENABLE	:	IN		STD_LOGIC;
				SEL		:	IN 	STD_LOGIC;
				S0			: 	OUT	STD_LOGIC;
				S1			: 	OUT	STD_LOGIC;
				S2			: 	OUT	STD_LOGIC;
				S3			: 	OUT	STD_LOGIC
			);
	END COMPONENT;
	
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------
SIGNAL	result_ab :	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	result_cd :	STD_LOGIC_VECTOR(3 DOWNTO 0);

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

	
	mux2to1_4bit_AB : mux_2to1_4bit
		PORT MAP 
			( 
				A0			=> A(0),
				A1			=> A(1),
				A2			=> A(2),
				A3			=> A(3),
				B0			=> B(0),
				B1			=> B(1),
				B2			=> B(2),
				B3			=> B(3),
				ENABLE	=>	ENABLE,
				SEL		=>	S(0),
				S0			=>	result_AB(0),
				S1			=>	result_AB(1),
				S2			=>	result_AB(2),
				S3			=>	result_AB(3)
			);
			
	mux2to1_4bit_CD : mux_2to1_4bit
		PORT MAP 
			( 
				A0			=> C(0),
				A1			=> C(1),
				A2			=> C(2),
				A3			=> C(3),
				B0			=> D(0),
				B1			=> D(1),
				B2			=> D(2),
				B3			=> D(3),
				ENABLE	=>	ENABLE,
				SEL		=>	S(0),
				S0			=>	result_CD(0),
				S1			=>	result_CD(1),
				S2			=>	result_CD(2),
				S3			=>	result_CD(3)
			);
			
	mux2to1_4bit_ABCD : mux_2to1_4bit
		PORT MAP 
			( 
				A0			=> result_AB(0),
				A1			=> result_AB(1),
				A2			=> result_AB(2),
				A3			=> result_AB(3),
				B0			=> result_CD(0),
				B1			=> result_CD(1),
				B2			=> result_CD(2),
				B3			=> result_CD(3),
				ENABLE	=>	ENABLE,
				SEL		=>	S(0),
				S0			=>	Q(0),
				S1			=>	Q(1),
				S2			=>	Q(2),
				S3			=>	Q(3)
			);
			
	
END bhv_mux4to1_4bit;
