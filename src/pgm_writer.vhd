library ieee;
use ieee.std_logic_1164.all;
use work.pgm.all;
use work.common.all;

-- we suppose that the max image resolution is 4096x4096

entity pgm_writer_tb is 
	generic(wdt : IN dimension:=512;
		hgt: IN dimension:=512);
	port (	Pix: IN pixel;
			x_out,y_out : IN dimension;
			wr_or_rep : IN std_logic;
			deb,fin_out : IN std_logic 
	      );
end entity;

architecture pgm_writer_arch_tb of pgm_writer_tb is
	
	type ST is (INIT,WR_RP,FIN,SAVE);
	signal state: ST:=INIT;

	
begin
	P1 : Process(x_out,y_out)
	variable m    : pixel_matrix_ptr := null;

	Begin
		CASE state IS
			WHEN INIT => 		-- allocation de la matrice
						m:=new pixel_matrix(0 to wdt-1, 0 to hgt-1);
						-- Remplissa des N+1 1er pixels
							for i in 0 to wdt-1 loop
								m.all(i,0):=0;
							end loop;
							m.all(0,1):=0;
						-- attendre que deb = 1 
							--wait until deb='1';
						-- changer d'etat
							if(deb='1') THEN state<=WR_RP; END IF;
			WHEN WR_RP => IF(wr_or_rep='1') THEN
							m.all(y_out,x_out):=Pix;
						  ELSE
							m.all(y_out,x_out):=0;
						  END IF;
						  iF(fin_out='1')THEN
							state<=FIN;
						  END IF;
			WHEN FIN => -- Remplissa des N derniers pixels
							for i in 0 to wdt-1 loop
								m.all(i,hgt-1):=0;
							end loop;
							state<= SAVE;
			WHEN SAVE =>	pgm_write ("sobel_out.pgm",m.all);
		END CASE;
	
	END Process P1;

end pgm_writer_arch_tb ; 