library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flope5 is
    port(
        clk    : in  std_logic;
	loadEn : in  std_logic;
        d      : in  std_logic_vector(4 downto 0);
        q      : out std_logic_vector(4 downto 0)
    );
end entity flope5;

architecture RTL of flope5 is
begin
    proc : process(clk)
    begin
       if (rising_edge(clk)) then
           if (loadEn = '1') then
               q <= d after 10 ns;
           end if;
       end if;
    end process proc;
end architecture RTL;
