library ieee;
use ieee.std_logic_1164.all;

entity Controller_tb is
end Controller_tb;

architecture behavior of Controller_tb is
    signal CLK_100MHZ : std_logic := '0';
    signal btnC       : std_logic := '0';
    signal btnR       : std_logic := '0';
    signal rst        : std_logic;
    
    component Controller is
    port (
        CLK_100MHZ : in std_logic;
        btnC : in std_logic;
        btnR : in std_logic;
        rst : out std_logic
    );
    end component;
    
begin

    uut: Controller
        port map (
            CLK_100MHZ => CLK_100MHZ,
            btnC       => btnC,
            btnR       => btnR,
            rst        => rst
        );

    clk_process :process
    begin
        CLK_100MHZ <= not CLK_100MHZ;
        wait for 5ns;
    end process;

    stimulus_process: process
    begin

        btnC <= '0';
        btnR <= '0';
        wait for 20 ns;

        btnC <= '1';
        wait for 20 ns;
        btnC <= '0';
        wait for 20 ns;

        btnR <= '1';
        wait for 20 ns;
        btnR <= '0';
        wait for 20 ns;

        btnC <= '1';
        wait for 20 ns;
        btnC <= '0';
        wait for 20 ns;

        btnR <= '1';
        wait for 20 ns;
        btnR <= '0';
        wait for 20 ns;
        wait;
    end process;

end behavior;
