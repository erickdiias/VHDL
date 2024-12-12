--
--
-- Autor: Erick S. Dias
-- Data: 05/12/24

library ieee;
use ieee.std_logic_1164.all;

entity mealy is
    port(
        clk, rst, Z : in std_logic;
        W           : out std_logic
        );
end entity;

architecture main of mealy is
    type estado is (A, B);
    signal estado_atual, proximo_estado : estado;
begin
    sincrono : process(clk, rst)
    begin
        if (rst = '1') then
            estado_atual <= A;
        elsif ( rising_edge(clk)) then
            estado_atual <= proximo_estado;
        end if;
    end process sincrono;

    combinacional : process(estado_atual, Z)
    begin
        case estado_atual is
            when A =>
            if(Z = '0') then
                proximo_estado <= A;
                W <= '0';
            else
                proximo_estado <= B;
                W <= '0';
            end if;

            when B =>
            if(Z = '0') then
                proximo_estado <= A;
                W <= '0';
            else
                proximo_estado <= B;
                W <= '1';
            end if;
        end case;
    end process combinacional;
end architecture;