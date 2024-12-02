library ieee;
use ieee.std_logic_1164.all;

entity tb_SB_SR_MC_ARK is
end entity;

architecture behavior of tb_SB_SR_MC_ARK is
    component SB
        port(
            input_data : in std_logic_vector(127 downto 0);
            output_data : out std_logic_vector(127 downto 0)
        );
    end component;

    component SR
        port(
            input_dataa : in std_logic_vector(127 downto 0);
            output_dataa : out std_logic_vector(127 downto 0)
        );
    end component;

    component MC
        port(
            state_in  : in std_logic_vector(127 downto 0);
            state_out : out std_logic_vector(127 downto 0)
        );
    end component;

    component ARK
        port(
            input_data : in std_logic_vector(127 downto 0);
            key : in std_logic_vector(127 downto 0);
            output_data : out std_logic_vector(127 downto 0)
        );
    end component;

    -- Signals to connect components
    signal input_data : std_logic_vector(127 downto 0);
    signal output_data_SB : std_logic_vector(127 downto 0);
    signal output_data_SR : std_logic_vector(127 downto 0);
    signal output_data_MC : std_logic_vector(127 downto 0);
    signal output_data_ARK : std_logic_vector(127 downto 0);
    signal key : std_logic_vector(127 downto 0);

begin

    UUT_SB: SB port map ( input_data => input_data, output_data => output_data_SB );

    UUT_SR: SR port map ( input_dataa => output_data_SB, output_dataa => output_data_SR );

    UUT_MC: MC port map ( state_in => output_data_SR, state_out => output_data_MC );

    UUT_ARK: ARK
        port map (
            input_data => output_data_MC,
            key => key,
            output_data => output_data_ARK
        );

    stimulus: process
    begin
        input_data <= x"40BFABF406EE4D3042CA6B997A5C5816";
        key <= x"a0fafe1788542cb123a339392a6c7605";
        wait for 10 ns; 

        -- End of test
        wait;
    end process;
end architecture;
