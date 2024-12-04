library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rc_tb is
end entity;


architecture sim of rc_tb is

    component RoundKeys is
        port (
            round_cnt : in std_logic_vector(3 downto 0);
            key : out std_logic_vector(127 downto 0)
        );
    end component;

    signal round_cnt : std_logic_vector(3 downto 0);
    signal key : std_logic_vector(127 downto 0);

begin
    round_keys_inst : RoundKeys
        port map (
            round_cnt => round_cnt,
            key => key
        );
    
    stim: process
    begin
        round_cnt <= x"0";
        wait for 5 ns;
        round_cnt <= x"1";
        wait for 5 ns;
        round_cnt <= x"2";
        wait for 5 ns;
        round_cnt <= x"3";
        wait for 5 ns;
        round_cnt <= x"4";
        wait for 5 ns;
        round_cnt <= x"5";
        wait for 5 ns;
        round_cnt <= x"6";
        wait for 5 ns;
        round_cnt <= x"7";
        wait for 5 ns;
        round_cnt <= x"8";
        wait for 5 ns;
        round_cnt <= x"9";
        wait for 5 ns;
        round_cnt <= x"a";
        wait;
    end process;
end architecture;