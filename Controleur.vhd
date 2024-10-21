library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity me_chrono is
port(   clk,reset   :   in std_logic;
    	start, pause, rec, raz     :   in std_logic;
    	enable, rec_reg, raz_cnt       :   out std_logic);
end me_chrono;
 
architecture arch_me_chrono of me_chrono is
type etat_me is (RESET_STATE, START_STATE, REC_STATE, AFTER_REC_STATE, PAUSE_STATE);
signal etat_cr, etat_sv : etat_me;
begin
----------------------------------------------------------------------------------
    process(clk,reset)  -- registre synchrone, maj etat_cr
    begin
        if reset='1' then etat_cr <= RESET_STATE;
        elsif rising_edge(clk) then etat_cr <= etat_sv;
        end if;
    end process;
 
----------------------------------------------------------------------------------  
    process(start, pause, rec, etat_cr, raz)    -- process combinatoire
    begin
    enable <= '0';rec_reg<= '0'; raz_cnt <= '0' ; etat_sv <= etat_cr; -- sorties par defaut
     
    case etat_cr is
        when RESET_STATE => if start='1' then etat_sv <= START_STATE; end if; -- maj etat_sv
							raz_cnt <= '1' ;
 
        when START_STATE => 	if pause='1' then etat_sv <= PAUSE_STATE; 
		 		elsif 	rec= '1' then etat_sv <= REC_STATE;
		 		elsif 	raz = '1' then etat_sv <= RESET_STATE;
				end if; 
                		enable <= '1';   

	when REC_STATE => 	etat_sv <=AFTER_REC_STATE;
				
				rec_reg <= '1';
				enable <= '1';

	when AFTER_REC_STATE =>  if rec='0' then etat_sv <= START_STATE;
							end if;
				enable <= '1';


	when PAUSE_STATE =>  	if raz='1' then etat_sv <= RESET_STATE; 
							elsif start = '1' then etat_sv <= START_STATE;
							end if;
    end case;   
    end process;
----------------------------------------------------------------------------------
end arch_me_chrono;