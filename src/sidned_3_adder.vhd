library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity signed_3_adder is
port(A : in long4pixel;
	B : in long4pixel;
	Y : out long5pixel);
end entity;

architecture adder_arch of signed_3_adder is

begin
	Y <= A + B;
end adder_arch ;