library ieee;
use ieee.std_logic_1164.all;


entity D_FF is port(
    D : in std_logic; 
    Clk : in std_logic; 
    Q : out std_logic
); end D_FF;

architecture arch of D_FF is begin
    proc : process(Clk) is begin
        if (rising_edge(Clk)) then
            Q <= D;
        end if;
    end process proc;
end arch;