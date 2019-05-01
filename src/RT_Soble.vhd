library ieee;
use ieee.std_logic_1164.all;
use work.common.all;

entity RT_Sobel is 
	generic(largeur : dimension := 300;
		hauteur : dimension := 246);
	port(horloage,rst : IN std_logic
	);
end entity;

architecture arch_sobel of RT_Sobel is 
signal s_pixel : pixel;
signal s_width : dimension:=0;
signal s_height : dimension:=0; 
signal mat_mask : pixel_matrix(0 to 2,0 to 2); 
signal REH,REV,REDL,REDR : long6pixel; 
signal SH, SV, SDL, SDR, SQT, SDT: pixel;
signal s_x,s_y : dimension;
signal s_deb,s_fin,s_wr_rp : std_logic;
signal S_SQT : pixel;

component pgm_reader_tb is 
		port (	c,r : IN std_logic;
			wdt,hgt : out dimension;
			pix : out pixel
	      );
end component;

component mask_generator is
	generic (width  : integer range 0 to 4096 :=512);--
	port ( datain : IN pixel ;
			clock : IN std_logic ;
			reset : IN std_logic ;
			mask : OUT pixel_matrix(0 to 2,0 to 2) 
	      );
end component;

component mask_processor is
	port ( msk : IN pixel_matrix(0 to 2,0 to 2); 
			EH,EV,EDL,EDR : out long6pixel 
	      );
end component;

component ranger is
port (E_H, E_V, E_DL, E_DR            : in long6pixel;
	--max : IN pixel;
      S_H, S_V, S_DL, S_DR, S_QT, S_DT: out pixel);
end component;

component controlleur is 
	generic(wdt : IN dimension:=512;
		hgt: IN dimension:=512);
	port(clock,rst : IN std_logic; 	
		x_out,y_out : out dimension;
		wr_or_rep : OUT std_logic;
	deb,fin_out : out std_logic 
	);
end component;

component pgm_writer_tb is 
	generic(wdt : IN dimension:=512;
		hgt: IN dimension:=512);
	port (	Pix: IN pixel;
			x_out,y_out : IN dimension;
			wr_or_rep : IN std_logic;
			deb,fin_out : IN std_logic 
	      );
end component;

begin 
reader: pgm_reader_tb 
	port map(c=>horloage,r=>rst,wdt=>s_width,hgt=>s_height,pix=>s_pixel);
mask_gen : mask_generator 
	generic map(width=>largeur)
	port map(datain=>s_pixel,clock=>horloage,reset=>rst, mask=>mat_mask);
mask_proc : mask_processor
	port map(msk=>mat_mask,EH=>REH,EV=>REV,EDL=>REDL,EDR=>REDR);
ranger_comp : ranger
	port map(E_H=>REH, E_V=>REV, E_DL=>REDL, E_DR=>REDR,S_H=>SH, S_V=>SV, S_DL=>SDL, S_DR=>SDR, S_QT=>SQT, S_DT=>SDT);
ctrl : controlleur 
	generic map(wdt=>largeur, hgt=>hauteur)
	port map(clock=>horloage,rst=>rst,x_out=>s_x,y_out=>s_y,wr_or_rep=>s_wr_rp,deb=>s_deb,fin_out=>s_fin);
writer : pgm_writer_tb 
	generic map(wdt=>largeur, hgt=>hauteur)
	port map(Pix=>SQT,x_out=>s_x,y_out=>s_y ,wr_or_rep=>s_wr_rp ,deb=>s_deb,fin_out =>s_fin);
end architecture arch_sobel;
