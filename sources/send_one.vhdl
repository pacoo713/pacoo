library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;



entity send_one is
  Port (
    clk     : in  STD_LOGIC;
    start_1 : in  STD_LOGIC := '0';
    end_1   : out STD_LOGIC := '0';
    pulse_1 : out STD_LOGIC := '0'
    );      
end send_one;


-- send a one in DCC protocol
architecture Behavioral of send_one is
  
begin
  
  process (clk)

    variable cpt  : integer range 0 to 60 := 0;
    variable which : integer range 0 to 1  := 0;
    

  begin
    if rising_edge (clk) then
 
        end_1   <= '0';
        pulse_1 <= '0';

      if start_1 = '1' then
        cpt := cpt + 2;
        
        if which =  0 then 
          -- send à 0 for 58 clock cycle

          pulse_1 <= '0';

          -- reset the cpt
          if cpt > 54 then
            cpt := 0;
            which := 1;
          end if;
          
        else
          -- send à 1 for 58 clock cycle
          
            pulse_1 <= '1';
            
          -- reset the cpt and put the pulse to 0 again            
          if cpt > 58 then
            end_1   <= '1';
            cpt := 0;
            pulse_1 <= '0';
            which := 0;
          end if;

        -- end choix envoie
        end if;
          
      else
        end_1   <= '0';
        pulse_1 <= '0';
        
      --  end if start_1
      end if;

      
    -- end rising_edge
    end if;
    

  end process;

end Behavioral;
