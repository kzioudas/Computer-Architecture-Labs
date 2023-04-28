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
-- CREATED		"Wed Nov 14 14:13:03 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY syncRegFile IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		we3 :  IN  STD_LOGIC;
		ldEn :  IN  STD_LOGIC;
		ra1 :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		ra2 :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		wa3 :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		wd3 :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		rd1 :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		rd2 :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END syncRegFile;

ARCHITECTURE bdf_type OF syncRegFile IS 

COMPONENT rfposedge
	PORT(wen : IN STD_LOGIC;
		 ldEn : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 ra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wa : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wd : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;



BEGIN 



b2v_portA : rfposedge
PORT MAP(wen => we3,
		 ldEn => ldEn,
		 reset => reset,
		 clk => clk,
		 ra => ra1,
		 wa => wa3,
		 wd => wd3,
		 rout => rd1);


b2v_portB : rfposedge
PORT MAP(wen => we3,
		 ldEn => ldEn,
		 reset => reset,
		 clk => clk,
		 ra => ra2,
		 wa => wa3,
		 wd => wd3,
		 rout => rd2);


END bdf_type;