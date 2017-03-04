library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity send_zeroTB is
end send_zeroTB;

architecture simu of send_zeroTB is

  signal  clk     : STD_LOGIC := '0';
  signal  start_0 : STD_LOGIC := '0';
  signal  end_0   : STD_LOGIC;
  signal  pulse_0 : STD_LOGIC;

  
begin
  LO : entity work.send_zero
    port map (clk, start_0, end_0, pulse_0);

  process
  begin

    for i in 0 to 15 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    
    
    start_0 <= '1';
    
    for i in 0 to 300 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    

    wait;
  end process;
end simu;
