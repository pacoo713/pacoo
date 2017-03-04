library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity send_preambleTB is
end send_preambleTB;

architecture simu of send_preambleTB is

  signal  clk     : STD_LOGIC := '0';
  signal  start_p : STD_LOGIC := '0';
  signal  end_p   : STD_LOGIC;
  signal  pulse_p : STD_LOGIC;

  
begin
  LO : entity work.send_preamble
    port map (clk, start_p, end_p, pulse_p);

  process
  begin

    for i in 0 to 50 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    
    
    start_p <= '1';
    
    for i in 0 to 3000 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    
    
    wait;
  end process;
end simu;
