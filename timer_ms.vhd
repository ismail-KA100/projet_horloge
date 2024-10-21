library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity timer_ms is
port(   clk, raz, en   :   in std_logic;
      eoc : out std_logic;
      count       :   out std_logic_vector(11 downto 0):="000000000000");
end timer_ms;
 
architecture arch_timer_ms of timer_ms is
signal count_int : unsigned (11 downto 0):="000000000000";
begin
    process(clk)
        begin
       
       if rising_edge(clk) then
                  if raz='1' then count_int <= (others => '0');
                  elsif en = '1' then
                              if count_int="001111100111" then count_int <= (others => '0'); -- fin de comptage
                              else count_int <= count_int + 1; -- "+"(unsigned,int)
                              end if;
            end if;     
        end if;
    end process;
 
    count <= std_logic_vector(count_int);
    eoc <= '1' when count_int = "001111100111" else '0';
 
end arch_timer_ms;


library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TIMER_MS_tb is
end TIMER_MS_tb;

architecture test of TIMER_MS_tb  is

    signal clk :  std_logic :='0';
   signal   en :  std_logic;
   signal raz :  std_logic;
    signal eoc:  std_logic;
    signal count:  std_logic_vector(11 downto 0);
component  TIMER_MS
 port( clk : in std_logic;
       en : in std_logic;
       raz : in std_logic;
       eoc: out std_logic;
       count: out std_logic_vector(11 downto 0)
);
end  component ;
begin

dut:

entity work. TIMER_MS(arch_TIMER_MS)port map( clk=>clk,eoc=>eoc,count=>count ,en=>en ,raz=>raz);

clk<= not(clk) after 10 ns;
en<='1';
raz<='0';
end;