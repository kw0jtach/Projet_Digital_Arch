library ieee;
use ieee.std_logic_1164.all;

entity Multiplexer is 
    generic(N: integer);
    port(
        D0 : in std_logic_vector(N - 1 downto 0); -- select 0
        D1 : in std_logic_vector(N - 1 downto 0); -- select 1
        SEL : in std_logic;
        Q : out std_logic_vector(N - 1 downto 0)
    );
end Multiplexer;

architecture arch of Multiplexer is begin
    with SEL select Q <= 
        D0 when '0',
        D1 when '1',
        x"00000000000000000000000000000000" when others;
end arch;
