library ieee;
use ieee.std_logic_1164.all;

entity RoundKeys is 
    port(
        round_cnt : in std_logic_vector(3 downto 0);
        key : out std_logic_vector(127 downto 0)
); end RoundKeys;

architecture arch of RoundKeys is

begin
    process(round_cnt) is
        begin 
            case round_cnt is
                when x"0" => key <= x"2b7e151628aed2a6abf7158809cf4f3c";
                when x"1" => key <= x"a0fafe1788542cb123a339392a6c7605";
                when x"2" => key <= x"f2c295f27a96b9435935807a7359f67f";
                when x"3" => key <= x"3d80477d4716fe3e1e237e446d7a883b";
                when x"4" => key <= x"ef44a541a8525b7fb671253bdb0bad00";
                when x"5" => key <= x"d4d1c6f87c839d87caf2b8bc11f915bc";
                when x"6" => key <= x"6d88a37a110b3efddbf98641ca0093fd";
                when x"7" => key <= x"4e54f70e5f5fc9f384a64fb24ea6dc4f";
                when x"8" => key <= x"ead27321b58dbad2312bf5607f8d292f";
                when x"9" => key <= x"ac7766f319fadc2128d12941575c006e";
                when x"a" => key <= x"d014f9a8c9ee2589e13f0cc8b6630ca6";
                when others => key <= x"00000000000000000000000000000000";
            end case;
        end process;

end arch ; -- arch