library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;



entity send_zero is
  Port (
    clk     : in  STD_LOGIC;
    start_0 : in  STD_LOGIC;
    end_0   : out STD_LOGIC := '0';
    pulse_0 : out STD_LOGIC := '0'
    );      
end send_zero;


-- send a zero in DCC protocol
architecture Behavioral of send_zero is
  
begin
  
  process (clk)
  begin
    if rising_edge (clk) then

      if start_0 = '1' then
        
        pulse_0 <= '0' after 0 us, '1' after 100 us, '0' after 100 us; 
        end_0   <= '1' after 200 us;

      else
        end_0   <= '0';
        pulse_0 <= '0';
        
      --  end if start_0
      end if;

    -- end rising_edge
    end if;
    

  end process;

end Behavioral;
