library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity timer_s is
port(   clk, raz, en   :   in std_logic;
      count       :   out std_logic_vector(6 downto 0):="0000000"
);
end timer_s;
 
architecture arch_timer_s of timer_s is
signal count_int : unsigned (6 downto 0):="0000000";
begin
    process(clk)
        begin
       
       if rising_edge(clk) then
                  if raz='1' then count_int <= (others => '0');
                  elsif en = '1' then
                              if count_int="0111011" then count_int <= (others => '0'); -- fin de comptage
                              else count_int <= count_int + 1; -- "+"(unsigned,int)
                              end if;
            end if;     
        end if;
    end process;
 
    count <= std_logic_vector(count_int);
   
 
end arch_timer_s;


---------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TIMER_S_tb is
end TIMER_S_tb;

architecture test of TIMER_S_tb  is

    signal clk :  std_logic :='0';
   signal   en :  std_logic;
   signal raz :  std_logic;
    signal count:  std_logic_vector(6 downto 0);
component  TIMER_S
 port( clk : in std_logic;
       en : in std_logic;
       raz : in std_logic;
       count: out std_logic_vector(6 downto 0)
);
end  component ;
begin

dut:

entity work. TIMER_S(arch_TIMER_S)port map( clk=>clk,count=>count ,en=>en ,raz=>raz);

clk<= not(clk) after 10 ns;
en<='1';
raz<='0';
end;
