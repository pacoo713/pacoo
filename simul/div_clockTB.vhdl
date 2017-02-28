
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity div_clockTB is
end div_clockTB;

architecture simu of div_clockTB is

  signal input : STD_LOGIC := '0';
  signal output : STD_LOGIC := '0';            
  
begin
  LO : entity work.div_clock
    port map (input, output);

  input <= not input after 1 ns;

end simu;
