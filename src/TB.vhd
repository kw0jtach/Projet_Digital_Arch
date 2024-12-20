library ieee;
use ieee.std_logic_1164.all;

entity TB_TopModule is
end TB_TopModule;

architecture sim of TB_TopModule is

    component TopModule is
        port (
            CLK_100MHZ : in std_logic;
            ANODE_ACT : out std_logic_vector(3 downto 0);
            SEG_OUT : out std_logic_vector(6 downto 0);
            BCD_SW : in std_logic_vector(1 downto 0);
            btnC : in std_logic;
            btnR : in std_logic
            --plaintext : out std_logic_vector(127 downto 0);
            --ciphertext : out std_logic_vector(127 downto 0);
            --done : out std_logic;
            --rst : out std_logic
        );
    end component;

    signal CLK_100MHZ : std_logic := '0';
    signal ANODE_ACT : std_logic_vector(3 downto 0);
    signal SEG_OUT : std_logic_vector(6 downto 0);
    signal BCD_SW : std_logic_vector(1 downto 0) := "00";
    signal btnC : std_logic := '0';
    signal btnR : std_logic := '0';
    --signal plaintext : std_logic_vector(127 downto 0);
    --signal ciphertext : std_logic_vector(127 downto 0);
    --signal done : std_logic;
    --signal rst : std_logic;

    -- Constantes pour le timing
    constant CLK_PERIOD : time := 10 ns;

begin

    DUT: TopModule
        port map(
            CLK_100MHZ => CLK_100MHZ,
            ANODE_ACT => ANODE_ACT,
            SEG_OUT => SEG_OUT,
            BCD_SW => BCD_SW,
            btnC => btnC,
            btnR => btnR
            --plaintext => plaintext,
            --ciphertext => ciphertext,
            --done => done,
            --rst => rst
        );

    clk_process: process
    begin
        while true loop
            CLK_100MHZ <= '0';
            wait for CLK_PERIOD / 2;
            CLK_100MHZ <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_proc: process
    begin

        wait for 20 ns;

        btnC <= '1';
        wait for 20 ns;
        btnC <= '0';
        wait for 200 ns;

        BCD_SW <= "01";
        wait for 20 ns;
        BCD_SW <= "10";
        wait for 200 ns;
        BCD_SW <= "11";
        wait for 20 ns;

        btnR <= '1';
        BCD_SW <= "10";
        
        wait for 100 ns;
        btnR <= '0';
        wait for 20 ns;
        btnC <= '1';
        wait for 20 ns;
        btnC <= '0';

        wait;
    end process;

end sim;
