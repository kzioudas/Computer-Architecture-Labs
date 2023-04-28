-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Wed Nov 14 14:07:33 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY rfPosEdge IS 
	PORT
	(
		wen :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		ldEn :  IN  STD_LOGIC;
		ra :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		wa :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		wd :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		rout :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END rfPosEdge;

ARCHITECTURE bdf_type OF rfPosEdge IS 

COMPONENT syncram2poswrite
	PORT(wren : IN STD_LOGIC;
		 wrclock : IN STD_LOGIC;
		 wrclocken : IN STD_LOGIC;
		 rdclock : IN STD_LOGIC;
		 rdclocken : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rdaddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wraddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT regcmp
	PORT(true_wren : IN STD_LOGIC;
		 ra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wa : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 bypass : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT flop5
	PORT(clk : IN STD_LOGIC;
		 d : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT flope5
	PORT(clk : IN STD_LOGIC;
		 loadEn : IN STD_LOGIC;
		 d : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT flop32
	PORT(clk : IN STD_LOGIC;
		 d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_32
	PORT(s : IN STD_LOGIC;
		 d0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 d1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	bypassWB :  STD_LOGIC;
SIGNAL	bypassWBplus1 :  STD_LOGIC;
SIGNAL	ra_r :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	regout :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	true_wren :  STD_LOGIC;
SIGNAL	true_wren_r :  STD_LOGIC;
SIGNAL	wa_r :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	wd_r :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 
SYNTHESIZED_WIRE_0 <= '1';
SYNTHESIZED_WIRE_1 <= '0';
SYNTHESIZED_WIRE_4 <= '1';



b2v_inst : syncram2poswrite
PORT MAP(wren => true_wren,
		 wrclock => clk,
		 wrclocken => SYNTHESIZED_WIRE_0,
		 rdclock => clk,
		 rdclocken => ldEn,
		 data => wd,
		 rdaddress => ra,
		 wraddress => wa,
		 q => regout);



b2v_inst10 : regcmp
PORT MAP(true_wren => true_wren,
		 ra => ra_r,
		 wa => wa,
		 bypass => bypassWB);


b2v_inst12 : regcmp
PORT MAP(true_wren => true_wren_r,
		 ra => ra_r,
		 wa => wa_r,
		 bypass => bypassWBplus1);


b2v_inst13 : flop5
PORT MAP(clk => clk,
		 d => wa,
		 q => wa_r);



SYNTHESIZED_WIRE_3 <= NOT(reset);



SYNTHESIZED_WIRE_2 <= wa(4) OR wa(2) OR wa(3) OR wa(1) OR wa(0) OR SYNTHESIZED_WIRE_1;


true_wren <= wen AND SYNTHESIZED_WIRE_2;



b2v_inst6 : flope5
PORT MAP(clk => clk,
		 loadEn => ldEn,
		 d => ra,
		 q => ra_r);


b2v_inst7 : flop32
PORT MAP(clk => clk,
		 d => wd,
		 q => wd_r);


PROCESS(clk,SYNTHESIZED_WIRE_3,SYNTHESIZED_WIRE_4)
BEGIN
IF (SYNTHESIZED_WIRE_3 = '0') THEN
	true_wren_r <= '0';
ELSIF (SYNTHESIZED_WIRE_4 = '0') THEN
	true_wren_r <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	true_wren_r <= true_wren;
END IF;
END PROCESS;


b2v_WB2ID_mux : mux2_32
PORT MAP(s => bypassWB,
		 d0 => SYNTHESIZED_WIRE_5,
		 d1 => wd,
		 y => rout);


b2v_WBplus1_mux : mux2_32
PORT MAP(s => bypassWBplus1,
		 d0 => regout,
		 d1 => wd_r,
		 y => SYNTHESIZED_WIRE_5);


END bdf_type;