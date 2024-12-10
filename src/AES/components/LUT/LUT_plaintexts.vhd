library ieee;
use ieee.std_logic_1164.all;

entity PlainTexts is 
    port(
        number : in std_logic_vector(1 downto 0);
        plaintext : out std_logic_vector(127 downto 0)
); end PlainTexts;

architecture arch of PlainTexts is

begin
    process(number) is
        begin 
            case number is
                when x"0" => key <= x"6BC1BEE22E409F96E93D7E117393172A";
                when x"1" => key <= x"AE2D8A571E03AC9C9EB76FAC45AF8E51";
                when x"2" => key <= x"30C81C46A35CE411E5FBC1191A0A52EF";
                when x"3" => key <= x"F69F2445DF4F9B17AD2B417BE66C3710";
                when others => key <= x"00000000000000000000000000000000";
            end case;
        end process;
end arch ;