library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity send_preamble is
  Port (
    clk     : in  STD_LOGIC;
    start_p : in  STD_LOGIC := '0';
    end_p   : out STD_LOGIC := '0';
    pulse_p : out STD_LOGIC := '0'
    );      
end send_preamble;

--------------------------------------------------------------------------------


-- send a preamble in DCC protocol
architecture Behavioral of send_preamble is


  --  SEND_ONE coponent declaration
  component send_one
    port (
    clk     : in  STD_LOGIC;
    start_1 : in  STD_LOGIC := '0';
    end_1   : out STD_LOGIC := '0';
    pulse_1 : out STD_LOGIC := '0'
);
  end component;

--------------------------------------------------------------------------------


  
  signal start_1 : STD_LOGIC := '0';
  signal end_1   : STD_LOGIC := '0';
  
begin

  send: send_one
    port map (
      clk     => clk,
      start_1 => start_1,
      end_1   => end_1,
      pulse_1 => pulse_p    
      );

--------------------------------------------------------------------------------

  
  process (clk)

    variable cpt : integer range 0 to 15  := 0;
    
  begin
    if rising_edge (clk) then

      end_p <= '0';
      start_1 <= '0';
      
      if start_p = '1' then

        -- if not 14 1 send
        if cpt < 14  then
          -- send a request to send a 1
          start_1 <= '1';
          end_p <= '0';
          -- if a 1 is finish to send cpt ++
          if end_1 = '1' then
            cpt := cpt + 1;
          -- end end_1 =1
          end if;
        -- if the preamble is send
        else
          end_p <= '1';
          start_1 <= '0';
          cpt := 0;
        end if;
        
      else
        end_p <= '0';
        cpt := 0;
        start_1 <= '0';
      --  end if start_p
      end if;

      
    -- end rising_edge
    end if;
  end process;

end Behavioral;
