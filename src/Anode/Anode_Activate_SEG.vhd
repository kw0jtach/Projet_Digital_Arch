library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Anode_Activate_SEG is
  port (
    CLK_100MHZ : in std_logic;
    anode_out : out std_logic_vector(3 downto 0);
    seg_out : out std_logic_vector(6 downto 0);
    done_in : in std_logic
  ) ;
end Anode_Activate_SEG;

architecture arch of Anode_Activate_SEG is

  signal refresh_counter : std_logic_vector(19 downto 0);
  signal SEG_active_Count : std_logic_vector(1 downto 0);

  begin
    process(CLK_100MHZ)
    begin
        if rising_edge(CLK_100MHZ) then
            refresh_counter <= refresh_counter + 1;
        end if;
    end process;

    SEG_active_Count <= refresh_counter(19 downto 18);
    process(SEG_active_Count)
begin
    case SEG_active_Count is
        when "00" => 
            anode_out <= "0111";
            seg_out <= "1111111";
            if done_in = '1' then 
                seg_out <= "0100000";
            end if;
            
        when "01" => 
            anode_out <= "1011";
            seg_out <= "1111111";
            if done_in = '1' then 
                seg_out <= "0000110";
            end if;

        when "10" => 
            anode_out <= "1101";
            seg_out <= "1111111";
            if done_in = '1' then 
                seg_out <= "0010010";
            end if;

        when "11" => 
            anode_out <= "1110";
            seg_out <= "1111111";
            if done_in = '1' then 
                seg_out <= "1010101";
            end if;

        when others => 
            anode_out <= "1111";
            seg_out <= "1111111";
    end case;
end process;

end arch;
