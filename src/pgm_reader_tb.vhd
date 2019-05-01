library ieee;
use ieee.std_logic_1164.all;
use work.pgm.all;
use work.common.all;

-- we suppose that the max image resolution is 4096x4096

entity pgm_reader_tb is 
	port (	c,r : IN std_logic;
			wdt,hgt : out dimension;
			pix : out pixel
	      );
end entity;

architecture pgm_reader_arch_tb of pgm_reader_tb is
	Type ST is (INIT,RD,FIN);
	Signal state: ST:=INIT; 

	
begin
	P : Process(c)
	 	variable i : pixel_matrix_ptr;
		variable H : dimension :=0;
		variable W : dimension :=0;
		variable x : dimension :=0;
		variable y : dimension :=0;
	Begin 
	if(c='1') then
		IF (state = INIT) then 
			i := pgm_read("feep.pgm");
			W:=i.all'length(1);
			wdt<=W;
			H:=i.all'length(2);
			hgt<=H;
			state<=RD;
			-- Pour ne pas perdre un cycle d'horloage
			pix<=i.all(y,x);
			if(x=H-1) then
				if(y=W-1) then
					state<=FIN;
				elsif(y<W-1) then
					x:=0;
					y:=y+1;
				end if;
			elsif(x<H-1)then
				if(y=W-1)then
					y:=0;
					x:=x+1;
				elsif(y<W-1) then
					y:=y+1;
				end if;
			end if;
		elsif (state = RD) then
			pix<=i.all(y,x);
			if(x=H-1) then
				if(y=W-1) then
					state<=FIN;
				elsif(y<W-1) then
					x:=0;
					y:=y+1;
				end if;
			elsif(x<H-1)then
				if(y=W-1)then
					y:=0;
					x:=x+1;
				elsif(y<W-1) then
					y:=y+1;
				end if;
			end if;

		end if;
	end if ;
	End Process P;

end pgm_reader_arch_tb ; 