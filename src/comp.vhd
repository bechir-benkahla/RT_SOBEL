library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use WORK.COMMON.ALL;

-- main entity
entity ranger is
port (E_H, E_V, E_DL, E_DR            : in long6pixel;
	--max : IN pixel;
      S_H, S_V, S_DL, S_DR, S_QT, S_DT: out pixel);
end ranger;

architecture RANGER_ARCH of ranger is

signal SH: long7pixel:=0;
signal SV: long7pixel:=0;
signal SDL: long7pixel:=0;
signal SDR: long7pixel:=0;
signal SQT: long8pixel:=0;
signal SDT: long8pixel:=0;
begin
-- check if input is positif, else calculate its 2 complement

SH  <= (E_H) when ((to_signed(E_H,24) and "100000000000000000000000") = "000000000000000000000000") else
     to_integer(not (to_signed(E_H,25)) + 1) ;
SV  <= (E_V) when ((to_signed(E_V,24) and "100000000000000000000000") = "000000000000000000000000") else          
     to_integer(not (to_signed(E_V,25)) + 1);
SDL <= (E_DL) when ( ( to_signed(E_DL,24) and "100000000000000000000000" ) = "000000000000000000000000" ) else          
     to_integer(not ( to_signed(E_DL,25) ) +1);
SDR <= (E_DR) when ( ( to_signed(E_DR,24) and "100000000000000000000000" ) = "000000000000000000000000" ) else          
     to_integer(not ( to_signed(E_DR,25) ) +1);

SQT<=SH+SV;

SDT<=SDL+SDR;

-- here we set values greater than 255 to 255

S_H   <= (SH)  when (SH < 255)  else
         (255);
S_V   <= (SV)  when (SV < 255)  else
         (255);
S_DL  <= (SDL) when (SDL < 255) else
         (255);
S_DR  <= (SDR)  when (SDR < 255)  else
         (255);
S_QT  <= SQT when (SQT<255) else 
	  255;
S_DT  <= SDT when (SDT<255) else
	  255;

end RANGER_ARCH;
