library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity sequencerTB is
end sequencerTB;

architecture simu of sequencerTB is

    signal clk      :  STD_LOGIC := '0';
    signal go       :  STD_LOGIC := '0';
    signal addr     :  Std_Logic_Vector (7 downto 0);
    signal data     :  Std_Logic_Vector (7 downto 0);
    signal pulse    :  STD_LOGIC := '0';

  
begin
  LO : entity work.sequencer
    port map (clk, go, addr, data, pulse);

  process
  begin

    for i in 0 to 50 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    
    addr <= "00000000";
    data <= "11111111";

    go   <= '1';
    
    for i in 0 to 50000 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    
    
    wait;
  end process;
end simu;
