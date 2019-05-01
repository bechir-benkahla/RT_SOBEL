library ieee;
use ieee.std_logic_1164.all;
use work.common.all;


entity mask_processor is
	port ( msk : IN pixel_matrix(0 to 2,0 to 2); 
			EH,EV,EDL,EDR : out long6pixel 
	      );
end entity;

architecture mask_processor_arch of mask_processor is 
signal MH,MV,MDL,MDR : pixellong_matrix(0 to 2,0 to 2);

component convolutionneur is
	port ( mask : IN pixel_matrix(0 to 2,0 to 2);
			ker : IN pixellong_matrix(0 to 2,0 to 2);
			respix: out long6pixel
	      );
end component;

begin



MH(0,0)<=1;MH(0,1)<=2;MH(0,2)<=1;
MH(1,0)<=0;MH(1,1)<=0;MH(1,2)<=0;
MH(2,0)<=-1;MH(2,1)<=-2;MH(2,2)<=-1;

MV(0,0)<=-1;MV(0,1)<=0;MV(0,2)<=1;
MV(1,0)<=-2;MV(1,1)<=0;MV(1,2)<=2;
MV(2,0)<=-1;MV(2,1)<=0;MV(2,2)<=1;

MDR(0,0)<=2;MDR(0,1)<=1;MDR(0,2)<=0;
MDR(1,0)<=1;MDR(1,1)<=0;MDR(1,2)<=-1;
MDR(2,0)<=0;MDR(2,1)<=-1;MDR(2,2)<=-2;

MDL(0,0)<=0;MDL(0,1)<=1;MDL(0,2)<=2;
MDL(1,0)<=-1;MDL(1,1)<=0;MDL(1,2)<=1;
MDL(2,0)<=-2;MDL(2,1)<=-1;MDL(2,2)<=0;

hconv : convolutionneur port map(mask=>msk,ker=>MH,respix=>EH);
vconv : convolutionneur port map(mask=>msk,ker=>MV,respix=>EV);
dlconv : convolutionneur port map(mask=>msk,ker=>MDL,respix=>EDL);
drconv : convolutionneur port map(mask=>msk,ker=>MDR,respix=>EDR);


end  mask_processor_arch;
