library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;



entity send_zero is
  Port (
    clk     : in  STD_LOGIC;
    start_0 : in  STD_LOGIC := '0';
    end_0   : out STD_LOGIC := '0';
    pulse_0 : out STD_LOGIC := '0'
    );      
end send_zero;


-- send a zero in DCC protocol
architecture Behavioral of send_zero is
  
begin
  
  process (clk)

    -- to count the cycles
    variable cpt  : integer range 0 to 102 := 0;
    -- to select if it is a 0 or a 1 to send
    variable which : integer range 0 to 1  := 0;

  begin
    if rising_edge (clk) then

      end_0   <= '0';
      pulse_0 <= '0';

      if start_0 = '1' then
        cpt := cpt + 2;
        
        if which = 0 then 
          -- send à 0 for 100 clock cycle

          pulse_0 <= '0';

          -- reset the cpt
          if cpt > 96 then
            cpt := 0;
            which := 1;
          end if;
          
        else
          -- send à 1 for 100 clock cycle
          
          pulse_0 <= '1';
          
          -- reset the cpt and put the pulse to 0 again            
          if cpt > 100 then
            end_0   <= '1';
            cpt := 0;
            pulse_0 <= '0';
            which := 0;
          end if;

        -- end choix envoie
        end if;
        
      else
        end_0   <= '0';
        pulse_0 <= '0';
        
      --  end if start_0
      end if;
      
    -- end rising_edge
    end if;
  end process;

end Behavioral;
