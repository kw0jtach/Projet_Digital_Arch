library ieee;
use ieee.std_logic_1164.all;

entity TopModule is
  port (
    CLK_100MHZ : in std_logic;
    ANODE_ACT : out std_logic_vector(3 downto 0);
    SEG_OUT : out std_logic_vector(6 downto 0);
--    BCD_SW : out std_logic_vector(1 downto 0);
    btnC : in std_logic;
    btnR : in std_logic
  ) ;
end TopModule;

architecture arch of TopModule is

    signal start : std_logic ;

    component Controller is
    port (
        CLK_100MHZ : in std_logic;
        btnC : in std_logic;
        btnR : in std_logic;
        rst : out std_logic
    ) ;
    end component;
    
    component Anode_Activate_SEG
    port (
      CLK_100MHZ : in std_logic;
      anode_out : out std_logic_vector(3 downto 0);
      seg_out : out std_logic_vector(6 downto 0);
      done_in : in std_logic
    );
    end component;

    component AES is
    port (
        clk           : in std_logic;
        rst           : in std_logic;
        plaintext     : in std_logic_vector(127 downto 0);
        ciphertext    : out std_logic_vector(127 downto 0);
        done          : out std_logic
    );
    end component;

    signal done_signal : std_logic ;
    signal rst_signal : std_logic ;
    signal plaintext : std_logic_vector(127 downto 0) := x"6BC1BEE22E409F96E93D7E117393172A";
    signal ciphertext : std_logic_vector(127 downto 0);
    signal done : std_logic;
    signal rst : std_logic;


begin

    Controller_inst : Controller port map (
        CLK_100MHZ => CLK_100MHZ,
        btnC => btnC,
        btnR => btnR,
        rst => rst_signal
    );
    
    rst <= rst_signal;

    Anode_Activate_SEG_inst : Anode_Activate_SEG port map (
        CLK_100MHZ => CLK_100MHZ,
        anode_out => ANODE_ACT,
        seg_out => SEG_OUT,
        done_in => done_signal
    );
    
    AES_inst : AES port map (
        clk => CLK_100MHZ,
        rst => rst_signal,
        plaintext => plaintext,
        ciphertext => ciphertext,
        done => done_signal
    );
    
    done <= done_signal;

end arch;