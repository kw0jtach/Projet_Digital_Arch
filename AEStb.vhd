library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AES_tb is
end entity;

architecture sim of AES_tb is


    component AES
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

    signal ciphertext_1  : std_logic_vector(127 downto 0);
    signal ciphertext_2  : std_logic_vector(127 downto 0);
    signal ciphertext_3  : std_logic_vector(127 downto 0);
    signal ciphertext_4  : std_logic_vector(127 downto 0);

    type ptext is array(0 to 3) of std_logic_vector(127 downto 0);
    constant plaintexts : ptext := (
        x"6BC1BEE22E409F96E93D7E117393172A",
        x"AE2D8A571E03AC9C9EB76FAC45AF8E51",
        x"30C81C46A35CE411E5FBC1191A0A52EF",
        x"F69F2445DF4F9B17AD2B417BE66C3710" 
    );

begin

    AES_inst : AES
        port map (
            clk        => clk,
            rst        => rst,
            plaintext  => plaintext,
            ciphertext => ciphertext,
            done       => done
        );

    process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;


    stimulus_process : process
        variable i : integer := 0;
    begin
        for i in 0 to 3 loop

            rst <= '1';
            plaintext <= plaintexts(i);
            wait for 10 ns;            
            rst <= '0';            

            wait until done = '1';

            case i is
                when 0 => ciphertext_1 <= ciphertext;
                when 1 => ciphertext_2 <= ciphertext;
                when 2 => ciphertext_3 <= ciphertext;
                when 3 => ciphertext_4 <= ciphertext;
                when others => null;
            end case;

            wait for 20 ns;
        end loop;

        wait;
    end process;

end architecture;



