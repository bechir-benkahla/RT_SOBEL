library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity signed_mult is
port(A : in longpixel;
	B : in longpixel;
	Y : out longlongpixel);
end entity;

architecture mult_arch of signed_mult is
begin
	Y <= A * B;
end mult_arch ;