library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity control_seg is
  Port ( CLK    : in STD_LOGIC;
         reset  : in STD_LOGIC;
         CA     : out STD_LOGIC;
         CB     : out STD_LOGIC;
         CC     : out STD_LOGIC;
         CD     : out STD_LOGIC;
         CE     : out STD_LOGIC;
         CF     : out STD_LOGIC;
         CG     : out STD_LOGIC;
         DP     : out STD_LOGIC;
         AN     : out STD_LOGIC_VECTOR (7 downto 0);
         ADD    : out STD_LOGIC_VECTOR (7 downto 0);
         AIG    : out STD_LOGIC_VECTOR (7 downto 0);
         SPD    : out STD_LOGIC_VECTOR (7 downto 0);
         FEAT   : out STD_LOGIC_VECTOR (7 downto 0);
         -- chose setting
         BTNL   : in STD_LOGIC;
         -- increment setting value
         BTNR   : in STD_LOGIC
         );
end control_seg;



architecture Behavioral of control_seg is


    function affiche (value: integer) return STD_LOGIC_VECTOR is
      variable RET : std_logic_vector (6 downto 0) := "0000000";
  begin
    case value is

      -- afficher 0
      when 0 =>
        ret := "0000001";
        return ret;

     -- afficher 1
      when 1 =>
        ret := "1001111";
        return ret;

      -- afficher 2      
      when 2 =>
        ret := "0010010";
        return ret;

        -- afficher 3      
      when 3 =>
        ret := "0000110";
        return ret;
        
        -- afficher 4      
      when 4 =>
        ret := "1001100";
        return ret;

        -- afficher 5      
      when 5 =>
        ret := "0100100";
        return ret;

        -- afficher 6      
      when 6 =>
        ret := "1100000";
        return ret;

        -- afficher 7      
      when 7 =>
        ret := "0001111";
        return ret;
        
      when others => return "0000000";
    end case;

  end  affiche;
 

  
  -- for the display
  signal cpt : integer range 0 to 2000000000 := 0;
  signal num : integer range 0 to 4 := 0;


    -- stamp for the re bounce of the buttons
  signal stampbtl: integer range 0 to 1000000000; 	
  signal stampbtr: integer range 0 to 1000000000;	


  -- type of setting on the display
  -- 0 > train address
  -- 1 > train speed
  -- 2 > aiguillage
  -- 3 > features
  signal setting : integer range 0 to 3;

  -- train address
  signal addr : integer range 0 to 6 := 0;

  -- train speed
  signal speed : integer range 0 to 7 := 0;

  -- aiguillage number
  signal aigui : integer range 0 to 8 := 0;

  -- features
  -- 1 > klakson
  -- 
  signal features : integer range 0 to 7 := 0;

  
begin

  process (CLK) 

    -- seg display values for the setting's value  
    variable seg_display : STD_LOGIC_VECTOR (6 downto 0);
  
  begin

  -- put the addresse in output
  case addr is
    when 0 =>
      ADD <= "00000000";
    when 1 =>
      ADD <= "00000001";
    when 2 =>
      ADD <= "00000010";
    when 3 =>
      ADD <= "00000011";
    when 4 =>
      ADD <= "00000100";
    when 5 =>
      ADD <= "00000101";
    when 6 =>
      ADD <= "00000110";
  end case;

  -- put the aiguillage addresse in output
  case aigui is
    when 0 =>
      AIG <= "00000000";
    when 1 =>
      AIG <= "00001001";
    when 2 =>
      AIG <= "00001010";
    when 3 =>
      AIG <= "00001011";
    when 4 =>
      AIG <= "00001100";
    when 5 =>
      AIG <= "00001101";
    when 6 =>
      AIG <= "00001110";
    when 7 =>
      AIG <= "00001111";
    when 8 =>
      AIG <= "00011111";
  end case;

  
  -- put the speed in output
  case speed is
    when 0 =>
      SPD <= "01100000";
    when 1 =>
      SPD <= "01100010";
    when 2 =>
      SPD <= "01100100";
    when 3 =>
      SPD <= "01100110";
    when 4 =>
      SPD <= "01111001";
    when 5 =>
      SPD <= "01101011";
    when 6 =>
      SPD <= "01111101";
    when 7 =>
      SPD <= "01111111";
  end case;

  -- put the feature in output
  case features is
    when 0 =>
      FEAT <= "00000000";
    when 1 =>
      -- phares
      FEAT <= "10010000";
    when 2 =>
      -- moteur
      FEAT <= "10000001";
    when 3 =>
      FEAT <= "00000011";
    when 4 =>
      FEAT <= "00000100";
    when 5 =>
      FEAT <= "00000101";
    when 6 =>
      FEAT <= "00000110";
    when 7 =>
      FEAT <= "00000111";
  end case;
  
  
    if rising_edge (CLK) then 

      -- increment the stamps values
      stampbtl <= stampbtl + 1;
      stampbtr <= stampbtr + 1;

      -- for the display
      cpt <= cpt + 1;
      
      -- reset if 1
      if reset = '1' then
        CA <= '0';
        CB <= '0';
        CC <= '0';
        CD <= '0';
        CE <= '0';
        CF <= '0';
        CG <= '1';
        
        DP <= '1';

        AN <= X"00";
        
        num <= 0;

        setting <= 0;

        addr <= 0;
        speed <= 0;
        aigui <= 0;
        features <= 0;
        
        
      else    


        -- showing the setting with the corresponding value
        case setting is

          when 0 =>
            -- writing "addr" on display 7 6 5 4


            if num = 0 and cpt > 10000 then
              -- A
              num <= num + 1;
              cpt <= 0;
              
              CA <= '0';
              CB <= '0';
              CC <= '0';
              CD <= '1';
              CE <= '0';
              CF <= '0';
              CG <= '0';

              AN <= X"7F";
              
            elsif num = 1 and cpt > 10000 then
              -- D
              num <= num + 1;
              cpt <= 0;
              
              CA <= '0';
              CB <= '0';
              CC <= '0';
              CD <= '0';
              CE <= '0';
              CF <= '0';
              CG <= '1';

              AN <= X"9F";

            elsif num = 2 and cpt > 10000 then
              --R
              num <= num + 1;
              cpt <= 0;

              CA <= '0';
              CB <= '1';
              CC <= '1';
              CD <= '1';
              CE <= '0';
              CF <= '0';
              CG <= '1';

              AN <= X"EF";


              
            elsif num = 3 and cpt > 10000 then
              -- writing address value on display 0
              num <= 0;
              cpt <= 0;

              seg_display := affiche (addr);
              
              CA <= seg_display(6);
              CB <= seg_display(5);
              CC <= seg_display(4);
              CD <= seg_display(3);
              CE <= seg_display(2);
              CF <= seg_display(1);
              CG <= seg_display(0);

              AN <= X"FE";
 
 
            end if;
            
            
          when 1 =>
            -- writing "sped" on display 7 6 5

            if num = 0 and cpt > 10000 then
              -- S
              num <= num + 1;
              cpt <= 0;
              
              CA <= '0';
              CB <= '1';
              CC <= '0';
              CD <= '0';
              CE <= '1';
              CF <= '0';
              CG <= '0';

              AN <= X"7F";
              
            elsif num = 1 and cpt > 10000 then
              -- P
              num <= num + 1;
              cpt <= 0;
              
              CA <= '0';
              CB <= '0';
              CC <= '1';
              CD <= '1';
              CE <= '0';
              CF <= '0';
              CG <= '0';

              AN <= X"BF";

            elsif num = 2 and cpt > 10000 then
              -- E
              num <= num + 1;
              cpt <= 0;

              CA <= '0';
              CB <= '1';
              CC <= '1';
              CD <= '0';
              CE <= '0';
              CF <= '0';
              CG <= '0';

              AN <= X"DF";

              

            elsif num = 3 and cpt > 10000 then
              --D
              num <= num + 1;
              cpt <= 0;

              CA <= '0';
              CB <= '0';
              CC <= '0';
              CD <= '0';
              CE <= '0';
              CF <= '0';
              CG <= '1';

              AN <= X"EF";


              
            elsif num = 4 and cpt > 10000 then
              -- writing speed value on display 0
              num <= 0;
              cpt <= 0;

              seg_display := affiche (speed);
              
              CA <= seg_display(6);
              CB <= seg_display(5);
              CC <= seg_display(4);
              CD <= seg_display(3);
              CE <= seg_display(2);
              CF <= seg_display(1);
              CG <= seg_display(0);
              
              AN <= X"FE";

            end if;

          when 2 =>
            -- writing "aig" on display 7 6 5

             if num = 0 and cpt > 10000 then
              -- A
              num <= num + 1;
              cpt <= 0;
              
              CA <= '0';
              CB <= '0';
              CC <= '0';
              CD <= '1';
              CE <= '0';
              CF <= '0';
              CG <= '0';

              AN <= X"7F";
              
            elsif num = 1 and cpt > 10000 then
              -- I
              num <= num + 1;
              cpt <= 0;
              
              CA <= '1';
              CB <= '0';
              CC <= '0';
              CD <= '1';
              CE <= '1';
              CF <= '1';
              CG <= '1';

              AN <= X"BF";

            elsif num = 2 and cpt > 10000 then
              -- G
              num <= num + 1;
              cpt <= 0;

              CA <= '0';
              CB <= '1';
              CC <= '0';
              CD <= '0';
              CE <= '0';
              CF <= '0';
              CG <= '0';

              AN <= X"DF";

              
            elsif num = 3 and cpt > 10000 then
              -- writing aiguillage value on display 0
              num <= 0;
              cpt <= 0;

              seg_display := affiche (aigui);
              
              CA <= seg_display(6);
              CB <= seg_display(5);
              CC <= seg_display(4);
              CD <= seg_display(3);
              CE <= seg_display(2);
              CF <= seg_display(1);
              CG <= seg_display(0);

              AN <= X"FE";

              
            end if;   
            
          when 3 =>
            -- writing "feat" on display 7 6 5

            if num = 0 and cpt > 10000 then
              -- F
              num <= num + 1;
              cpt <= 0;
              
              CA <= '0';
              CB <= '1';
              CC <= '1';
              CD <= '1';
              CE <= '0';
              CF <= '0';
              CG <= '0';

              AN <= X"7F";
              
            elsif num = 1 and cpt > 10000 then
              -- E
              num <= num + 1;
              cpt <= 0;
              
              CA <= '0';
              CB <= '1';
              CC <= '1';
              CD <= '0';
              CE <= '0';
              CF <= '0';
              CG <= '0';

              AN <= X"BF";

            elsif num = 2 and cpt > 10000 then
              -- A
              num <= num + 1;
              cpt <= 0;

              CA <= '0';
              CB <= '0';
              CC <= '0';
              CD <= '1';
              CE <= '0';
              CF <= '0';
              CG <= '0';

              AN <= X"DF";

            elsif num = 3 and cpt > 10000 then
              -- T
              num <= num + 1;
              cpt <= 0;

              CA <= '1';
              CB <= '1';
              CC <= '1';
              CD <= '1';
              CE <= '0';
              CF <= '0';
              CG <= '0';

              AN <= X"EF";


            elsif num = 4 and cpt > 10000 then
              -- writing features value on display 0
              num <= 0;
              cpt <= 0;

              seg_display := affiche (features);
              
              CA <= seg_display(6);
              CB <= seg_display(5);
              CC <= seg_display(4);
              CD <= seg_display(3);
              CE <= seg_display(2);
              CF <= seg_display(1);
              CG <= seg_display(0);

              AN <= X"FE";
               
            end if;   


        end case;
            
        -- if someone push the left button
        -- change the type of setting
        if BTNL = '1' and stampbtl > 75000000 then
          --reset the stamp value
          stampbtl <= 0;
          
          setting <= setting + 1;

          num <= 0;
          cpt <= 0;
          
        -- btnr
        end if;
        
        -- if someone push the right button
        -- change the value of the setting
        if BTNR = '1' and stampbtr > 75000000 then
          --reset the stamp value
          stampbtr <= 0;

          
          case setting is

            when 0 =>
              addr <= addr + 1;

            when 1 =>
              speed <= speed + 1;

            when 2 =>
              aigui <= aigui + 1;

            when 3 =>
              features <= features + 1;

          -- setting    
          end case;
        -- btnr  
        end if;

      end if;
            end if;

  end process;


end Behavioral;
