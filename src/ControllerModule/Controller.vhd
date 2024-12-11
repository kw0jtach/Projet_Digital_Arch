library ieee;
use ieee.std_logic_1164.all;

entity Controller is
  port (
    CLK_100MHZ : in std_logic;
    btnC       : in std_logic;
    btnR       : in std_logic;
    rst        : out std_logic
  );
end Controller;

architecture arch of Controller is
    signal rst_int : std_logic := '1'; 
    signal init    : std_logic := '0';
    signal btnC_old: std_logic := '0';
    signal btnR_old: std_logic := '0';
begin

    process(CLK_100MHZ)
    begin
        if rising_edge(CLK_100MHZ) then
            if init = '1' then
                if btnC = '1' then
                    btnC_old <= '1';
                elsif btnC = '0' and btnC_old = '1' then
                    rst_int <= '0';
                    btnC_old <= '0';
                end if;
                if btnR = '1' then
                    btnR_old <= '1';
                elsif btnR = '0' and btnR_old = '1' then
                    rst_int <= '1';
                    btnR_old <= '0';
                end if;
            else
                init <= '1';
                rst_int <= '1';
            end if;
        end if;
    end process;

    rst <= rst_int;

end arch;