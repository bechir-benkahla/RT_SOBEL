library ieee;
use ieee.std_logic_1164.all;
use work.common.all;


entity convolutionneur is
	port ( mask : IN pixel_matrix(0 to 2,0 to 2);
			ker : IN pixellong_matrix(0 to 2,0 to 2);
			respix: out long6pixel
	      );
end entity;

architecture arch_convolutionneur of convolutionneur is 

signal s1 : longlongpixel_array(0 to 8);
signal s2 : longlonglongpixel_array(0 to 3);
signal s3 : long4pixel_array(0 to 1); 
signal s4 : long5pixel_array(0 to 1);

	component signed_mult is
	port(A : in longpixel;
		B : in  longpixel;
		Y : out longlongpixel);
	end component;

component signed_1_adder is
port(A : in longlongpixel;
	B : in longlongpixel;
	Y : out longlonglongpixel);
end component;

component signed_2_adder is
port(A : in longlonglongpixel;
	B : in longlonglongpixel;
	Y : out long4pixel);
end component;

component signed_3_adder is
port(A : in long4pixel;
	B : in long4pixel;
	Y : out long5pixel);
end component;

component signed_4_adder is
port(A : in long5pixel;
	B : in long5pixel;
	Y : out long6pixel);
end component;

begin

m1:signed_mult port map(ker(0,0),mask(0,0),s1(0));
m2:signed_mult port map(ker(0,1),mask(1,0),s1(1));
m3:signed_mult port map(ker(0,2),mask(2,0),s1(2));
m4:signed_mult port map(ker(1,0),mask(0,1),s1(3));
m5:signed_mult port map(ker(1,1),mask(1,1),s1(4));
m6:signed_mult port map(ker(1,2),mask(2,1),s1(5));
m7:signed_mult port map(ker(2,0),mask(0,2),s1(6));
m8:signed_mult port map(ker(2,1),mask(1,2),s1(7));
m9:signed_mult port map(ker(2,2),mask(2,2),s1(8));


s4(1)<=s1(8);


a1:signed_1_adder port map(s1(0),s1(1),s2(0));
a2:signed_1_adder port map(s1(2),s1(3),s2(1));
a3:signed_1_adder port map(s1(4),s1(5),s2(2));
a4:signed_1_adder port map(s1(6),s1(7),s2(3));

a5:signed_2_adder port map(s2(0),s2(1),s3(0));
a6:signed_2_adder port map(s2(2),s2(3),s3(1));

a7:signed_3_adder port map(s3(0),s3(1),s4(0));

a8:signed_4_adder port map(s4(0),s4(1),respix);

end arch_convolutionneur;