--==============================================================================
--==                                                                          
--== Project   : CPU_16bit                                                    
--== Component : ControlUnit_16bit_VHDL				  			  						
--== Notes		: Mnemonics:
--==             0000 NOP	no op.                                             
--==             0001 LDA	Load A reg. with contents of given addr.				
--==             0010 ADD	Add contents of given addr. to A reg.					
--==             0011 SUB	Subtract contents of given addr. from A reg.			
--==             0100 STA	Store contents of A reg. at given addr.				
--==             0101 LDI	Load A reg. with given value								
--==             0110 JMP	Jump to given addr.											
--==             0111 JC	Jump to given addr. if Carry Flag is set				
--==             1000 JZ	Jump to given addr. if Zero Flag is set				
--==             1001 	N/A																	
--==             1010 	N/A																	
--==             1011	N/A																	
--==             1100	N/A																	
--==             1101	N/A																	
--==             1110 OUT	Load Out reg. with contents of A reg.					
--==             1111 HLT	Halt the clock													
--==                                                                          
--==             Fetch -> Decode -> Execute -> Mem. access -> Write           
--==============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all ;

LIBRARY work;

ENTITY ControlUnit_16bit_VHDL IS 
	PORT
	(
		IR12_IR15	:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
		CLK			:	IN		STD_LOGIC;
		CLR			:	IN		STD_LOGIC;
		AO	    		:	OUT	STD_LOGIC;
		AI	    		:	OUT	STD_LOGIC;
		II	    		:	OUT	STD_LOGIC;
		IO	    		:	OUT	STD_LOGIC;
		RO	    		:	OUT	STD_LOGIC;
		RI	    		:	OUT	STD_LOGIC;
		MI	    		:	OUT	STD_LOGIC;
		HLT	 		:	OUT	STD_LOGIC;	-- top half end
		FI	    		:	OUT	STD_LOGIC;	-- bot half start
		J	    		:	OUT	STD_LOGIC;
		CO	    		:	OUT	STD_LOGIC;
		CE	    		:	OUT	STD_LOGIC;
		OI	    		:	OUT	STD_LOGIC;
		BI	    		:	OUT	STD_LOGIC;
		SU	    		:	OUT	STD_LOGIC;
		EO	    		:	OUT	STD_LOGIC;
		COUNT			:	OUT	STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END ControlUnit_16bit_VHDL;

ARCHITECTURE bhv_controllogic OF ControlUnit_16bit_VHDL IS 

   -----------------------------------------------------------------------------
   -- Here all used components are defined                                    --
   -----------------------------------------------------------------------------
	COMPONENT SynchUpCount_4bit
			PORT
				(
					INC				: 	IN		STD_LOGIC;
					PULLPIN_HIGH	: 	IN		STD_LOGIC;
					CLR				: 	IN		STD_LOGIC;
					CLK				:	IN		STD_LOGIC;
					Q2					: 	OUT	STD_LOGIC;
					Q1					: 	OUT	STD_LOGIC;
					Q0					: 	OUT	STD_LOGIC
				);
				
	END COMPONENT;
	
   -----------------------------------------------------------------------------
   -- States in cycle are declared here		                                 --
   -----------------------------------------------------------------------------
	TYPE STATE_TYPE IS 
		(
			S_FETCH,
			S_DECODE, 
			S_EXECUTE_1, 
			S_EXECUTE_2,
			S_EXECUTE_3,
			S_EXECUTE_4,
			S_EXECUTE_5,
			S_EXECUTE_6
		);
		
--------------------------------------------------------------------------------
-- All used signals are defined here (lowercase)                              --
--------------------------------------------------------------------------------	
SIGNAL current_state	: STATE_TYPE;
SIGNAL count_signal	: STD_LOGIC_VECTOR(2 DOWNTO 0);
			
	BEGIN 
	
   --------------------------------------------------------------------------------
   -- Here all output connections are defined                                    --
   --------------------------------------------------------------------------------
	COUNT(2 DOWNTO 0) <= count_signal(2 DOWNTO 0);
	
	--------------------------------------------------------------------------------
   -- Here all normal components are defined                                     --
   --------------------------------------------------------------------------------
	counter : SynchUpCount_4bit
		PORT MAP 
			( 
					INC				=>	'1',
					PULLPIN_HIGH	=> '1',
					CLR				=> CLR,
					CLK				=> CLK,
					Q2					=> count_signal(2),
					Q1					=> count_signal(1),
					Q0					=> count_signal(0)
			);

	
	STATE_LOGIC:	PROCESS(CLK, CLR)
							BEGIN
								IF (CLR = '1') THEN
									current_state <= S_FETCH;					-- counter: "000"
								ELSIF RISING_EDGE(CLK) THEN
									CASE current_state IS
										WHEN S_FETCH =>
											current_state <= S_DECODE;			-- counter: "001"
										WHEN S_DECODE =>
											current_state <= S_EXECUTE_1;		-- counter: "010"
										WHEN S_EXECUTE_1 =>
											current_state <= S_EXECUTE_2;		-- counter: "011"
										WHEN S_EXECUTE_2 =>
											current_state <= S_EXECUTE_3;		-- counter: "100"
										WHEN S_EXECUTE_3 =>
											current_state <= S_EXECUTE_4;		-- counter: "101"
										WHEN S_EXECUTE_4 =>
											current_state <= S_EXECUTE_5;		-- counter: "110"
										WHEN S_EXECUTE_5 =>
											current_state <= S_EXECUTE_6;		-- counter: "111"
										WHEN S_EXECUTE_6 =>
											current_state <= S_FETCH;			-- counter: "000"
									END CASE;
								END IF;
						END PROCESS;
						
	OUTPUT_LOGIC:	PROCESS(current_state)
							BEGIN
								CASE current_state IS
										WHEN S_FETCH =>				-- Cycle: 1, all mnemonics have same fetch state: MI|CO
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '1';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '1';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
												
										WHEN S_DECODE =>				-- Cycle: 2, all mnemonics have same decode state: RO|II|CE
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '1';
												IO	   <= '0';
												RO	   <= '1';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '1';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
												
										WHEN S_EXECUTE_1 =>			--	Cycle: 3
											IF (IR12_IR15 = ("0001" OR "0010" OR "0011" OR "0100")) THEN		-- LDA, ADD, SUB, STA: IO|MI
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '1';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '1';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											ELSIF (IR12_IR15 = "0101") THEN													-- LDI: IO|AI
												AO	   <=	'0';
												AI	   <= '1';
												II	   <= '0';
												IO	   <= '1';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											ELSIF (IR12_IR15 = ("0110" OR "0111" OR "1000")) THEN						-- JMP, JC, JZ: IO|J
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '1';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '1';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											ELSIF (IR12_IR15 = "1110") THEN													-- OUT: AO|OI
												AO	   <=	'1';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '1';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											ELSIF (IR12_IR15 = "1111") THEN													-- HLT: HLT
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'1';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											ELSE																						-- n/a: includes NOP
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											END IF;
											
										WHEN S_EXECUTE_2 =>			--	Cycle: 4
											IF (IR12_IR15 = "0001") THEN														-- LDA: RO|AI
												AO	   <=	'0';
												AI	   <= '1';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '1';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											ELSIF (IR12_IR15 = ("0010" OR "0011")) THEN									-- ADD, SUB: RO|BI
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '1';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '1';
												SU	   <= '0';
												EO	   <= '0';
											ELSIF (IR12_IR15 = "0100") THEN													-- STA: AO|RI
												AO	   <=	'1';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '1';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											ELSE																						-- n/a: includes NOP, LDI, JMP, JC, JZ, OUT, HLT
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											END IF;
											
											
										WHEN S_EXECUTE_3 =>			-- Cycle: 5
											IF (IR12_IR15 = "0010") THEN														-- ADD: EO|AI|FI
												AO	   <=	'0';
												AI	   <= '1';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'1';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '1';
											ELSIF (IR12_IR15 = "0011") THEN													-- SUB: EO|AI|SU|FI
												AO	   <=	'0';
												AI	   <= '1';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'1';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '1';
												EO	   <= '1';
											ELSE																						-- n/a: 
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
											END IF;																	
											
										WHEN S_EXECUTE_4 =>			-- Cycle: 6, all operation sequences are done by this point, do nothing
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
												
										WHEN S_EXECUTE_5 =>			-- Cycle: 7, all operation sequences are done, do nothing
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
										WHEN S_EXECUTE_6 =>			-- Cycle: 8, all operation sequences are done, do nothing
												AO	   <=	'0';
												AI	   <= '0';
												II	   <= '0';
												IO	   <= '0';
												RO	   <= '0';
												RI	   <= '0';
												MI	   <= '0';
												HLT	<=	'0';
												FI	   <=	'0';
												J	   <= '0';
												CO	   <= '0';
												CE	   <= '0';
												OI	  	<= '0';
												BI	   <= '0';
												SU	   <= '0';
												EO	   <= '0';
								END CASE;
						END PROCESS;
			
END bhv_controllogic;
