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

  -- set the clock period to 2 ns
  clk <= not clk after 1 ns;

  -- send a start
  start_0 <= '1' after 2 ns, start_0 <= '0' after 3 ns;
  
  
end simu;
