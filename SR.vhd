library ieee;
use ieee.std_logic_1164.all;

entity SR is 
    port(
        input_dataa : in std_logic_vector(127 downto 0);
        output_dataa : out std_logic_vector(127 downto 0)
    );
end entity;

architecture arch of SR is
    begin
        process(input_dataa)
        begin
            output_dataa <= input_dataa(127 downto 120) & input_dataa(87 downto 80) & input_dataa(47 downto 40) & input_dataa(7 downto 0) &
                        input_dataa(95 downto 88) & input_dataa(55 downto 48) & input_dataa(15 downto 8) & input_dataa(103 downto 96) &
                        input_dataa(63 downto 56) & input_dataa(23 downto 16) & input_dataa(111 downto 104) & input_dataa(71 downto 64) &
                        input_dataa(31 downto 24) & input_dataa(119 downto 112) & input_dataa(79 downto 72) & input_dataa(39 downto 32);
        end process;
end architecture;
            