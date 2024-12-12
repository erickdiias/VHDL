library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hc_sr04 is
    Port (
        clk         : in  STD_LOGIC; -- Clock principal
        reset       : in  STD_LOGIC; -- Reset do sistema
        trigger_en  : in  STD_LOGIC; -- Habilitação do trigger
        echo        : in  STD_LOGIC; -- Entrada do pulso do echo
        trigger     : out STD_LOGIC; -- Saída do pulso do trigger
        distance    : out INTEGER    -- Distância calculada
    );
end hc_sr04;

architecture Behavioral of hc_sr04 is
    -- Constante para 10 µs (ajuste conforme a frequência do clock)
    constant TRIGGER_COUNT : integer := 100; -- Exemplo para clock de 1 MHz
    constant SOUND_SPEED : integer := 343; -- Velocidade do som em m/s
    signal trigger_pulse : integer := 0;
    signal echo_time : integer := 0;
    signal echo_counter : integer := 0;
    signal measuring : STD_LOGIC := '0';
begin
    -- Gerar o pulso do trigger
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                trigger <= '0';
                trigger_pulse <= 0;
            elsif trigger_en = '1' and trigger_pulse < TRIGGER_COUNT then
                trigger <= '1';
                trigger_pulse <= trigger_pulse + 1;
            else
                trigger <= '0';
                trigger_pulse <= 0;
            end if;
        end if;
    end process;

    -- Medir a largura do pulso echo
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                echo_time <= 0;
                echo_counter <= 0;
                measuring <= '0';
            elsif echo = '1' then
                measuring <= '1';
                echo_counter <= echo_counter + 1;
            elsif measuring = '1' and echo = '0' then
                measuring <= '0';
                echo_time <= echo_counter;
                echo_counter <= 0;
            end if;
        end if;
    end process;

    -- Calcular a distância
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                distance <= 0;
            elsif echo_time > 0 then
                -- Distância = (tempo x velocidade do som) / 2
                distance <= (echo_time * SOUND_SPEED) / (2 * 1_000_000); -- Divisão para µs
            end if;
        end if;
    end process;
end Behavioral;
