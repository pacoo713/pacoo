library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity send_byteTB is
end send_byteTB;

architecture simu of send_byteTB is

  signal  clk     : STD_LOGIC := '0';
  signal  start_b : STD_LOGIC := '0';
  signal  byte    : Std_Logic_Vector (7 downto 0); 
  signal  end_b   : STD_LOGIC;
  signal  pulse_b : STD_LOGIC;

  
begin
  LO : entity work.send_byte
    port map (clk, start_b, byte, end_b, pulse_b);

  process
  begin

    for i in 0 to 50 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    
    byte <= "10101010";
    start_b <= '1';


    
    for i in 0 to 5000 loop
      clk <= not clk;
      wait for 1 us;      
    end loop;
    
    
    wait;
  end process;
end simu;
