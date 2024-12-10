library ieee;
use ieee.std_logic_1164.all;

entity Controller is
  port (
    CLK_100MHZ : in std_logic;
    btnC : in std_logic;
    btnR : in std_logic;
    rst : out std_logic
  );
end Controller;

architecture arch of Controller is
  signal rst_int : std_logic; 
  signal init    : std_logic;
begin

    process(btnC, btnR)
    begin
        if init = '1' then 
            if btnC = '0' and btnC'event then
                rst_int <= '0';
            elsif btnR = '0' and btnR'event then
                rst_int <= '1';
            else
                rst_int <= rst_int; 
            end if;
        else    
            init <= '1';
            rst_int <= '1';
        end if;
    end process;

    rst <= rst_int;

end arch;



