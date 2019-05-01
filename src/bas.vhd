library ieee;
use ieee.std_logic_1164.all;
use work.common.all;

entity bascule_d is
	port(	D:IN pixel;
		H,R : IN std_logic ;
		Q : OUT pixel
	);
end bascule_d ;

architecture bascule_comp of bascule_d is
begin
	process(H)
	begin
		--if (R'event) then 
			--Q<=0;
		--end if;

		if(H='1') then
			Q<=D;
		end if;
	end process;
end bascule_comp;