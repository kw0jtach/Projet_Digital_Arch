library ieee;
use ieee.std_logic_1164.all;  

entity ARK is 
    port (
        input_data : in std_logic_vector(127 downto 0);
        key : in std_logic_vector(127 downto 0);
        output_data : out std_logic_vector(127 downto 0)
    );
end entity;

architecture arch of ARK is
    begin
        output_data <= input_data xor key;
end architecture;