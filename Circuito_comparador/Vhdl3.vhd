--a_menor_b

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Vhdl3 is
    Port ( a1, a0, b1, b0 : in STD_LOGIC;
           resultado : out STD_LOGIC );
end Vhdl3;

architecture Behavioral of Vhdl3 is
begin
    resultado <= (not a1 and b1) or 
                 (not a0 and b0 and b1) or 
					  (not a1 and not a0 and b0);
end Behavioral;
