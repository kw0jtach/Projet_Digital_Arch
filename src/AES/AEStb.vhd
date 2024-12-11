library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AES_tb is
end entity;

architecture sim of AES_tb is

    
    component AES is
    port (
        clk           : in std_logic;
        rst           : in std_logic;
        plaintext     : in std_logic_vector(127 downto 0);
        ciphertext    : out std_logic_vector(127 downto 0);
        done          : out std_logic
    );
    end component;

    signal clk           : std_logic := '0';
    signal rst           : std_logic := '0';
    signal plaintext     : std_logic_vector(127 downto 0);
    signal ciphertext    : std_logic_vector(127 downto 0);
    signal done          : std_logic;

begin 

    AES_inst : AES
        port map (
            clk        => clk,
            rst        => rst,
            plaintext  => plaintext,
            ciphertext => ciphertext,
            done       => done
        );

    clk_process: process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;

    stim: process
    begin
        plaintext <= x"6BC1BEE22E409F96E93D7E117393172A";
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait;
    end process;


end architecture;