library ieee;
use ieee.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_ARITH.ALL;
use ieee.STD_LOGIC_UNSIGNED.ALL;

entity MixColumns is
    Port (
        state_in  : in  STD_LOGIC_VECTOR(127 downto 0);
        state_out : out STD_LOGIC_VECTOR(127 downto 0)
    );
end entity;

architecture arch of MixColumns is
    component LUT_mul2 is
        Port (
            byte_in  : in  STD_LOGIC_VECTOR(7 downto 0);
            byte_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component LUT_mul3 is
        Port (
            byte_in  : in  STD_LOGIC_VECTOR(7 downto 0);
            byte_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    type ByteArray is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
    signal mul2 : ByteArray;
    signal mul3 : ByteArray;
    signal state_bytes : ByteArray;
    signal mix_result : ByteArray;

begin
    gen_state_bytes : for i in 0 to 15 generate
        state_bytes(i) <= state_in(127 - 8*i downto 120 - 8*i);
    end generate gen_state_bytes;
    
    gen_lut : for i in 0 to 15 generate
        LUT2_inst : LUT_mul2 Port map(byte_in => state_bytes(i), byte_out => mul2(i));
        LUT3_inst : LUT_mul3 Port map(byte_in => state_bytes(i), byte_out => mul3(i));
    end generate gen_lut;

    mix_result(0)  <= mul2(0) xor mul3(1) xor state_bytes(2) xor state_bytes(3);
    mix_result(1)  <= state_bytes(0) xor mul2(1) xor mul3(2) xor state_bytes(3);
    mix_result(2)  <= state_bytes(0) xor state_bytes(1) xor mul2(2) xor mul3(3);
    mix_result(3)  <= mul3(0) xor state_bytes(1) xor state_bytes(2) xor mul2(3);

    mix_result(4)  <= mul2(4) xor mul3(5) xor state_bytes(6) xor state_bytes(7);
    mix_result(5)  <= state_bytes(4) xor mul2(5) xor mul3(6) xor state_bytes(7);
    mix_result(6)  <= state_bytes(4) xor state_bytes(5) xor mul2(6) xor mul3(7);
    mix_result(7)  <= mul3(4) xor state_bytes(5) xor state_bytes(6) xor mul2(7);

    mix_result(8)  <= mul2(8) xor mul3(9) xor state_bytes(10) xor state_bytes(11);
    mix_result(9)  <= state_bytes(8) xor mul2(9) xor mul3(10) xor state_bytes(11);
    mix_result(10) <= state_bytes(8) xor state_bytes(9) xor mul2(10) xor mul3(11);
    mix_result(11) <= mul3(8) xor state_bytes(9) xor state_bytes(10) xor mul2(11);

    mix_result(12) <= mul2(12) xor mul3(13) xor state_bytes(14) xor state_bytes(15);
    mix_result(13) <= state_bytes(12) xor mul2(13) xor mul3(14) xor state_bytes(15);
    mix_result(14) <= state_bytes(12) xor state_bytes(13) xor mul2(14) xor mul3(15);
    mix_result(15) <= mul3(12) xor state_bytes(13) xor state_bytes(14) xor mul2(15);


    state_out <= mix_result(0) & mix_result(1) & mix_result(2) & mix_result(3) &
                 mix_result(4) & mix_result(5) & mix_result(6) & mix_result(7) &
                 mix_result(8) & mix_result(9) & mix_result(10) & mix_result(11) &
                 mix_result(12) & mix_result(13) & mix_result(14) & mix_result(15);

end architecture;

