library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MCtb is
end entity;

architecture archTB of MCtb is

    component MC is
        Port (
            state_in  : in  STD_LOGIC_VECTOR(127 downto 0);
            state_out : out STD_LOGIC_VECTOR(127 downto 0)
        );
    end component;

    signal state_in  : STD_LOGIC_VECTOR(127 downto 0);
    signal state_out : STD_LOGIC_VECTOR(127 downto 0);
    signal clk       : STD_LOGIC := '0';

begin

    uut: MC Port map (state_in => state_in, state_out => state_out);
    
    clk_process: process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;
    stim_proc: process
    begin
        state_in <= x"09287F476F746ABF2C4A6204DA08E3EE";
        wait for 10 ns;
        state_in <= x"89B5884AC05653032E389B21604D123C";
        wait for 10 ns;
        state_in <= x"54FE6141B3B0EAB968D310AFD60D641E";
        wait for 10 ns;
        wait;
    end process;
end architecture;


