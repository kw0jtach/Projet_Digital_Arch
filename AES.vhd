library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity AES_128 is
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        plaintext  : in std_logic_vector(127 downto 0);
        output_data : out std_logic_vector(127 downto 0)
    );
end entity;

architecture arch of AES_128 is

    type Arrayy is array(0 to 10) of std_logic_vector(127 downto 0);
    constant RoundKeys : Arrayy := (
        x"2b7e151628aed2a6abf7158809cf4f3c",

        x"a0fafe1788542cb123a339392a6c7605",
        x"f2c295f27a96b9435935807a7359f67f",
        x"3d80477d4716fe3e1e237e446d7a883b",
        x"ef44a541a8525b7fb671253bdb0bad00",
        x"d4d1c6f87c839d87caf2b8bc11f915bc",
        x"6d88a37a110b3efddbf98641ca0093fd",
        x"4e54f70e5f5fc9f384a64fb24ea6dc4f",
        x"ead27321b58dbad2312bf5607f8d292f",
        x"ac7766f319fadc2128d12941575c006e",

        x"d014f9a8c9ee2589e13f0cc8b6630ca6"
    );

    component SB is
        port (
            input_data : in std_logic_vector(127 downto 0);
            output_data : out std_logic_vector(127 downto 0)
        );
    end component;

    component SR is
        port (
            input_dataa : in std_logic_vector(127 downto 0);
            output_dataa : out std_logic_vector(127 downto 0)
        );
    end component;

    component MC is port ( 
        state_in : in std_logic_vector(127 downto 0); 
        state_out : out std_logic_vector(127 downto 0) );
    end component;

    component ARK is port (
        input_data : in std_logic_vector(127 downto 0); 
        key : in std_logic_vector(127 downto 0); 
        output_data : out std_logic_vector(127 downto 0) );
    end component;

    component D_FF is port(
        D : in std_logic; 
        Clk : in std_logic; 
        Q : out std_logic
    ); end component;


    component Multiplexer is port(
        D : in std_logic_vector(3 downto 0);
        SEL : in std_logic_vector(1 downto 0);
        Q : out std_logic
    ); end component;

    signal output_data_SB : std_logic_vector(127 downto 0);
    signal output_data_SR : std_logic_vector(127 downto 0);
    signal output_data_MC : std_logic_vector(127 downto 0);
    signal output_data_ARK1 : std_logic_vector(127 downto 0);

    signal key : std_logic_vector(127 downto 0);
    signal round_counter  : integer range 0 to 10 := 0;
    signal temp : std_logic_vector(127 downto 0);
    signal input_data : std_logic_vector(127 downto 0);


begin

    UUT_MUX: Multiplexer port map (D => output_data_ARK1(3 downto 0), SEL => "00", Q => temp(0));
    UUT_SB: SB port map ( input_data => input_data, output_data => output_data_SB );
    UUT_SR: SR port map ( input_dataa => output_data_SB,  output_dataa => output_data_SR );
    UUT_MC: MC port map ( state_in => output_data_SR,  state_out => output_data_MC);
    UUT_ARK: ARK  port map ( input_data => output_data_MC, key => key, output_data => output_data_ARK );
    
    

    process(clk, rst) is
    begin
          if (rising_edge(clk)) then
            if round = 0 then
                output_data_ARK1 <= plaintext xor RoundKeys(0);
                round_counter := round_counter + 1;
            elsif ((round > 0) and (round < 10)) 
                if round_counter = 10 then 
                    
                
            
          end if;
        
    end process;



end architecture;
