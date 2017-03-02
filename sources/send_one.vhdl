library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;



entity send_one is
  Port (
    clk     : in  STD_LOGIC;
    start_1 : in  STD_LOGIC;
    end_1   : out STD_LOGIC := '0';
    pulse_1 : out STD_LOGIC := '0'
    );      
end send_one;


-- send a one in DCC protocol
architecture Behavioral of send_one is
  
begin
  
  process (clk)
  begin
    if rising_edge (clk) then

      if start_1 = '1' then
        
        pulse_1 <= '0' after 0 us, '1' after 58 us, '0' after 58 us; 
        end_1   <= '1' after 116 us;

      else
        end_1   <= '0';
        pulse_1 <= '0';
        
      --  end if start_1
      end if;

      
    -- end rising_edge
    end if;
    

  end process;

end Behavioral;
