library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity andInv is
	port(
		a     : in  std_logic_vector(31 downto 0);
	        reset : in  std_logic;
		y     : out std_logic_vector(9  downto 0)
	);
end entity andInv;

architecture RTL of andInv is
begin
	y <= a(11 downto 2) when reset = '0' else (others=>'0');
end architecture RTL;
