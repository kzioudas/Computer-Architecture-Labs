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
-- CREATED		"Wed Nov 14 16:26:04 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY mips IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC
	);
END mips;

ARCHITECTURE bdf_type OF mips IS 

COMPONENT alu
	PORT(a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 alucont : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 zero : OUT STD_LOGIC;
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_32
	PORT(s : IN STD_LOGIC;
		 d0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 d1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT adder
	PORT(a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sl2_32
	PORT(a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT maindec
	PORT(funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 branch : OUT STD_LOGIC;
		 jump : OUT STD_LOGIC;
		 lui : OUT STD_LOGIC;
		 isLoad : OUT STD_LOGIC;
		 isStore : OUT STD_LOGIC;
		 isNop : OUT STD_LOGIC;
		 readsRs : OUT STD_LOGIC;
		 readsRt : OUT STD_LOGIC;
		 memwrite : OUT STD_LOGIC;
		 regwrite : OUT STD_LOGIC;
		 memtoreg : OUT STD_LOGIC;
		 regdst : OUT STD_LOGIC;
		 alusrc : OUT STD_LOGIC;
		 alucontrol : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dmemsync
	PORT(wren : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2_5
	PORT(s : IN STD_LOGIC;
		 d0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 d1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT eq_cmp
	PORT(rA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rB : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 eq : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT pr_ex_mem
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 ex_memWrite : IN STD_LOGIC;
		 ex_isLoad : IN STD_LOGIC;
		 ex_memToReg : IN STD_LOGIC;
		 ex_regWrite : IN STD_LOGIC;
		 ex_aluOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_rd : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 ex_src2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_isLoad : OUT STD_LOGIC;
		 mem_memWrite : OUT STD_LOGIC;
		 mem_memToReg : OUT STD_LOGIC;
		 mem_regWrite : OUT STD_LOGIC;
		 mem_aluOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_rd : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 mem_src2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pr_id_ex
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 id_isLoad : IN STD_LOGIC;
		 id_aluSrc : IN STD_LOGIC;
		 id_memWrite : IN STD_LOGIC;
		 id_memToReg : IN STD_LOGIC;
		 id_regWrite : IN STD_LOGIC;
		 id_alucont : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 id_forwardA : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 id_forwardB : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 id_imm : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_rd : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 id_rdA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_rdB : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_isLoad : OUT STD_LOGIC;
		 ex_aluSrc : OUT STD_LOGIC;
		 ex_memWrite : OUT STD_LOGIC;
		 ex_memToReg : OUT STD_LOGIC;
		 ex_regWrite : OUT STD_LOGIC;
		 ex_alucont : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 ex_forwardA : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 ex_forwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 ex_imm : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_rd : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 ex_rdA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_rdB : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pr_if_id
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 loadEn : IN STD_LOGIC;
		 if_instr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 pcf : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_instr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 pcSeq : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT imemsync
	PORT(clock : IN STD_LOGIC;
		 clken : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT signext
	PORT(a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT andinv
	PORT(reset : IN STD_LOGIC;
		 a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT constant4
	PORT(		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT constant0
	PORT(		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sl2_26
	PORT(a : IN STD_LOGIC_VECTOR(25 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(27 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pr_mem_wb
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 mem_memToReg : IN STD_LOGIC;
		 mem_regWrite : IN STD_LOGIC;
		 mem_aluOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_mo : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_rd : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wb_memToReg : OUT STD_LOGIC;
		 wb_regWrite : OUT STD_LOGIC;
		 wb_aluOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 wb_mo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 wb_rd : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT flopr
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 loadEn : IN STD_LOGIC;
		 d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pipe_ctrl
	PORT(isStore : IN STD_LOGIC;
		 isNop : IN STD_LOGIC;
		 readsRs : IN STD_LOGIC;
		 readsRt : IN STD_LOGIC;
		 branch : IN STD_LOGIC;
		 jump : IN STD_LOGIC;
		 brTaken : IN STD_LOGIC;
		 ex_regWrite : IN STD_LOGIC;
		 ex_isLoad : IN STD_LOGIC;
		 mem_regWrite : IN STD_LOGIC;
		 mem_isLoad : IN STD_LOGIC;
		 ex_rd : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 mem_rd : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rs : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rt : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 flush : OUT STD_LOGIC;
		 flowChange : OUT STD_LOGIC;
		 stall : OUT STD_LOGIC;
		 id_eqFwdA : OUT STD_LOGIC;
		 id_eqFwdB : OUT STD_LOGIC;
		 id_forwardA : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 id_forwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT syncregfile
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 we3 : IN STD_LOGIC;
		 ldEn : IN STD_LOGIC;
		 ra1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 ra2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wa3 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wd3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rd1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rd2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux3_32
	PORT(d0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 d1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 d2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sl16_32
	PORT(a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	a :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	b :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	branch :  STD_LOGIC;
SIGNAL	brTaken :  STD_LOGIC;
SIGNAL	brTarget :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	eq :  STD_LOGIC;
SIGNAL	eqA :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	eqB :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ex_alucont :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	ex_aluOut :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ex_aluSrc :  STD_LOGIC;
SIGNAL	ex_forwardA :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	ex_forwardB :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	ex_imm :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ex_isLoad :  STD_LOGIC;
SIGNAL	ex_memToReg :  STD_LOGIC;
SIGNAL	ex_memWrite :  STD_LOGIC;
SIGNAL	ex_rd :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	ex_rdA :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ex_rdB :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ex_regWrite :  STD_LOGIC;
SIGNAL	ex_src2 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	flowChange :  STD_LOGIC;
SIGNAL	flush :  STD_LOGIC;
SIGNAL	id_alucont :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	id_aluSrc :  STD_LOGIC;
SIGNAL	id_eqFwdA :  STD_LOGIC;
SIGNAL	id_eqFwdB :  STD_LOGIC;
SIGNAL	id_forwardA :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	id_forwardB :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	id_imm :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	id_isLoad :  STD_LOGIC;
SIGNAL	id_memToReg :  STD_LOGIC;
SIGNAL	id_memWrite :  STD_LOGIC;
SIGNAL	id_mw_q :  STD_LOGIC;
SIGNAL	id_rdA :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	id_rdB :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	id_regWrite :  STD_LOGIC;
SIGNAL	id_rg_q :  STD_LOGIC;
SIGNAL	if_instr :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	imem_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	immed :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	imSh2 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	instruction :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	isNop :  STD_LOGIC;
SIGNAL	isStore :  STD_LOGIC;
SIGNAL	jmpTarget :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	jump :  STD_LOGIC;
SIGNAL	lui :  STD_LOGIC;
SIGNAL	mem_aluOut :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	mem_isLoad :  STD_LOGIC;
SIGNAL	mem_memToReg :  STD_LOGIC;
SIGNAL	mem_memWrite :  STD_LOGIC;
SIGNAL	mem_mo :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	mem_rd :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	mem_regWrite :  STD_LOGIC;
SIGNAL	mem_src2 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	npc :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	pc :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	pcf :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	pcSeq :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	pcTarget :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	readsRs :  STD_LOGIC;
SIGNAL	readsRt :  STD_LOGIC;
SIGNAL	regDst :  STD_LOGIC;
SIGNAL	stall :  STD_LOGIC;
SIGNAL	uimmed :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	wb_aluOut :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	wb_memToReg :  STD_LOGIC;
SIGNAL	wb_mo :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	wb_rd :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	wb_regWrite :  STD_LOGIC;
SIGNAL	wb_writeData :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	wr :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;


BEGIN 



b2v_alu : alu
PORT MAP(a => a,
		 alucont => ex_alucont,
		 b => b,
		 result => ex_aluOut);


b2v_alusrc_mux : mux2_32
PORT MAP(s => ex_aluSrc,
		 d0 => ex_src2,
		 d1 => ex_imm,
		 y => b);


b2v_br_adder : adder
PORT MAP(a => pcSeq,
		 b => imSh2,
		 y => brTarget);


b2v_br_shift : sl2_32
PORT MAP(a => immed,
		 y => imSh2);


b2v_dec : maindec
PORT MAP(funct => instruction(5 DOWNTO 0),
		 op => instruction(31 DOWNTO 26),
		 branch => branch,
		 jump => jump,
		 lui => lui,
		 isLoad => id_isLoad,
		 isStore => isStore,
		 isNop => isNop,
		 readsRs => readsRs,
		 readsRt => readsRt,
		 memwrite => id_memWrite,
		 regwrite => id_regWrite,
		 memtoreg => id_memToReg,
		 regdst => regDst,
		 alusrc => id_aluSrc,
		 alucontrol => id_alucont);


b2v_dmem : dmemsync
PORT MAP(wren => ex_memWrite,
		 clock => clk,
		 address => ex_aluOut(11 DOWNTO 2),
		 data => ex_src2,
		 q => mem_mo);


b2v_dst_mux14 : mux2_5
PORT MAP(s => regDst,
		 d0 => instruction(20 DOWNTO 16),
		 d1 => instruction(15 DOWNTO 11),
		 y => wr);


b2v_eq_cmp : eq_cmp
PORT MAP(rA => eqA,
		 rB => eqB,
		 eq => eq);


b2v_ex_mem_pipe_reg : pr_ex_mem
PORT MAP(clk => clk,
		 reset => reset,
		 ex_memWrite => ex_memWrite,
		 mem_memWrite => mem_memWrite,
                 mem_src2 => mem_src2,
		 ex_isLoad => ex_isLoad,
		 ex_memToReg => ex_memToReg,
		 ex_regWrite => ex_regWrite,
		 ex_aluOut => ex_aluOut,
		 ex_rd => ex_rd,
		 ex_src2 => ex_src2,
		 mem_isLoad => mem_isLoad,
		 mem_memToReg => mem_memToReg,
		 mem_regWrite => mem_regWrite,
		 mem_aluOut => mem_aluOut,
		 mem_rd => mem_rd);


b2v_id_ex_pipe_reg : pr_id_ex
PORT MAP(clk => clk,
		 reset => reset,
		 id_isLoad => id_isLoad,
		 id_aluSrc => id_aluSrc,
		 id_memWrite => id_mw_q,
		 id_memToReg => id_memToReg,
		 id_regWrite => id_rg_q,
		 id_alucont => id_alucont,
		 id_forwardA => id_forwardA,
		 id_forwardB => id_forwardB,
		 id_imm => id_imm,
		 id_rd => wr,
		 id_rdA => id_rdA,
		 id_rdB => id_rdB,
		 ex_isLoad => ex_isLoad,
		 ex_aluSrc => ex_aluSrc,
		 ex_memWrite => ex_memWrite,
		 ex_memToReg => ex_memToReg,
		 ex_regWrite => ex_regWrite,
		 ex_alucont => ex_alucont,
		 ex_forwardA => ex_forwardA,
		 ex_forwardB => ex_forwardB,
		 ex_imm => ex_imm,
		 ex_rd => ex_rd,
		 ex_rdA => ex_rdA,
		 ex_rdB => ex_rdB);


b2v_idSrcABypassMux : mux2_32
PORT MAP(s => id_eqFwdA,
		 d0 => id_rdA,
		 d1 => mem_aluOut,
		 y => eqA);


b2v_idSrcBBypassMux : mux2_32
PORT MAP(s => id_eqFwdB,
		 d0 => id_rdB,
		 d1 => mem_aluOut,
		 y => eqB);


b2v_if_id_pipe_reg : pr_if_id
PORT MAP(clk => clk,
		 reset => reset,
		 loadEn => SYNTHESIZED_WIRE_0,
		 if_instr => if_instr,
		 pcf => pcf,
		 id_instr => instruction,
		 pcSeq => pcSeq);


b2v_imem : imemsync
PORT MAP(clock => clk,
		 clken => SYNTHESIZED_WIRE_1,
		 address => SYNTHESIZED_WIRE_2,
		 q => imem_out);


b2v_imm_mux : mux2_32
PORT MAP(s => lui,
		 d0 => immed,
		 d1 => uimmed,
		 y => id_imm);


b2v_imm_signext : signext
PORT MAP(a => instruction(15 DOWNTO 0),
		 y => immed);


b2v_inst : andinv
PORT MAP(reset => reset,
		 a => npc,
		 y => SYNTHESIZED_WIRE_2);


id_mw_q <= id_memWrite AND SYNTHESIZED_WIRE_9;


id_rg_q <= id_regWrite AND SYNTHESIZED_WIRE_9;


SYNTHESIZED_WIRE_9 <= NOT(stall);



SYNTHESIZED_WIRE_0 <= NOT(stall);



SYNTHESIZED_WIRE_7 <= NOT(stall);



brTaken <= branch AND eq;

jmpTarget(30) <= pcSeq(30);


jmpTarget(29) <= pcSeq(29);


jmpTarget(31) <= pcSeq(31);


jmpTarget(28) <= pcSeq(28);



b2v_inst3 : constant4
PORT MAP(		 result => SYNTHESIZED_WIRE_6);


b2v_inst4 : constant0
PORT MAP(		 result => SYNTHESIZED_WIRE_5);


SYNTHESIZED_WIRE_1 <= NOT(stall);



SYNTHESIZED_WIRE_8 <= NOT(stall);



b2v_instr_mux : mux2_32
PORT MAP(s => flush,
		 d0 => imem_out,
		 d1 => SYNTHESIZED_WIRE_5,
		 y => if_instr);


b2v_jump_shft : sl2_26
PORT MAP(a => instruction(25 DOWNTO 0),
		 y => jmpTarget(27 DOWNTO 0));


b2v_mem_wb_pipe_reg : pr_mem_wb
PORT MAP(clk => clk,
		 reset => reset,
		 mem_memToReg => mem_memToReg,
		 mem_regWrite => mem_regWrite,
		 mem_aluOut => mem_aluOut,
		 mem_mo => mem_mo,
		 mem_rd => mem_rd,
		 wb_memToReg => wb_memToReg,
		 wb_regWrite => wb_regWrite,
		 wb_aluOut => wb_aluOut,
		 wb_mo => wb_mo,
		 wb_rd => wb_rd);


b2v_npc_mux : mux2_32
PORT MAP(s => flowChange,
		 d0 => pcf,
		 d1 => pcTarget,
		 y => npc);


b2v_pc_adder : adder
PORT MAP(a => pc,
		 b => SYNTHESIZED_WIRE_6,
		 y => pcf);


b2v_pc_reg : flopr
PORT MAP(clk => clk,
		 reset => reset,
		 loadEn => SYNTHESIZED_WIRE_7,
		 d => npc,
		 q => pc);


b2v_pcTarg_mux : mux2_32
PORT MAP(s => jump,
		 d0 => brTarget,
		 d1 => jmpTarget,
		 y => pcTarget);


b2v_pipeline_control : pipe_ctrl
PORT MAP(isStore => isStore,
		 isNop => isNop,
		 readsRs => readsRs,
		 readsRt => readsRt,
		 branch => branch,
		 jump => jump,
		 brTaken => brTaken,
		 ex_regWrite => ex_regWrite,
		 ex_isLoad => ex_isLoad,
		 mem_regWrite => mem_regWrite,
		 mem_isLoad => mem_isLoad,
		 ex_rd => ex_rd,
		 mem_rd => mem_rd,
		 rs => instruction(25 DOWNTO 21),
		 rt => instruction(20 DOWNTO 16),
		 flush => flush,
		 flowChange => flowChange,
		 stall => stall,
		 id_eqFwdA => id_eqFwdA,
		 id_eqFwdB => id_eqFwdB,
		 id_forwardA => id_forwardA,
		 id_forwardB => id_forwardB);


b2v_regfile : syncregfile
PORT MAP(clk => clk,
		 reset => reset,
		 we3 => wb_regWrite,
		 ldEn => SYNTHESIZED_WIRE_8,
		 ra1 => if_instr(25 DOWNTO 21),
		 ra2 => if_instr(20 DOWNTO 16),
		 wa3 => wb_rd,
		 wd3 => wb_writeData,
		 rd1 => id_rdA,
		 rd2 => id_rdB);


b2v_src1Bypass_mux : mux3_32
PORT MAP(d0 => ex_rdA,
		 d1 => wb_writeData,
		 d2 => mem_aluOut,
		 s => ex_forwardA,
		 y => a);


b2v_src2Bypass_mux : mux3_32
PORT MAP(d0 => ex_rdB,
		 d1 => wb_writeData,
		 d2 => mem_aluOut,
		 s => ex_forwardB,
		 y => ex_src2);


b2v_upper_imm : sl16_32
PORT MAP(a => instruction(15 DOWNTO 0),
		 y => uimmed);


b2v_wd_mux : mux2_32
PORT MAP(s => wb_memToReg,
		 d0 => wb_aluOut,
		 d1 => wb_mo,
		 y => wb_writeData);


END bdf_type;
