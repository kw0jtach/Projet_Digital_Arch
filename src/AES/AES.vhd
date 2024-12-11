library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AES is
    port (
        clk           : in std_logic;
        rst           : in std_logic;
        plaintext     : in std_logic_vector(127 downto 0);
        ciphertext    : out std_logic_vector(127 downto 0);
        done          : out std_logic
    );
end entity;

architecture arch of AES is

    component AddRoundKey
        port (
            input_data  : in std_logic_vector(127 downto 0);
            key         : in std_logic_vector(127 downto 0);
            output_data : out std_logic_vector(127 downto 0)
        );
    end component;

    component SubBytes
        port (
            input_data  : in std_logic_vector(127 downto 0);
            output_data : out std_logic_vector(127 downto 0)
        );
    end component;

    component ShiftRows
        port (
            input_data  : in std_logic_vector(127 downto 0);
            output_data : out std_logic_vector(127 downto 0)
        );
    end component;

    component MixColumns
        port (
            state_in   : in std_logic_vector(127 downto 0);
            state_out  : out std_logic_vector(127 downto 0)
        );
    end component;

    component PIPO_Register
        generic(N: integer);
        port(
            Clk : in std_logic;
            D   : in std_logic_vector(N - 1 downto 0);
            Q   : out std_logic_vector(N - 1 downto 0)
        );
    end component;

    component Multiplexer
        generic(N: integer);
        port(
            D0  : in std_logic_vector(N - 1 downto 0);
            D1  : in std_logic_vector(N - 1 downto 0);
            SEL : in std_logic;
            Q   : out std_logic_vector(N - 1 downto 0)
        );
    end component;

    component RoundKeys
        port(
            round_cnt : in std_logic_vector(3 downto 0);
            key       : out std_logic_vector(127 downto 0)
        );
    end component;

    signal done_int : std_logic;

    signal input_mux_out, reg_out, key_out, AddRoundKey_out, SubBytes_out, ShiftRows_out, MixColumns_out, output_mux_out: std_logic_vector(127 downto 0);
    signal round_cnt: std_logic_vector(3 downto 0);
    signal last_round: std_logic;
    signal rst_sync: std_logic;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            rst_sync <= rst;
        end if;
    end process;

    entry_mux: Multiplexer generic map(N => 128)
        port map(D0 => output_mux_out, D1 => plaintext, SEL => rst_sync, Q => input_mux_out);

    reg_inst: PIPO_Register generic map(N => 128)
        port map(Clk => clk, D => input_mux_out, Q => reg_out);

    round_keys_inst: RoundKeys
        port map(round_cnt => round_cnt, key => key_out);

    AddRoundKey_inst: AddRoundKey
        port map(input_data => reg_out, key => key_out, output_data => AddRoundKey_out);

    SubBytes_inst: SubBytes
        port map(input_data => AddRoundKey_out, output_data => SubBytes_out);

    ShiftRows_inst: ShiftRows
        port map(input_data => SubBytes_out, output_data => ShiftRows_out);

    MixColumns_inst: MixColumns
        port map(state_in => ShiftRows_out, state_out => MixColumns_out);

    output_mux: Multiplexer generic map(N => 128)
        port map(D0 => MixColumns_out, D1 => ShiftRows_out, SEL => last_round, Q => output_mux_out);

    process(clk)
    begin
        if rising_edge(clk) then
            if rst_sync = '1' then
                done_int <= '0';
                last_round <= '0';
                round_cnt <= (others => '0');
                ciphertext <= (others => '0');
            elsif rst_sync = '0' then
                if done_int = '1' then
                else
                    if unsigned(round_cnt) < 10 then
                        round_cnt <= std_logic_vector(unsigned(round_cnt) + 1);
                    end if;

                    if unsigned(round_cnt) = 8 then
                        last_round <= '1';
                    else
                        last_round <= '0';
                    end if;

                    if unsigned(round_cnt) = 10 then
                        done_int <= '1';
                        ciphertext <= AddRoundKey_out;
                    end if;
                end if;
            end if;
        end if;
    end process;
    done <= done_int;
end arch;
