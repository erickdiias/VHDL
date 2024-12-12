-- Projeto: Led Blink
-- 
-- Autor: Erick S. Dias
-- Data: 03/12/2024

library ieee;
use ieee.std_logic_1164.all;

entity blink_led is
    port(
        clk : in std_logic;
        led : out std_logic
    );
end entity;

architecture main of blink_led is
    signal contador : integer := 0;
    signal led_status : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if contador = 50e6 then
                contador <= 0;
                led_status <= not led_status;
            else
                contador <= contador + 1;
            end if;
        end if;        
    end process;

    led <= led_status;
    
end architecture;