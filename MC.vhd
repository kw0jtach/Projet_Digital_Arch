library ieee;
use ieee.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_ARITH.ALL;
use ieee.STD_LOGIC_UNSIGNED.ALL;

entity MC is
    Port (
        state_in  : in  STD_LOGIC_VECTOR(127 downto 0);
        state_out : out STD_LOGIC_VECTOR(127 downto 0)
    );
end entity;

architecture arch of MC is
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

    state_bytes(0)  <= state_in(127 downto 120);
    state_bytes(1)  <= state_in(119 downto 112);
    state_bytes(2)  <= state_in(111 downto 104);
    state_bytes(3)  <= state_in(103 downto 96);
    state_bytes(4)  <= state_in(95 downto 88);
    state_bytes(5)  <= state_in(87 downto 80);
    state_bytes(6)  <= state_in(79 downto 72);
    state_bytes(7)  <= state_in(71 downto 64);
    state_bytes(8)  <= state_in(63 downto 56);
    state_bytes(9)  <= state_in(55 downto 48);
    state_bytes(10) <= state_in(47 downto 40);
    state_bytes(11) <= state_in(39 downto 32);
    state_bytes(12) <= state_in(31 downto 24);
    state_bytes(13) <= state_in(23 downto 16);
    state_bytes(14) <= state_in(15 downto 8);
    state_bytes(15) <= state_in(7 downto 0);

    LUT2_inst_0 : LUT_mul2 Port map(byte_in => state_bytes(0), byte_out => mul2(0));
    LUT3_inst_0 : LUT_mul3 Port map(byte_in => state_bytes(0), byte_out => mul3(0));
    LUT2_inst_1 : LUT_mul2 Port map(byte_in => state_bytes(1), byte_out => mul2(1));
    LUT3_inst_1 : LUT_mul3 Port map(byte_in => state_bytes(1), byte_out => mul3(1));
    LUT2_inst_2 : LUT_mul2 Port map(byte_in => state_bytes(2), byte_out => mul2(2));
    LUT3_inst_2 : LUT_mul3 Port map(byte_in => state_bytes(2), byte_out => mul3(2));
    LUT2_inst_3 : LUT_mul2 Port map(byte_in => state_bytes(3), byte_out => mul2(3));
    LUT3_inst_3 : LUT_mul3 Port map(byte_in => state_bytes(3), byte_out => mul3(3));
    LUT2_inst_4 : LUT_mul2 Port map(byte_in => state_bytes(4), byte_out => mul2(4));
    LUT3_inst_4 : LUT_mul3 Port map(byte_in => state_bytes(4), byte_out => mul3(4));
    LUT2_inst_5 : LUT_mul2 Port map(byte_in => state_bytes(5), byte_out => mul2(5));
    LUT3_inst_5 : LUT_mul3 Port map(byte_in => state_bytes(5), byte_out => mul3(5));
    LUT2_inst_6 : LUT_mul2  Port map(byte_in => state_bytes(6), byte_out => mul2(6));
    LUT3_inst_6 : LUT_mul3 Port map(byte_in => state_bytes(6), byte_out => mul3(6));
    LUT2_inst_7 : LUT_mul2 Port map(byte_in => state_bytes(7), byte_out => mul2(7));
    LUT3_inst_7 : LUT_mul3 Port map(byte_in => state_bytes(7), byte_out => mul3(7));
    LUT2_inst_8 : LUT_mul2 Port map(byte_in => state_bytes(8), byte_out => mul2(8));
    LUT3_inst_8 : LUT_mul3 Port map(byte_in => state_bytes(8), byte_out => mul3(8));
    LUT2_inst_9 : LUT_mul2 Port map(byte_in => state_bytes(9), byte_out => mul2(9));
    LUT3_inst_9 : LUT_mul3 Port map(byte_in => state_bytes(9), byte_out => mul3(9));
    LUT2_inst_10 : LUT_mul2 Port map(byte_in => state_bytes(10), byte_out => mul2(10));
    LUT3_inst_10 : LUT_mul3 Port map(byte_in => state_bytes(10), byte_out => mul3(10));
    LUT2_inst_11 : LUT_mul2 Port map(byte_in => state_bytes(11), byte_out => mul2(11));
    LUT3_inst_11 : LUT_mul3 Port map(byte_in => state_bytes(11), byte_out => mul3(11));
    LUT2_inst_12 : LUT_mul2 Port map(byte_in => state_bytes(12), byte_out => mul2(12));
    LUT3_inst_12 : LUT_mul3 Port map(byte_in => state_bytes(12), byte_out => mul3(12));
    LUT2_inst_13 : LUT_mul2 Port map(byte_in => state_bytes(13), byte_out => mul2(13));
    LUT3_inst_13 : LUT_mul3 Port map(byte_in => state_bytes(13), byte_out => mul3(13));
    LUT2_inst_14 : LUT_mul2 Port map(byte_in => state_bytes(14), byte_out => mul2(14));
    LUT3_inst_14 : LUT_mul3 Port map(byte_in => state_bytes(14), byte_out => mul3(14));
    LUT2_inst_15 : LUT_mul2 Port map(byte_in => state_bytes(15), byte_out => mul2(15));
    LUT3_inst_15 : LUT_mul3 Port map(byte_in => state_bytes(15), byte_out => mul3(15));

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

