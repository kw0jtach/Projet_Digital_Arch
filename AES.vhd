library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AES is
    port (
        clk           : in std_logic;
        rst           : in std_logic;
        plaintext    : in std_logic_vector(127 downto 0);
        ciphertext   : out std_logic_vector(127 downto 0);
        key_TT          : out std_logic_vector(127 downto 0);
        round_cnt_TT    : out std_logic_vector(3 downto 0);
        done          : out std_logic
    );
end entity;

architecture arch of AES is

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

    component PIPO_Register
        generic(N: integer);
        port(
            Clk: in std_logic;
            D: in std_logic_vector(N - 1 downto 0);
            Q: out std_logic_vector(N - 1 downto 0)
        );
    end component;

    component Multiplexer
        generic(N: integer);
        port(
        D0 : in std_logic_vector(N - 1 downto 0); -- select 0
        D1 : in std_logic_vector(N - 1 downto 0); -- select 1
        SEL : in std_logic;
        Q : out std_logic_vector(N - 1 downto 0)
        );
    end component;

    component RoundKeys
        port(
            round_cnt : in std_logic_vector(3 downto 0);
            key : out std_logic_vector(127 downto 0)
        );
    end component;

    signal input_mux_out, reg_out, key_out, ARK_out, SB_out, SR_out, MC_out, output_mux_out: std_logic_vector(127 downto 0);
    signal round_cnt: std_logic_vector(3 downto 0);
    signal last_round: std_logic;
   
begin
    entry_mux: Multiplexer generic map(N => 128) port map(D0 => output_mux_out, D1 => plaintext, SEL => rst, Q => input_mux_out);
    reg_inst: PIPO_Register generic map(N => 128) port map(Clk => clk, D => input_mux_out, Q => reg_out);
    round_keys_inst: RoundKeys port map(round_cnt => round_cnt, key => key_out);
    ark_inst: ARK port map(input_data => reg_out, key => key_out, output_data => ARK_out);  
    sb_inst: SB port map(input_data => ARK_out, output_data => SB_out);
    sr_inst: SR port map(input_dataa => SB_out, output_dataa => SR_out);
    mc_inst: MC port map(state_in => SR_out, state_out => MC_out);
    output_mux: Multiplexer generic map(N => 128) port map(D0 => MC_out, D1 => SR_out, SEL => last_round, Q => output_mux_out);

    process(clk, rst)
    begin
        if (rising_edge(clk)) then
            key_TT <= key_out;
            round_cnt_TT <= round_cnt;
            if rst = '1' then
                done <= '0';
                last_round <= '0';
                round_cnt <= "0000";
            else 
                ciphertext <= ARK_out;
                if unsigned(round_cnt) < 10 then
                    round_cnt <= std_logic_vector(unsigned(round_cnt) + 1);
                end if;
                if unsigned(round_cnt) = 8 then
                    last_round <= '1';
                end if;
                if unsigned(round_cnt) = 10 then
                    done <= '1';
                end if;
            end if;
        end if;
    end process;

end arch ; -- arch    