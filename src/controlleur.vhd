library ieee;
use ieee.std_logic_1164.all;
use work.common.all;

entity controlleur is 
	generic(wdt : IN dimension:=512;
		hgt: IN dimension:=512);
	port(clock,rst : IN std_logic; 	
		x_out,y_out : out dimension;
		wr_or_rep : OUT std_logic;
	deb,fin_out : out std_logic 
	);
end entity;

architecture arch_controlleur of controlleur is
		Type STATE is (BFRSTART,START_WR,RP,FIN);
		Signal st: STATE:=BFRSTART;
		signal nst : STATE;
		signal cp : nbele;
		
		signal x : dimension:=0;
		signal y : dimension:=0;

		
begin

	State_update : Process(clock)
	Begin
		if (clock='1') then 
			cp<=cp+1;
			st<= nst;
		end if ;
	End Process State_update;

	Actions :Process(st,clock, nst)
	Begin	
		-- Mise a jou de x et y 
		if (clock'event) and (clock='1') then
			if(st=BFRSTART) and (nst=BFRSTART) THEN
				x<= (cp) / wdt;
				y<= (cp) rem wdt ;
			    	x_out<= (cp) / wdt;
				y_out<= (cp) rem wdt;	

			ELSE
				x<= (cp-(wdt+2)) / wdt;
				y<= (cp-(wdt+2)) rem wdt ;
			    	x_out<= (cp-(wdt+2)) / wdt;
				y_out<= (cp-(wdt+2)) rem wdt;
			END IF ;
		end if ;
		-- Mise a jour de deb et fin 
		CASE st IS
			WHEN BFRSTART =>
				IF(nst=st)THEN 
					deb<='0';
					fin_out<='0';
				ELSE 
					deb<='1';
					fin_out<='0';
				END IF ;

			WHEN START_WR => deb<='1';
				    	fin_out<='0';
					wr_or_rep<='1';

			WHEN RP => 	deb<='1';
					fin_out<='0';
					wr_or_rep<='0';

			WHEN FIN =>     deb<='0';
					fin_out<='1';

		END CASE;	

	End Process Actions;
		
	next_state_update :Process(st,x,y,cp)
	Begin	
		CASE st IS
			WHEN BFRSTART => IF (cp<2*wdt+3) THEN
						nst<= st;
					ELSE
						nst<= START_WR;
						
					END IF;
			
			WHEN START_WR => IF (y>0)and(y<wdt-2) THEN
					nst<= st;
				ELSE
					nst<= RP;
				END IF;
			
			WHEN RP => IF (x=hgt-1) and (y= 0) THEN
					nst<= FIN;
			           ELSIF (y=wdt-1) THEN
					nst<= st;
				   ELSE
					nst<= START_WR;
				   END IF;
			WHEN FIN =>
		END CASE;
	
	End Process next_state_update;

	
end arch_controlleur;
