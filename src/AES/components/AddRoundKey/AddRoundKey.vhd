library ieee;
use ieee.std_logic_1164.all;  

entity AddRoundKey is 
    port (
        input_data : in std_logic_vector(127 downto 0);
        key : in std_logic_vector(127 downto 0);
        output_data : out std_logic_vector(127 downto 0)
    );
end entity;

architecture arch of AddRoundKey is
    begin
        output_data <= input_data xor key;
end architecture;