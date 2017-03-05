library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity sequencer is
  Port (
    clk      : in  STD_LOGIC;

    go       : in  STD_LOGIC := '0';
    
    addr     : in  Std_Logic_Vector (7 downto 0);
    data     : in  Std_Logic_Vector (7 downto 0);
    
    
    pulse    : out STD_LOGIC := '0'
    );      
end sequencer;

--------------------------------------------------------------------------------


-- send a preamble in DCC protocol
architecture Behavioral of sequencer is


  --  SEND_ONE coponent declaration
  component send_one
    port (
      clk     : in  STD_LOGIC;
      start_1 : in  STD_LOGIC := '0';
      end_1   : out STD_LOGIC := '0';
      pulse_1 : out STD_LOGIC := '0'
      );
  end component;


  --  SEND_ZERO coponent declaration
  component send_zero
    port (
      clk     : in  STD_LOGIC;
      start_0 : in  STD_LOGIC := '0';
      end_0   : out STD_LOGIC := '0';
      pulse_0 : out STD_LOGIC := '0'
      );
  end component;


  --  SEND_PREAMBLE coponent declaration
  component send_preamble
    port (
      clk     : in  STD_LOGIC;
      start_p : in  STD_LOGIC := '0';
      end_p   : out STD_LOGIC := '0';
      pulse_p : out STD_LOGIC := '0'
      );
  end component;


  --  SEND_BYTE coponent declaration
  component send_byte
    port (
      clk     : in  STD_LOGIC;
      start_b : in  STD_LOGIC := '0';
      byte    : in  Std_Logic_Vector (7 downto 0);
      end_b   : out STD_LOGIC := '0';
      pulse_b : out STD_LOGIC := '0'
      );
  end component;
  
--------------------------------------------------------------------------------


  
  signal start_1 : STD_LOGIC := '0';
  signal end_1   : STD_LOGIC := '0';
  signal pulse_1 : STD_LOGIC := '0';
  
  signal start_0 : STD_LOGIC := '0';
  signal end_0   : STD_LOGIC := '0';
  signal pulse_0 : STD_LOGIC := '0';
  
  signal start_p : STD_LOGIC := '0';
  signal end_p   : STD_LOGIC := '0';
  signal pulse_p : STD_LOGIC := '0';
  
  signal start_b : STD_LOGIC := '0';
  signal end_b   : STD_LOGIC := '0';
  signal pulse_b : STD_LOGIC := '0';
  signal byte    : Std_Logic_Vector (7 downto 0);
  

  
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

  
  send_preamble_1: send_preamble
    port map (
      clk     => clk,
      start_p => start_p,
      end_p   => end_p,
      pulse_p => pulse_p    
      );

  
  send_byte_1: send_byte
    port map (
      clk     => clk,
      start_b => start_b,
      byte    => byte,
      end_b   => end_b,
      pulse_b => pulse_b    
      );

  
--------------------------------------------------------------------------------

  
  process (clk)

    -- serve to kown if we have start or not
    variable step : integer range 0 to 7 := 0;

  begin

    pulse <= pulse_0 or pulse_1 or pulse_b or pulse_p;
    
    if rising_edge (clk) then

      -- if we have
      if go = '1' then

        report "step   :" & integer'image(step);
        
        case step is

          -- send preambule + 0 
          when 0 =>
            -- send preamble
            start_p <= '1';
            -- at the end of preamble go to the next step 
            if end_p = '1' then
              report "dans le if :" & STD_LOGIC'image(end_p);
              start_p <= '0';
              step := 1;
            end if;

          -- send a 0
          when 1 =>             
            start_0 <= '1';
            -- go to the next step
            if end_0 = '1' then
              start_0 <= '0';
              step := 2;
            end if;

          -- send addr
          when 2 => 
            -- send addr
            start_b <= '1';
            byte <= addr;
            -- when the byte is sent, send a 0
            if end_b = '1' then
              start_b <= '0';
              step := 3;              
            end if;

          -- send a 0            
          when 3 =>               
            start_0 <= '1';
            -- go to the next step
            if end_0 = '1' then
              start_0 <= '0';
              step := 4;
            end if;
            
          -- send data
          when 4 => 
            -- send data
            start_b <= '1';
            byte <= data;
            -- when the byte is sent, send a 0
            if end_b = '1' then
              start_b <= '0';
              step := 5;
            end if;

          -- send a 0
          when 5 => 
            start_0 <= '1';     
            -- go to the next step
            if end_0 = '1' then
              start_0 <= '0';
              step := 6;
            end if;
            
          -- send control bit 
          when 6 => 
            -- send controle (data xor addr)
            start_b <= '1';
            byte <= data xor addr;
            -- when the byte is sent, send a 0
            if end_b = '1' then
              start_b <= '0';
              step := 7;
            end if;

          -- send a 1            
          when 7 =>             
            start_1 <= '1';
            -- go to the next step
            if end_1 = '1' then
              start_1 <= '0';
              step := 0;
            end if;

        end case;
        
      else
--        step := 0;
      --end go
      end if;      
      
    -- end rising_edge
    end if;
  end process;

end Behavioral;
