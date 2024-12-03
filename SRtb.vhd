library ieee;
use ieee.std_logic_1164.all;

entity SRtb is
end entity;

architecture archTB of SRtb is
    signal input_data : std_logic_vector(127 downto 0);
    signal output_data : std_logic_vector(127 downto 0);

    component SR is
        port (
            input_dataa : in std_logic_vector(127 downto 0);
            output_dataa : out std_logic_vector(127 downto 0)
        );
    end component;

begin
    SR_comp : SR port map (input_dataa => input_data, output_dataa => output_data);
    srprocess : process
    begin
        input_data <= x"090862BF6F28E3042C747FEEDA4A6A47";
        wait for 10 ns;

        input_data <= x"894D9B03C0B512212E56883C6038534A";
        wait for 10 ns;
        wait;
    end process;

end architecture;
