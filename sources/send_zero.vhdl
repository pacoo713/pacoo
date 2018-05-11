library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;



entity dcc_bit0 is
  Port (
    clk     : in  STD_LOGIC;
    GO_0 : in  STD_LOGIC := '0';
    FIN_0   : out STD_LOGIC := '0';
    DCC_0 : out STD_LOGIC := '0'
    );      
end dcc_bit0;


-- send a zero in DCC protocol
architecture Behavioral of dcc_bit0 is
  
begin
  
  process (clk)

    -- to count the cycles
    variable cpt  : integer range 0 to 102 := 0;
    -- to select if it is a 0 or a 1 to send
    variable which : integer range 0 to 1  := 0;

  begin
    if rising_edge (clk) then

      FIN_0   <= '0';
      DCC_0 <= '0';

      if GO_0 = '1' then
        cpt := cpt + 2;
        
        if which = 0 then 
          -- send à 0 for 100 clock cycle

          DCC_0 <= '0';

          -- reset the cpt
          if cpt > 96 then
            cpt := 0;
            which := 1;
          end if;
          
        else
          -- send à 1 for 100 clock cycle
          
          DCC_0 <= '1';
          
          -- reset the cpt and put the pulse to 0 again            
          if cpt > 100 then
            FIN_0   <= '1';
            cpt := 0;
            DCC_0 <= '0';
            which := 0;
          end if;

        -- end choix envoie
        end if;
        
      else
        FIN_0   <= '0';
        DCC_0 <= '0';
       
      --  end if start_0
      end if;
      
    -- end rising_edge
    end if;
  end process;

end Behavioral;
