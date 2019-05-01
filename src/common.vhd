library ieee;
use ieee.std_logic_1164.all;


package common  is
	subtype coordinate is natural;
	subtype dimension is integer range 0 to 4096;
	subtype nbele is integer range 0 to 16777216;
  	subtype pixel is integer range 0 to 255;-- 8 bits
	subtype longpixel is integer range -512 to 511; --10 bits
	subtype longlongpixel is integer range -524288 to 524287; --20 bits 
	subtype longlonglongpixel is integer range -1048576  to 1048575;--21 bits
	subtype long4pixel is integer range -2097152 to 2097151;--22 bits
	subtype long5pixel is integer range -4194304 to 4194303;--23 bits
	subtype long6pixel is integer range -8388608 to 8388607;--24 bits
	subtype long7pixel is integer range -16777216 to 16777215;--25 bits
	subtype long8pixel is integer range -33554432 to 33554431;--26 bits
	type pixel_array is array(natural range <>) of pixel;
	type pixel_array_ptr is access pixel_array;
	type longpixel_array is array(natural range <>) of longpixel;
	type longlongpixel_array is array(natural range <>) of longlongpixel;
	type longlonglongpixel_array is array(natural range <>) of longlonglongpixel;
	type long4pixel_array is array(natural range <>) of long4pixel;
	type long5pixel_array is array(natural range <>) of long5pixel;
	type long6pixel_array is array(natural range <>) of long6pixel;
    type pixel_matrix is array (coordinate range <>, coordinate range <>) of pixel;
	type pixellong_matrix is array (coordinate range <>, coordinate range <>) of longpixel;
    type pixel_matrix_ptr is access pixel_matrix;
end common ;