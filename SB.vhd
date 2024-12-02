library ieee;
use ieee.std_logic_1164.all;


entity SB is 
    port(
        input_data : in std_logic_vector(127 downto 0);
        output_data : out std_logic_vector(127 downto 0)
    );
end entity;

architecture arch of SB is
    component S_box is
        port( byte_in : in std_logic_vector(7 downto 0);
               byte_out: out std_logic_vector(7 downto 0));
    end component;
    
    signal byte_in : std_logic_vector(7 downto 0);
    signal byte_out : std_logic_vector(7 downto 0);


    begin
        S_Box_0 : S_box port map(byte_in => input_data(127 downto 120), byte_out => output_data(127 downto 120));
        S_Box_1 : S_box port map(byte_in => input_data(119 downto 112), byte_out => output_data(119 downto 112));
        S_Box_2 : S_box port map(byte_in => input_data(111 downto 104), byte_out => output_data(111 downto 104));
        S_Box_3 : S_box port map(byte_in => input_data(103 downto 96), byte_out => output_data(103 downto 96));
        S_Box_4 : S_box port map(byte_in => input_data(95 downto 88), byte_out => output_data(95 downto 88));
        S_Box_5 : S_box port map(byte_in => input_data(87 downto 80), byte_out => output_data(87 downto 80));
        S_Box_6 : S_box port map(byte_in => input_data(79 downto 72), byte_out => output_data(79 downto 72));
        S_Box_7 : S_box port map(byte_in => input_data(71 downto 64), byte_out => output_data(71 downto 64));
        S_Box_8 : S_box port map(byte_in => input_data(63 downto 56), byte_out => output_data(63 downto 56));
        S_Box_9 : S_box port map(byte_in => input_data(55 downto 48), byte_out => output_data(55 downto 48));
        S_Box_10 : S_box port map(byte_in => input_data(47 downto 40), byte_out => output_data(47 downto 40));
        S_Box_11 : S_box port map(byte_in => input_data(39 downto 32), byte_out => output_data(39 downto 32));
        S_Box_12 : S_box port map(byte_in => input_data(31 downto 24), byte_out => output_data(31 downto 24));
        S_Box_13 : S_box port map(byte_in => input_data(23 downto 16), byte_out => output_data(23 downto 16));
        S_Box_14 : S_box port map(byte_in => input_data(15 downto 8), byte_out => output_data(15 downto 8));
        S_Box_15 : S_box port map(byte_in => input_data(7 downto 0), byte_out => output_data(7 downto 0));


end architecture;