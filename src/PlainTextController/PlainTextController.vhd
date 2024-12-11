library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PlainTextController is
    port(
        CLK_100MHZ    : in std_logic; 
        BCD_SW : in std_logic_vector(1 downto 0); 
        rst    : in std_logic;                 
        plaintext_out : out std_logic_vector(127 downto 0)
    );
end PlainTextController;

architecture arch of PlainTextController is

    signal plaintext_reg : std_logic_vector(127 downto 0);

    component PlainTexts is
        port(
            number : in std_logic_vector(1 downto 0);
            plaintext : out std_logic_vector(127 downto 0)
        );
    end component;

    signal selected_plaintext : std_logic_vector(127 downto 0);

begin

    LUT_instance: PlainTexts
        port map(
            number => BCD_SW,
            plaintext => selected_plaintext
        );

    process(rst, selected_plaintext)
    begin
        if rst = '1' then
            plaintext_reg <= selected_plaintext;
        end if;
    end process;

    process(CLK_100MHZ)
    begin
        if rising_edge(CLK_100MHZ) then
            plaintext_out <= plaintext_reg;
        end if;
    end process;

end arch;
