library ieee;
use ieee.std_logic_1164.all;


entity SubBytes is 
    port(
        input_data : in std_logic_vector(127 downto 0);
        output_data : out std_logic_vector(127 downto 0)
    );
end entity;

architecture arch of SubBytes is
    component S_box is
        port( byte_in : in std_logic_vector(7 downto 0);
               byte_out: out std_logic_vector(7 downto 0));
    end component;
    
    begin
        gen : for i in 0 to 15 generate
            S_Box_i : S_box port map(byte_in => input_data((8*i)+7 downto 8*i), byte_out => output_data((8*i)+7 downto 8*i));
        end generate;


end architecture;