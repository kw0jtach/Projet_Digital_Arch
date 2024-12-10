library ieee;
use ieee.std_logic_1164.all;

entity SubBytes_tb is
end entity;

architecture archTB of SubBytes_tb is

    signal input_data : std_logic_vector(127 downto 0);
    signal output_data : std_logic_vector(127 downto 0);

    component SubBytes is
    port (
        input_data : in std_logic_vector(127 downto 0);
        output_data : out std_logic_vector(127 downto 0)
    );
    end component;

    begin
        UUT : SubBytes port map (input_data => input_data, output_data => output_data);

        input_data <= x"40BFABF406EE4D3042CA6B997A5C5816";


end architecture;