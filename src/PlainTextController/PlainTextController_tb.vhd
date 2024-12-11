library ieee;
use ieee.std_logic_1164.all;

entity TB_PlainTextController is
end TB_PlainTextController;

architecture sim of TB_PlainTextController is

    component PlainTextController is
        port(
            CLK_100MHZ    : in std_logic; 
            BCD_SW : in std_logic_vector(1 downto 0); 
            rst    : in std_logic;                 
            plaintext_out : out std_logic_vector(127 downto 0)
        );
    end component;


    signal BCD_SW : std_logic_vector(1 downto 0);
    signal rst    : std_logic;
    signal CLK_100MHZ    : std_logic;
    signal plaintext_out : std_logic_vector(127 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    DUT: PlainTextController
        port map(
            CLK_100MHZ => CLK_100MHZ,
            BCD_SW => BCD_SW,
            rst => rst,
            plaintext_out => plaintext_out
        );

    clk_process: process
    begin
        CLK_100MHZ <= '0';
        wait for CLK_PERIOD / 2;
        CLK_100MHZ <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    stim_proc: process
    begin
        
        BCD_SW <= "00";
        rst <= '0';
        wait for 20 ns;

        rst <= '1';
        wait for CLK_PERIOD;

        BCD_SW <= "01";
        wait for CLK_PERIOD;
        
        BCD_SW <= "10";
        wait for CLK_PERIOD;

        wait;
    end process;

end sim;