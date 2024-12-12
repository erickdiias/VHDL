--
--
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity decod_2_to_4 is port(

    B       : in std_logic_vector(1 downto 0);
    EN      : in std_logic;
    Y       : out std_logic_vector(3 downto 0)

);
end entity;

architecture hardware of decod_2_to_4 is
begin
    