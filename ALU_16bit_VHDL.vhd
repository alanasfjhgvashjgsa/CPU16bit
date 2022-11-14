--==============================================================================
--==                                                                          ==
--== Project   : CPU_16bit                                                    ==
--== Component : ALU_16bit_VHDL				  			  									==
--== Notes		: "All components used in this 16-bit ALU are run on VHDL."		==
--==                                                                          ==
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY ALU_16bit_VHDL IS 
	PORT
	(
		SUB			: 	IN STD_LOGIC;
		A				: 	IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		B				: 	IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		E0				: 	IN STD_LOGIC;
		FLAG_CLR		: 	IN STD_LOGIC;
		CLK			: 	IN STD_LOGIC;
		FLAG_LOAD	: 	IN STD_LOGIC;
		CF 			: 	OUT STD_LOGIC;
		ZF				: 	OUT STD_LOGIC;
		S				: 	OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END ALU_16bit_VHDL;

ARCHITECTURE bhv_alu OF ALU_16bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	COMPONENT AddOpSub_16bit_VHDL
		PORT
			(
				ADD_SUB 	:  IN  STD_LOGIC;
				A 		 	:  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
				B 			:  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
				S 			:  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
				C_OUT	   :  OUT  STD_LOGIC
			);
	END COMPONENT;
	
	COMPONENT Buffer_16bit_VHDL
		PORT
			(
					E	:	IN  STD_LOGIC;
					D 	:  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
					Q 	:  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
	END COMPONENT;
	
	COMPONENT Register_Flag_VHDL
		PORT
			(
				FLAG_CLR 	:  IN  STD_LOGIC;
				CLK 			:  IN  STD_LOGIC;
				FLAG_LOAD	:  IN  STD_LOGIC;
				CARRY			:  IN  STD_LOGIC;
				ZERO			:  IN  STD_LOGIC;
				CF				:  OUT  STD_LOGIC;
				ZF				:	OUT  STD_LOGIC
			);
	END COMPONENT;
	
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------
SIGNAL s_signal										:	STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL zero_signal									: 	STD_LOGIC;
SIGNAL carry_signal									:	STD_LOGIC;
SIGNAL s0, s1, s2, s3, s4, s5, s6, s7 			:	STD_LOGIC;
SIGNAL s8, s9, s10, s11, s12, s13, s14, s15	:	STD_LOGIC;

	BEGIN 
	
   --------------------------------------------------------------------------------
   -- Here all input connections are defined                                     --
   --------------------------------------------------------------------------------
		--zero_signal <=	s_signal = 0000000000000000;			-- x16 bits of 0
	s0 	<= s_signal(0);
	s1 	<= s_signal(1);
	s2	 	<= s_signal(2);
	s3 	<= s_signal(3);
	s4 	<= s_signal(4);
	s5 	<= s_signal(5);
	s6	 	<= s_signal(6);
	s7 	<= s_signal(7);
	s8 	<= s_signal(8);
	s9 	<= s_signal(9);
	s10 	<= s_signal(10);
	s11 	<= s_signal(11);
	s12 	<= s_signal(12);
	s13 	<= s_signal(13);
	s14 	<= s_signal(14);
	s15 	<= s_signal(15);
	zero_signal <= NOT(s0 AND s1 AND s2 AND s3 AND s4 AND s5 AND s6 
								AND s7 AND s8 AND s9 AND s10 AND s11 AND s12
								AND s13 AND s14 AND s15);
	
   --------------------------------------------------------------------------------
   -- Here all output connections are defined                                    --
   --------------------------------------------------------------------------------
		-- n/a
		
   --------------------------------------------------------------------------------
   -- Here all normal components are defined                                     --
   --------------------------------------------------------------------------------
	addopsub16 : AddOpSub_16bit_VHDL
		PORT MAP 
			( 
				ADD_SUB 			=>	SUB,
				A(15 DOWNTO 0) => A(15 DOWNTO 0),				-- inputs
				B(15 DOWNTO 0) => B(15 DOWNTO 0),
				S(15 DOWNTO 0)	=> s_signal(15 DOWNTO 0),		-- outputs
				C_OUT				=> carry_signal
			);
	
	
	buff16 : Buffer_16bit_VHDL
		PORT MAP 
			( 
				E 					=>	E0,								-- inputs
				D(15 DOWNTO 0)	=> s_signal(15 DOWNTO 0),
				Q(15 DOWNTO 0)	=> S(15 DOWNTO 0)					-- outputs
			);
			
	regflag : Register_Flag_VHDL
		PORT MAP
			(
				FLAG_CLR 		=>	FLAG_CLR,						-- inputs
				CLK 				=> CLK,
				FLAG_LOAD		=> FLAG_LOAD,
				CARRY				=> carry_signal,
				ZERO				=> zero_signal,
				CF					=> CF,								-- outputs
				ZF					=>	ZF
			);
			
END bhv_alu;
