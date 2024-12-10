library ieee;
use ieee.std_logic_1164.all;

entity mux_tb is
end entity;

architecture archTB of mux_tb is 

    component Multiplexer is 
    generic(N: integer);
    port(
        D0 : in std_logic_vector(N - 1 downto 0); -- feedback
        D1 : in std_logic_vector(N - 1 downto 0); -- plaintext
        SEL : in std_logic;
        Q : out std_logic_vector(N - 1 downto 0)
    );
    end component;

    signal feedback: std_logic_vector(127 downto 0) := x"AE2D8A571E03AC9C9EB76FAC45AF8E51";
    signal plaintext: std_logic_vector(127 downto 0) := x"6BC1BEE22E409F96E93D7E117393172A";
    signal SEL: std_logic := '1';
    signal Q: std_logic_vector(127 downto 0);
    
begin
    mux: Multiplexer generic map(N => 128) port map (D0 => feedback, D1 => plaintext, SEL => SEL, Q => Q);

    process
    begin 
        SEL <= '0';
        wait for 10 ns;
        SEL <= '1';
        wait for 10 ns;
    end process;

end architecture;

