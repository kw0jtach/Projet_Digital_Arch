library ieee;
use ieee.std_logic_1164.all;

entity PIPO_Register_tb is
end entity;

architecture arch of PIPO_Register_tb is
    component PIPO_Register is
        generic (N: integer);
        port(
            Clk: in std_logic;
            D: in std_logic_vector(N-1 downto 0);
            Q: out std_logic_vector(N-1 downto 0)
        );
    end component;

    signal Clk : std_logic := '1';
    signal D, Q: std_logic_vector(127 downto 0);

begin 
    pipo_reg: PIPO_Register generic map (N => 128) port map (Clk => Clk, D => D, Q => Q);

    clock_process: process
    begin
        Clk <= not Clk;
        wait for 5 ns;
    end process;

    D_process: process
    begin
        D <= x"2b7e151628aed2a6abf7158809cf4f3c";
        wait for 12 ns;
        D <= x"a0fafe1788542cb123a339392a6c7605";
        wait for 12 ns;
        D <= x"f2c295f27a96b9435935807a7359f67f";
        wait for 12 ns;
        D <= x"3d80477d4716fe3e1e237e446d7a883b";
        wait for 12 ns;
    end process;


end architecture arch;