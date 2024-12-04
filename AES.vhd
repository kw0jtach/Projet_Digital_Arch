library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AES is
    port (
        clk           : in std_logic;
        rst           : in std_logic;
        plaintext    : in std_logic_vector(127 downto 0);
        ciphertext   : out std_logic_vector(127 downto 0);
        done          : out std_logic
    );
end entity;

architecture arch of AES is
    type KeyArray is array (0 to 10) of std_logic_vector(127 downto 0);
    signal round_keys : KeyArray := (
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

    component ARK
        port (
            input_data : in std_logic_vector(127 downto 0);
            key        : in std_logic_vector(127 downto 0);
            output_data: out std_logic_vector(127 downto 0)
        );
    end component;

    component SB
        port (
            input_data : in std_logic_vector(127 downto 0);
            output_data: out std_logic_vector(127 downto 0)
        );
    end component;

    component SR
        port (
            input_dataa : in std_logic_vector(127 downto 0);
            output_dataa: out std_logic_vector(127 downto 0)
        );
    end component;

    component MC
        port (
            state_in  : in std_logic_vector(127 downto 0);
            state_out : out std_logic_vector(127 downto 0)
        );
    end component;
    
    signal ark_input, ark_to_sb, sb_to_sr,sr_to_mc, mc_to_ark : std_logic_vector(127 downto 0);
    signal current_key : std_logic_vector(127 downto 0);
    signal key_index : integer range 0 to 10;
    signal encryption_done : std_logic;
    

begin
    ark_inst : ARK port map(input_data => ark_input, key => current_key, output_data => ark_to_sb);
    sb_inst : SB port map(input_data => ark_to_sb, output_data=> sb_to_sr);
    sr_inst : SR port map(input_dataa => sb_to_sr, output_dataa => sr_to_mc);
    mc_inst : MC port map(state_in => sr_to_mc, state_out => mc_to_ark);
    
    process(clk, rst)
    begin
        if rst = '1' then
            key_index <= 0;
            current_key <= round_keys(0);
            ark_input <= plaintext;
            encryption_done <= '0';
        elsif rising_edge(clk) then
            if encryption_done = '0' then
                if key_index < 10 then
                    if key_index = 9 then
                        ark_input <= sr_to_mc;
                    else
                        ark_input <= mc_to_ark;
                    end if;
                    
                    key_index <= key_index +1 ;
                    current_key <= round_keys(key_index +1);
                else
                    encryption_done <= '1';
                end if;
                ciphertext <= ark_to_sb;
            end if;
        end if;
     end process;

     done <= encryption_done;
end architecture;
