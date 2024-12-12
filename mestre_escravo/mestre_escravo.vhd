
library ieee;
use ieee.std_logic_1164.all;


entity mestre_escravo is
port(
		d   : in std_logic;
		clk : in std_logic;
		q  : out std_logic;
		qn : out std_logic);
		
end mestre_escravo;

architecture comportamento of mestre_escravo is

signal x1,x2,x3,x4,x5,x6,s1,s2 : std_logic;


begin

 x1 <= d nand not(clk);
 x2 <= not(d) nand not(clk);
 x3 <= x4 nand x1;
 x5 <= x3 nand clk;
 x4 <= x3 nand x2;
 x6 <= x4 nand clk;
 s1 <= s2 nand x5;
 q <= s1;
 s2 <= s1 nand x6;
 qn <= s2;
 

 end comportamento;