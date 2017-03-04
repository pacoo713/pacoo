library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity send_oneTB is
end send_oneTB;

architecture simu of send_oneTB is

  signal  clk     : STD_LOGIC := '0';
  signal  start_1 : STD_LOGIC := '0';
  signal  end_1   : STD_LOGIC;
  signal  pulse_1 : STD_LOGIC;

  
begin
  LO : entity work.send_one
    port map (clk, start_1, end_1, pulse_1);

  process
  begin

    for i in 0 to 15 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    
    
    start_1 <= '1';
    
    for i in 0 to 150 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    
    
    wait;
  end process;
end simu;
