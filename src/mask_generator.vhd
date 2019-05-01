library ieee;
use ieee.std_logic_1164.all;
use work.common.all;

entity mask_generator is
	generic (width  : integer range 0 to 4096 :=24);--
	port ( datain : IN pixel ;
			clock : IN std_logic ;
			reset : IN std_logic ;
			mask : OUT pixel_matrix(0 to 2,0 to 2) 
	      );
end entity;

architecture arch of mask_generator is 

	signal S : pixel_array(2 downto 0);
	signal CR2,CR3 : pixel_array( (width-1) downto 0 );
	signal CR1 : pixel_array(2 downto 0);
	signal pix : pixel;
	component reg_dec_n is
		generic(N : integer :=8);
		port(	d : IN pixel;
			clk,rst: in std_logic;
			o: out pixel;
			output: out pixel_array((N-1) downto 0)
		);
	end component;
	
begin
	
	reg_dec1 : reg_dec_n 
		generic map (N=>3)
		port map (clk=>clock,d=>datain,rst=>reset,o=>S(0),output=>CR1);
		
	reg_dec2 : reg_dec_n 
		generic map (N=>width)
		port map (clk=>clock,d=>S(0),rst=>reset,o=>S(1),output=>CR2);
		
	reg_dec3 : reg_dec_n
		generic map (N=>width)
		port map (clk=>clock,d=>S(1),rst=>reset,o=>S(2),output=>CR3);
	
	mask_gliss:process(clock)
	variable cpt : integer range 0 to 5001:=0;
	begin 
		if(clock='1')then
			if (cpt<2*width+3) then 
				cpt:=cpt+1;
			else
				mask(0,0)<=CR3((width-1));
				mask(0,1)<=CR3((width-2));
				mask(0,2)<=CR3((width-3));
				mask(1,0)<=CR2((width-1));
				mask(1,1)<=CR2((width-2));
				mask(1,2)<=CR2((width-3));
				mask(2,0)<=CR1(2);
				mask(2,1)<=CR1(1);
				mask(2,2)<=CR1(0);	
			end if;
		end if;

	end process;

	
end arch;