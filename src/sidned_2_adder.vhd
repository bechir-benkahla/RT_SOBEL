library IEEE;
use IEEE.std_logic_1164.all;
use work.common.all;

entity signed_2_adder is
port(A : in longlonglongpixel;
	B : in longlonglongpixel;
	Y : out long4pixel);
end entity;

architecture adder_arch of signed_2_adder is

begin
	Y <= A + B;
end adder_arch ;