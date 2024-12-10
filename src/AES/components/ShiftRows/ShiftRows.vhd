library ieee;
use ieee.std_logic_1164.all;

entity ShiftRows is 
    port(
        input_data : in std_logic_vector(127 downto 0);
        output_data : out std_logic_vector(127 downto 0)
    );
end entity;

architecture arch of ShiftRows is
    begin
        output_data <= 
            input_data(127 downto 120) & input_data(87 downto 80) & input_data(47 downto 40) & input_data(7 downto 0) &
            input_data(95 downto 88) & input_data(55 downto 48) & input_data(15 downto 8) & input_data(103 downto 96) &
            input_data(63 downto 56) & input_data(23 downto 16) & input_data(111 downto 104) & input_data(71 downto 64) &
            input_data(31 downto 24) & input_data(119 downto 112) & input_data(79 downto 72) & input_data(39 downto 32);
end architecture;
            