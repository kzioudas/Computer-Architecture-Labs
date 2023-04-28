library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipe_ctrl is
	port(
		rs            : in  std_logic_vector(4 downto 0);
		rt            : in  std_logic_vector(4 downto 0);
		isStore       : in  std_logic;
		isNop         : in  std_logic;
		readsRs       : in  std_logic;
		readsRt       : in  std_logic;
		branch        : in  std_logic;
		jump          : in  std_logic;
		brTaken       : in  std_logic;
		-- From Stage Ex  --
		ex_rd         : in  std_logic_vector(4 downto 0);
		ex_regWrite   : in  std_logic;
		ex_isLoad     : in  std_logic;
		-- From Stage Mem --
		mem_rd        : in  std_logic_vector(4 downto 0);
		mem_regWrite  : in  std_logic;
		mem_isLoad    : in  std_logic;
		--  For Stage IF  --
		flush         : out std_logic;
		flowChange    : out std_logic;
		stall         : out std_logic;
		--  For Stage ID  --
		id_forwardA   : out std_logic_vector(1 downto 0) := "00"; -- Select Register from Register File.
		id_forwardB   : out std_logic_vector(1 downto 0) := "00"; -- Select Register from Register File.
		id_eqFwdA     : out std_logic := '0';
		id_eqFwdB     : out std_logic := '0'
	);
end entity pipe_ctrl;

architecture RTL of pipe_ctrl is
	signal ofStall : std_logic;
	constant empty : std_logic_vector(4 downto 0) := (others => '0');
begin
	stall         <= ofStall;
	flush         <= (branch and brTaken and not ofStall) or jump;
	flowChange    <= (branch and brTaken and not ofStall) or jump;


    ------------------------------------------------------------------------------------------------------------------------------------------
    -- NOTE : This list must contain all signals used in expressions below. If you add anything else in an expression, add it in the list too!
    ------------------------------------------------------------------------------------------------------------------------------------------
	stalling : process(rs, rt, isStore, isNop, readsRs, readsRt, branch, ex_rd, ex_regWrite, ex_isLoad, mem_rd, mem_regWrite, mem_isLoad)
	begin
		ofStall <= '0'; -- Normally, no stalling happens.

	    -- Forwarding Control for Operand A (rs):
	    -- 00 -- From Register File.
	    -- 01 -- From Stage Mem to Stage Ex.
	    -- 10 -- From Stage Wb to Stage Ex.
        id_forwardA <= "00";

	    -- Forwarding Control for Operand B (rt):
	    -- It is only needed for R-type Instructions and Sw.
	    -- However, since the immediate mux is after the bypass mux,
	    -- it is unimportant when Rt is not a source. (e.g. addi, lw) 
        id_forwardB <= "00";

	    -- Forwarding Logic to Equality Comparator of Stage ID (Input A)
        id_eqFwdA <= '0';
    
	    -- Forwarding Logic to Equality Comparator of Stage ID (Input B)
        id_eqFwdB <= '0';


		-- -- Conservative Stalling. NO BYPASSING, except internally in register file.
		-- Stalls for Data Dependence on Rs:
  		if ((ex_regWrite = '1' and rs = ex_rd) or (mem_regWrite = '1' and rs = mem_rd)) and rs /= empty and readsRs = '1' and isNop = '0' then
			-- Valid Instruction at Stage Ex and Reading the same Register, or
			-- Valid Instruction at Stage Mem and Reading the same Register,
			-- and the Register is not $zero, the Rs is actually read, and the Instruction is not Nop.
  			ofStall <= '1';
  		end if;
		-- Stalls for Data Dependence on Rt:
  		if ((ex_regWrite = '1' and rt = ex_rd) or (mem_regWrite = '1' and rt = mem_rd)) and rt /= empty and readsRt = '1' and isNop = '0' then
			-- Valid Instruction at Stage Ex and Reading the same Register, or
			-- Valid Instruction at Stage Mem and Reading the same Register,
			-- and the Register is not $zero, the Rt is actually read, and the Instruction is not Nop.
  			ofStall <= '1';
  		end if;
		-- Checking for Stalls from a Branch at Stage Id is for naught, as it is covered already.
		-- If there is a dependence on an Instruction on Stage Wb, the value is forwarded
		-- automatically inside the Register File, by writting itself on the same place.

	end process stalling;
end architecture RTL;
