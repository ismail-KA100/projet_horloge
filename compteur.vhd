library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
USE ieee.std_logic_unsigned.all;  
entity compteur is
port( clk : in std_logic;
      sout : out std_logic
);
end compteur;
architecture rtl of compteur  is
constant c_CNT_100HZ : natural := 125;
signal toogle: std_logic := '0';
signal cnt:natural range 0 to c_CNT_100HZ;
begin
--signal souta :std_logic
process(clk)
begin
    if (rising_edge (clk)) then
       if cnt=c_CNT_100HZ then
       toogle<=not(toogle);
        cnt<= 0;      
       
         else
         cnt<=cnt + 1;
      end if;
   end if;
end process;
sout<=toogle;

end rtl;

---------------------------------------------------------------test bench-----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity compteur_tb is
end compteur_tb;

architecture test of compteur_tb  is

signal clk :std_logic:='0';
signal sout:std_logic;
component compteur
port( clk : in std_logic;
      sout : out std_logic
);
end  component ;
begin

dut:

entity work.compteur(rtl)port map( clk=>clk, sout=> sout);

clk<= not(clk) after 10 ns;

end;
