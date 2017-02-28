library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity div_clock is
  Port (
    -- 100 MHz signla
    clk : in STD_LOGIC;
    -- 1 MHz signal
    div_clock : out STD_LOGIC);
end div_clock;


-- clock divider 100 MHz to 1MHz
architecture Behavioral of div_clock is

  signal cpt : integer range 0 to 99 := 0; 
  signal output : STD_LOGIC := '0';
  
begin

  div_clock <= output;
  
  process (clk)
  begin


    cpt <= cpt + 1;
    
    if rising_edge (clk) then

      if cpt = 99 then
        if output = '0' then
          output <= '1';
        else output <= '0';
        end if;
        cpt <= 0;
      end if;
    -- end rising_edge
    end if;

  end process;

end Behavioral;
