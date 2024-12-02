library ieee;
use ieee.std_logic_1164.all;

entity tb_AES_128 is
end entity;

architecture sim of tb_AES_128 is
    signal clk         : std_logic := '1';
    signal rst         : std_logic := '0';
    signal input_data  : std_logic_vector(127 downto 0) := x"6BC1BEE22E409F96E93D7E117393172A";
    signal output_data : std_logic_vector(127 downto 0);

    component AES_128 is
        port (
            clk         : in std_logic;
            rst         : in std_logic;
            input_data  : in std_logic_vector(127 downto 0);
            output_data : out std_logic_vector(127 downto 0)
        );
    end component;

begin
    AES_iinst: AES_128 port map (clk => clk, rst => rst, input_data => input_data, output_data => output_data);
    
    process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;

    process
    begin
        rst <= '1';
        wait for 3 ns;
        rst <= '0';
        wait for 500 ns;
        wait;
    end process;

end architecture;
