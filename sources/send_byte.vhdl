library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity send_byte is
  Port (
    clk     : in  STD_LOGIC;
    start_b : in  STD_LOGIC := '0';
    byte    : in  Std_Logic_Vector (7 downto 0); 
    end_b   : out STD_LOGIC := '0';
    pulse_b : out STD_LOGIC := '0'
    );      
end send_byte;

--------------------------------------------------------------------------------

-- send a byte in DCC protocol
architecture Behavioral of send_byte is


  --  SEND_ONE coponent declaration
  component send_one
    port (
      clk     : in  STD_LOGIC;
      start_1 : in  STD_LOGIC := '0';
      end_1   : out STD_LOGIC := '0';
      pulse_1 : out STD_LOGIC := '0'
      );
  end component;


  --  SEND_ZEO coponent declaration
  component send_zero
    port (
      clk     : in  STD_LOGIC;
      start_0 : in  STD_LOGIC := '0';
      end_0   : out STD_LOGIC := '0';
      pulse_0 : out STD_LOGIC := '0'
      );
  end component;

--------------------------------------------------------------------------------

  -- signals declaration for instantiation
  signal start_1 : STD_LOGIC := '0';
  signal end_1 : STD_LOGIC := '0';
  signal pulse_1 : STD_LOGIC := '0';   

  signal start_0 : STD_LOGIC := '0';
  signal end_0 : STD_LOGIC := '0';
  signal pulse_0 : STD_LOGIC := '0';   
  
begin

  send_one_1: send_one
    port map (
      clk     => clk,
      start_1 => start_1,
      end_1   => end_1,
      pulse_1 => pulse_1    
      );

  send_zero_1: send_zero
    port map (
      clk     => clk,
      start_0 => start_0,
      end_0   => end_0,
      pulse_0 => pulse_0
      );
  
--------------------------------------------------------------------------------

  -- set the output
  pulse_b <= pulse_0 or pulse_1;
  
  process (clk)

    variable cpt : integer range 0 to 102 := 0;
    variable byte_cpt : integer range 0 to 8 := 0;
    
  begin
    if rising_edge (clk) then

        end_b <= '0';
        start_0 <=  '0';
        start_1 <=  '0';

        -- test if a send is done
        if (end_0 or end_1) =  '1' then
          report "un octet envoyé : " & STD_LOGIC'image(end_0) & STD_LOGIC'image(end_1); 
          cpt := cpt + 1;
          start_0 <=  '0';
          start_1 <=  '0';
        end if;

      -- if wa have send the all byte
      if cpt = 8 then
        -- send a end signal and reset cpt
        end_b <= '1';
        cpt := 0;
        report "fin envoie octet";
      else
        if start_b = '1' then
          
          if byte(cpt) = '1' then
            -- send a 1
            start_1 <= '1';
          else
            -- send a 0
            start_0 <= '1';
          -- end test bit 1
          end if;
          
        else
          --if no request stay to 0
          byte_cpt := 0;
          cpt      := 0;
        --end if start_b
        end if;
        
      -- end id cpt = 8
      end if;
-- end rising_edge
    end if;
  end process;

end Behavioral;

