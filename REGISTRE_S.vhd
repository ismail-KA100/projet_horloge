library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity REGISTRE_S is
port(   clk, reset ,load  :   in std_logic;
      d_in        :   in std_logic_vector(6 downto 0):="0000000";
        d_out       :  out std_logic_vector(6 downto 0):="0000000"
);
end REGISTRE_S;


architecture arch_REGISTRE_S of  REGISTRE_S is
--signal d_int :std_logic_vector (11 downto 0):="000000000000";
begin
    process(clk)
        begin
         if reset='1' then
              d_out<=  (others => '0');
         elsif rising_edge(clk) then
           if load='1' then
           -- d_int <= d_in;
              d_out<=d_in;
           else
           d_out<=  (others => '0');
      end if;
      end if;

end process;
--d_out<=d_int;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity REGISTRE_S_tb is
end  REGISTRE_S_tb;

architecture test of  REGISTRE_S_tb  is

signal clk         :   std_logic:='0';
signal reset       :   std_logic;
signal load        :   std_logic:='0';
signal d_in        :   std_logic_vector(6 downto 0);
signal   d_out     :   std_logic_vector(6 downto 0);
component REGISTRE_S
port(   clk, reset ,load  :   in std_logic;
      d_in        :   in std_logic_vector(6 downto 0);
        d_out       :  out std_logic_vector(6 downto 0)
);
end  component ;
begin

dut:
entity work. REGISTRE_S(arch_REGISTRE_S)port map( clk=>clk, reset => reset ,load  => load , d_in  =>  d_in , d_out =>d_out);

clk<= not(clk) after 10 ns;
 reset<='0';
load<='1'   after 100 ns;
d_in <= "0100100";
end;
