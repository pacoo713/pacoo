library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;



entity send_preamble is
  Port (
    clk     : in  STD_LOGIC;
    start_p : in  STD_LOGIC;
    end_p   : out STD_LOGIC := '0';
    pulse_p : out STD_LOGIC := '0'
    );      
end send_preamble;

-- create and instanciate a send_one

-- send a preamble in DCC protocol
architecture Behavioral of send_preamble is

  -- cpt for the 14  '1' bits to send 
  variable cpt : integer range 0 to 14 := 0;
  
begin
  
  process (clk)
  begin
    if rising_edge (clk) then

      if start_p = '1' then
        
        -- fsm explaination
        --  if start_p = 1 launch the fsm
        --  
        --  1) while cpt < 14 continue into the fsm 
        --      if not go to 2)
        --
        --  send 1 to start_1 and increment cpt
        --  wait for the end_0 signal turning to 1
        --
        --  then go back to 1)
        --
        -- 2) send a 1 to end_p signal and reset cpt to 0
        
        
      --  end if start_p
      end if;
    -- end rising_edge
    end if;
    

  end process;

end Behavioral;
