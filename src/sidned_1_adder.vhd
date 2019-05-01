library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity signed_1_adder is
port(A : in longlongpixel;
	B : in longlongpixel;
	Y : out longlonglongpixel);
end entity;

architecture adder_arch of signed_1_adder is

begin
	Y <= A + B;
end adder_arch ;