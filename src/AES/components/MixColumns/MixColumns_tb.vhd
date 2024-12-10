library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MixColumns_tb is
end entity;

architecture archTB of MixColumns_tb is

    component MixColumns is
        Port (
            state_in  : in  STD_LOGIC_VECTOR(127 downto 0);
            state_out : out STD_LOGIC_VECTOR(127 downto 0)
        );
    end component;

    signal state_in  : STD_LOGIC_VECTOR(127 downto 0);
    signal state_out : STD_LOGIC_VECTOR(127 downto 0);
    signal clk       : STD_LOGIC := '0';

begin

    uut: MixColumns Port map (state_in => state_in, state_out => state_out);
    
    clk_process: process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;
    stim_proc: process
    begin
        state_in <= x"09287F476F746ABF2C4A6204DA08E3EE";
        
        wait;
    end process;
end architecture;
