library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity signed_4_adder is
port(A : in long5pixel;
	B : in long5pixel;
	Y : out long6pixel);
end entity;

architecture adder_arch of signed_4_adder is

begin
	Y <= A + B;
end adder_arch ;