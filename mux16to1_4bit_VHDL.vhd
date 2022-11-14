--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : mux16to1_4bit_VHDL			  			  									==
--== Notes		: 							  								  						==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY mux16to1_4bit_VHDL IS 
	PORT
	(
		D			:	IN		STD_LOGIC_VECTOR(63 DOWNTO 0);
		ENABLE	:	IN		STD_LOGIC;
		A			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
		S			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END mux16to1_4bit_VHDL;

ARCHITECTURE bhv_mux16to1_4bit OF mux16to1_4bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	COMPONENT mux4to1_4bit_VHDL
		PORT
			(
				A			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				B			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				C			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				D			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				ENABLE	:	IN		STD_LOGIC;
				S			:	IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				Q			:	OUT		STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
	END COMPONENT;
	
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------
SIGNAL	result_15_0 :	STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	result_31_16 :	STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	result_47_32 :	STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	result_63_48 :	STD_LOGIC_VECTOR(4 DOWNTO 0);

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

	
	mux4to1_4bit_15_0 : mux4to1_4bit_VHDL
		PORT MAP 
			( 
				A(3 DOWNTO 0) 	=> D(3 DOWNTO 0),
				B(3 DOWNTO 0) 	=> D(7 DOWNTO 4),
				C(3 DOWNTO 0) 	=> D(11 DOWNTO 8),
				D(3 DOWNTO 0) 	=> D(15 DOWNTO 12),
				ENABLE			=>	ENABLE,
				S(1 DOWNTO 0)	=>	A(1 DOWNTO 0),
				Q(3 DOWNTO 0)	=>	result_15_0(3 DOWNTO 0)
			);
			
	mux4to1_4bit_31_16 : mux4to1_4bit_VHDL
		PORT MAP 
			( 
				A(3 DOWNTO 0) 	=> D(19 DOWNTO 16),
				B(3 DOWNTO 0) 	=> D(23 DOWNTO 20),
				C(3 DOWNTO 0) 	=> D(27 DOWNTO 24),
				D(3 DOWNTO 0) 	=> D(31 DOWNTO 28),
				ENABLE			=>	ENABLE,
				S(1 DOWNTO 0)	=>	A(1 DOWNTO 0),
				Q(3 DOWNTO 0)	=>	result_31_16(3 DOWNTO 0)
			);
			
	mux4to1_4bit_47_32 : mux4to1_4bit_VHDL
		PORT MAP 
			( 
				A(3 DOWNTO 0) 	=> D(35 DOWNTO 32),
				B(3 DOWNTO 0) 	=> D(39 DOWNTO 36),
				C(3 DOWNTO 0) 	=> D(43 DOWNTO 40),
				D(3 DOWNTO 0) 	=> D(47 DOWNTO 44),
				ENABLE			=>	ENABLE,
				S(1 DOWNTO 0)	=>	A(1 DOWNTO 0),
				Q(3 DOWNTO 0)	=>	result_47_32(3 DOWNTO 0)
			);
			
	mux4to1_4bit_63_48 : mux4to1_4bit_VHDL
		PORT MAP 
			( 
				A(3 DOWNTO 0) 	=> D(51 DOWNTO 48),
				B(3 DOWNTO 0) 	=> D(55 DOWNTO 52),
				C(3 DOWNTO 0) 	=> D(59 DOWNTO 56),
				D(3 DOWNTO 0) 	=> D(63 DOWNTO 60),
				ENABLE			=>	ENABLE,
				S(1 DOWNTO 0)	=>	A(1 DOWNTO 0),
				Q(3 DOWNTO 0)	=>	result_63_48(3 DOWNTO 0)
			);
			
	mux4to1_4bit_end : mux4to1_4bit_VHDL
		PORT MAP 
			( 
				A(3 DOWNTO 0) 	=> result_15_0(3 DOWNTO 0),
				B(3 DOWNTO 0) 	=> result_31_16(3 DOWNTO 0),
				C(3 DOWNTO 0) 	=> result_47_32(3 DOWNTO 0),
				D(3 DOWNTO 0) 	=> result_63_48(3 DOWNTO 0),
				ENABLE			=>	ENABLE,
				S(1 DOWNTO 0)	=>	A(3 DOWNTO 2),
				Q(3 DOWNTO 0)	=>	S(3 DOWNTO 0)
			);
			
			
END bhv_mux16to1_4bit;
