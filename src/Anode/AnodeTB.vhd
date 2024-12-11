library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TB_Anode_Activate_SEG is
end TB_Anode_Activate_SEG;

architecture behavior of TB_Anode_Activate_SEG is
  component Anode_Activate_SEG
    port (
      CLK_100MHZ : in std_logic;
      anode_out : out std_logic_vector(3 downto 0);
      seg_out : out std_logic_vector(6 downto 0);
      done_in : in std_logic
    );
  end component;

  signal CLK_100MHZ : std_logic := '0';
  signal anode_out : std_logic_vector(3 downto 0);
  signal seg_out : std_logic_vector(6 downto 0);
  signal done_in : std_logic := '0';

  constant CLK_PERIOD : time := 10 ns;

begin

  UUT: Anode_Activate_SEG
    port map (
      CLK_100MHZ => CLK_100MHZ,
      anode_out => anode_out,
      seg_out => seg_out,
      done_in => done_in
    );

  clk_process : process
  begin
    while true loop
      CLK_100MHZ <= not CLK_100MHZ;
      wait for CLK_PERIOD / 2;
    end loop;
  end process;

  stim_process : process
  begin
    wait for 100 ns;

    done_in <= '0';
    wait for 100 ns;

    done_in <= '1';
    wait for 100 ns;

    done_in <= '0';
    wait for 50 ns;
    done_in <= '1';
    wait for 50 ns;
    done_in <= '0';
    wait for 50 ns;
    done_in <= '1';
    wait for 50 ns;

    wait;
  end process;

end behavior;
