library ieee;
use ieee.std_logic_1164.all;

entity AddRoundKey_tb is
end entity;

architecture archTB of AddRoundKey_tb is
    
    signal input_data : std_logic_vector(127 downto 0);
    signal key : std_logic_vector(127 downto 0);
    signal output_data : std_logic_vector(127 downto 0);

    component AddRoundKey is 
    port (
        input_data : in std_logic_vector(127 downto 0);
        key : in std_logic_vector(127 downto 0);
        output_data : out std_logic_vector(127 downto 0)
    );
    end component;

    begin
        UUT : AddRoundKey port map (input_data => input_data, key => key, output_data => output_data);
        
        input_data <= x"6BC1BEE22E409F96E93D7E117393172A";
        key <= x"2B7E151628AED2A6ABF7158809CF4F3C";

end architecture;