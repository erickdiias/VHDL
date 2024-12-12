
--  Um controlador simples para os sensores ultrassônicos do tipo SRF05 ou HC-SR04
--  Trigger e Echo separados
	
--   /-----------------------------\
--   |      controlador do sensor  |
--   |         ultrassônico        |
--   |                             |	
--   |                      trigger -->
--   |                             |
--   |                  nova_medida -->
--   |                      timeout -->
--  --> echo                       | 
--   |           distancia_raw[20:0] ==>
--   |                             |
--  --> entrada                    |
--  --> clk                        |
--   |                             |
--   \-----------------------------/

--	* clk           : relógio (parâmetro CLK_MHZ, 50 MHz por padrão)
--	* entrada       : inicia uma medição por pulsação
--	* trigger       : a ser conectado ao pino Trig do sensor
--					(parâmetro TRIGGER_PULSE_US, 12 us por padrão)
--	* echo          : a ser conectado ao pino Echo do sensor
--	* nova_medida   : 1 pulsação se a medição estiver completa
--	* timeout       : 1 pulsação se ocorrer timeout (parâmetro TIMEOUT_MS, 20 ms por padrão)
--	* distancia_raw : a ser lido na pulsação de nova_medida
--						 dado da largura do sinal Echo codificado em 21 bits
--						 
--	  duração do sinal echo em microssegundos = distancia_raw / CLK_MHZ
--	 
--	  O sensor SRF05 tem um timeout de 30 ms se nenhum obstáculo for encontrado.
--	  Pode-se simular um timeout inferior com o parâmetro TIMEOUT_MS
--	  Se o sinal Echo não retornar após esse TIME_OUT, o controlador
--	  bloqueia distancia_raw, gera uma pulsação na saída nova_medida e na saída timeout.  	

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity ultrasonic is
    generic (
        CLK_MHZ : integer := 50;               -- frequência do relógio em MHz
        TRIGGER_PULSE_US : integer := 12;      -- duração da pulsação do trigger em microssegundos
        TIMEOUT_MS : integer := 25             -- timeout em milissegundos
    );
    port (
        clk : in std_logic;                    -- sinal de relógio
        entrada : in std_logic;                -- sinal de início de medição
        echo : in std_logic;                   -- entrada do pino Echo do sensor
        trigger : out std_logic;               -- saída para o pino Trig do sensor
        nova_medida : out std_logic;           -- indica quando a medição está completa
        timeout : out std_logic;               -- indica timeout na medição
        distancia_raw : out std_logic_vector(20 downto 0) -- largura do sinal Echo em 21 bits
    );
end entity ultrasonic;

architecture Behavioral of ultrasonic is

    constant COUNT_TRIGGER_PULSE : integer := CLK_MHZ * TRIGGER_PULSE_US;
    constant COUNT_TIMEOUT : integer := CLK_MHZ * TIMEOUT_MS * 1000;

    type estado is (IDLE, TRIG, WAIT_ECHO_UP, MEASURING, MEDICAO_OK);
    signal estado_atual, proximo_estado : estado := IDLE;

    signal contador : unsigned(20 downto 0) := (others => '0');
    signal contador_habilitado : std_logic;
    signal em_medicao : std_logic;

begin

    -- Lógica de estado_atual
    process(clk)
    begin
        if rising_edge(clk) then
            estado_atual <= proximo_estado;
        end if;
    end process;

    -- Controle do estado_atual
    process(estado_atual, entrada, echo, contador)
    begin
        proximo_estado <= estado_atual; -- por padrão, mantém o estado_atual atual
        case estado_atual is
            when IDLE =>
                if entrada = '1' then
                    proximo_estado <= TRIG;
                end if;

            when TRIG =>
                if to_integer(contador) >= COUNT_TRIGGER_PULSE then
                    proximo_estado <= WAIT_ECHO_UP;
                end if;

            when WAIT_ECHO_UP =>
                if echo = '1' then
                    proximo_estado <= MEASURING;
                end if;

            when MEASURING =>
                if to_integer(contador) >= COUNT_TIMEOUT or echo = '0' then
                    proximo_estado <= MEDICAO_OK;
                end if;

            when MEDICAO_OK =>
                proximo_estado <= IDLE;

            when others =>
                proximo_estado <= IDLE;
        end case;
    end process;

    -- Habilitação do contador
    contador_habilitado <= '1' when (estado_atual = TRIG or estado_atual = MEASURING) else '0';

    -- Incremento do contador
    process(clk)
    begin
        if rising_edge(clk) then
            if contador_habilitado = '1' then
                contador <= contador + 1;
            else
                contador <= (others => '0');
            end if;
        end if;
    end process;

    -- Atualização de distancia_raw
    process(clk)
    begin
        if rising_edge(clk) then
            if contador_habilitado = '1' and estado_atual = MEASURING then
                distancia_raw <= std_logic_vector(contador);
            end if;
        end if;
    end process;

    -- Sinais de saída
    trigger <= '1' when estado_atual = TRIG else '0';
    nova_medida <= '1' when estado_atual = MEDICAO_OK else '0';
    timeout <= '1' when (estado_atual = MEDICAO_OK and to_integer(contador) >= COUNT_TIMEOUT) else '0';

end architecture Behavioral;
