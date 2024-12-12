--a_igual_b

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Vhdl4 is
    Port ( a1, a0, b1, b0 : in STD_LOGIC;
           resultado : out STD_LOGIC );
end Vhdl4;

architecture Behavioral of Vhdl4 is
begin
    resultado <= (not a1 and not a0 and not b1 and not b0) or
                 (not a1 and a0 and not b1 and b0) or
                 (a1 and a0 and b1 and b0) or 
                 (a1 and not a0 and b1 and not b0);
end Behavioral;
