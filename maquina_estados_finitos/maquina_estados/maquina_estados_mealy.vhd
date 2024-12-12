--
--
--
--

library ieee;
use ieee.std_logic_1164.all;

entity maquina_estados_mealy is
    port(
        clk, reset, entrada : in std_logic;
        saida             : out std_logic
    );
end entity;

architecture comportamento of maquina_estados_mealy is
    type estado is (A, B);
    signal estado_atual, proximo_estado : estado;
begin
    -- Processo para definição do sincronismo da FSM
    sincrono : process(clk, reset)
    begin
        -- Aqui definimos os estados
        if (reset = '1') then
            estado_atual <= A;
        elsif (rising_edge(clk)) then
            estado_atual <= proximo_estado;
        end if;
    end process sincrono;

    -- Processo para logica combinacional da máquina
    combinacional : process(estado_atual, entrada)
    begin
        -- Aqui definimos o comportamento da saída
        saida <= '0';
        case(estado_atual) is
            when A =>
            if (entrada = '0') then
                proximo_estado <= A;
                saida <= '0';
            else
                proximo_estado <= B;
                saida <= '1';
            end if;

            when B =>
            if (entrada = '0') then
                proximo_estado <= B;
                saida <= '1';
            else
                proximo_estado <= A;
                saida <= '0';
            end if;
        end case;
    end process combinacional; 
end architecture;