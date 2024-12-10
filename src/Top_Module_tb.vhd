library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top_Module_tb is
end entity;

architecture sim of Top_Module_tb is

    signal CLK_100MHZ_tb : std_logic := '0';
    signal btnC_tb       : std_logic := '0';
    signal btnR_tb       : std_logic := '0';
    signal ANODE_ACT_tb  : std_logic_vector(3 downto 0);
    signal SEG_OUT_tb    : std_logic_vector(6 downto 0);
    signal BCD_SW_tb     : std_logic_vector(1 downto 0) := (others => '0');
    signal plaintext_tb  : std_logic_vector(127 downto 0);
    signal SubBytes_tt_tb      : std_logic_vector(127 downto 0);
    signal ShiftRows_tt_tb      : std_logic_vector(127 downto 0);
    signal MixColumns_tt_tb      : std_logic_vector(127 downto 0);
    signal AddRoundKey_tt_tb     : std_logic_vector(127 downto 0);
    signal key_TT_tb     : std_logic_vector(127 downto 0);
    signal round_cnt_TT_tb : std_logic_vector(3 downto 0);
    signal ciphertext_tb : std_logic_vector(127 downto 0);
    signal done_tb       : std_logic;
    signal rst_tb        : std_logic;

    component Top_Module is
        port (
            CLK_100MHZ : in std_logic;
            ANODE_ACT : out std_logic_vector(3 downto 0);
            SEG_OUT : out std_logic_vector(6 downto 0);
            BCD_SW : out std_logic_vector(1 downto 0);
            btnC : in std_logic;
            btnR : in std_logic;
            plaintext : in std_logic_vector(127 downto 0);
            SubBytes_tt : out std_logic_vector(127 downto 0);
            ShiftRows_tt : out std_logic_vector(127 downto 0);
            MixColumns_tt : out std_logic_vector(127 downto 0);
            AddRoundKey_tt : out std_logic_vector(127 downto 0);
            key_TT : out std_logic_vector(127 downto 0);
            round_cnt_TT : out std_logic_vector(3 downto 0);
            ciphertext : out std_logic_vector(127 downto 0);
            done : out std_logic;
            rst : out std_logic
        );
    end component;

begin

    UUT: Top_Module
        port map (
            CLK_100MHZ => CLK_100MHZ_tb,
            ANODE_ACT => ANODE_ACT_tb,
            SEG_OUT => SEG_OUT_tb,
            BCD_SW => BCD_SW_tb,
            btnC => btnC_tb,
            btnR => btnR_tb,
            plaintext => plaintext_tb,
            SubBytes_tt => SubBytes_tt_tb,
            ShiftRows_tt => ShiftRows_tt_tb,
            MixColumns_tt => MixColumns_tt_tb,
            AddRoundKey_tt => AddRoundKey_tt_tb,
            key_TT => key_TT_tb,
            round_cnt_TT => round_cnt_TT_tb,
            ciphertext => ciphertext_tb,
            done => done_tb,
            rst => rst_tb
        );

    clk_gen : process
    begin
        CLK_100MHZ_tb <= not CLK_100MHZ_tb;
        wait for 5 ns;
    end process;

    stimulus : process
    begin

        wait for 40 ns;

        btnC_tb <= '1';
        wait for 10 ns;
        btnC_tb <= '0';

        plaintext_tb <= x"6BC1BEE22E409F96E93D7E117393172A";
        wait for 200 ns;

        btnR_tb <= '1';
        wait for 10 ns;
        btnR_tb <= '0';
        
        wait for 20 ns;

        btnC_tb <= '1';
        wait for 10 ns;
        btnC_tb <= '0';

        wait for 200 ns;
        wait;
    end process;

end sim;

