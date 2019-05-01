library ieee;
use ieee.std_logic_1164.all;
use work.common.all;

entity reg_dec_n is
	generic(N : integer :=8);
	port(	d : IN pixel;
		clk,rst: in std_logic;
		o: out pixel;
		output: out pixel_array((N-1) downto 0)
	);
end entity;

architecture arch of reg_dec_n is

component bascule_d is
	port(	D:IN pixel;
		H,R : IN std_logic ;
		Q : OUT pixel
	);
end component ;

signal c:pixel_array(N downto 0);
begin
	c(0)<=D;
	o<=c(N);
	output<=c(N downto 1);
	for1:for i in 0 to N-1 generate
		basi:  bascule_d port map(H=>clk,D=>c(i),R=>rst,Q=>c(i+1));
	end generate;
end arch;