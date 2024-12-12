--
--
--
--

entity mux_4_1 is
    port(
        SEL     : in std_logic_vector(1 downto 0);
        A       : in std_logic_vector(3 downto 0);
        Y       : out std_logic;
    );
end entity;