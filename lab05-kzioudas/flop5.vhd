library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flop5 is
    port(
        clk    : in  std_logic;
        d      : in  std_logic_vector(4 downto 0);
        q      : out std_logic_vector(4 downto 0)
    );
end entity flop5;

architecture RTL of flop5 is
begin
    proc : process(clk)
    begin
       if (rising_edge(clk)) then
           q <= d after 10 ns;
       end if;
    end process proc;
end architecture RTL;
