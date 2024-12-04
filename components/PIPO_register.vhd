library ieee;
use ieee.std_logic_1164.all;


entity PIPO_Register is
    generic (N: integer);
    port(
        Clk: in std_logic;
        D: in std_logic_vector(N-1 downto 0);
        Q: out std_logic_vector(N-1 downto 0)
); end entity PIPO_Register;


architecture arch of PIPO_Register is
    begin
        process(Clk)
            begin
                if (rising_edge(Clk)) then
                    Q <= D;
                end if;
        end process ;
end architecture arch;