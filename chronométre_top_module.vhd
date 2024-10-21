library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.all;

entity chronometre is
port( clk, reset, start, pause, rec, raz : in std_logic ;
	cpt_ms : out std_logic_vector (11 downto 0);
	cpt_s : out std_logic_vector ( 5 downto 0);
	reg_ms : out std_logic_vector (11 downto 0);
	reg_s : out std_logic_vector ( 5 downto 0));
end chronometre;

architecture arch_chronometre of chronometre is 

signal raz_cnt, rec_reg, clk_div, enable_count, carry : std_logic;
signal cnt_s: std_logic_vector ( 5 downto 0);
signal cnt_ms : std_logic_vector ( 11 downto 0);
signal up_s : std_logic;
begin

timer_ms_1 : entity timer_ms port map (
	clk 	=> clk,
	raz 	=> raz_cnt, 
	en   	=> enable_count,
	carry 	=> carry,
    	count 	=> cnt_ms
);

timer_s_1: entity  timer_s port map (
	clk	=> clk,
	raz	=> raz_cnt, 
	en  	=> up_s,
    count   =>  cnt_s  
);

cpt_s <= cnt_s;
cpt_ms <= cnt_ms;
up_s <= enable_count and carry;

me_chrono_1 : entity  me_chrono port map (
	clk	=> clk,
	reset  	=> reset,
    	start	=> start,
	pause	=> pause,
	rec     => rec,	
	raz => raz,
    enable	=> enable_count,
	rec_reg => rec_reg,   
	raz_cnt => raz_cnt 
);


registre_ms: entity registre generic map( N => 12) port map (
	clk	=> clk,
	reset	=> reset,
	load 	=> rec_reg,
    	d_in  	=> cnt_ms,
    	d_out   => reg_ms
);

registre_s: entity registre generic map( N => 6) port map (
	clk	=> clk,
	reset	=> reset,
	load 	=> rec_reg,
    	d_in  	=> cnt_s,
    	d_out   => reg_s
);



end arch_chronometre;