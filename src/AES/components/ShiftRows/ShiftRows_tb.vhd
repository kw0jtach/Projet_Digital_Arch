library ieee;
use ieee.std_logic_1164.all;

entity ShiftRows_tb is
end entity;

architecture archTB of ShiftRows_tb is
    signal input_data : std_logic_vector(127 downto 0);
    signal output_data : std_logic_vector(127 downto 0);

    component ShiftRows is
        port (
            input_data : in std_logic_vector(127 downto 0);
            output_data : out std_logic_vector(127 downto 0)
        );
    end component;

begin
    ShiftRows_comp : ShiftRows port map (input_data => input_data, output_data => output_data);
    ShiftRowsprocess : process
    begin
        input_data <= x"090862BF6F28E3042C747FEEDA4A6A47";
        
        wait;
    end process;

end architecture;
