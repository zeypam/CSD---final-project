----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2024 21:17:47
-- Design Name: 
-- Module Name: final_project_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity final_project_1 is
  Port ( A  : in unsigned(1 downto 0);
        B   : in unsigned(1 downto 0);
        clk : in std_logic;
        we  : in std_logic;
        din : in unsigned(3 downto 0);
        full : out std_logic;
        empty : out std_logic;
        parkfree: out unsigned(3 downto 0);
        seg1: out unsigned(6 downto 0);
        seg2: out unsigned(6 downto 0);
        an0 : out std_logic;
        an1 : out std_logic
   );
end final_project_1;

architecture Behavioral of final_project_1 is
    signal count: unsigned(3 downto 0) := "1111";
    signal max_space: unsigned(3 downto 0) := "1111"; --space capacity of parking lot
begin
    an0 <= '1';
    an1 <= '0';
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                  max_space <= din;
--                  count <= din; -- gives error
            end if;
                   -- makes count and space equal to input din which is the capacity of parking space    
        end if;
        count <= max_space;
        --      GATE A
        -- car entry 
        if A(0) = '1' and A(1) = '0' then
            if A(0) = '1' and A(1) = '1' then
                if A(0) = '0' and A(1) = '1' then
                    if A(0) = '0' and A(1) = '0' then
                        if count > 0 then
                            count <= count-1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
        
        -- car exit 
        if A(0) = '0' and A(1) = '1' then
            if A(0) = '1' and A(1) = '1' then
                if A(0) = '1' and A(1) = '0' then
                    if A(0) = '0' and A(1) = '0' then
                        if count < max_space then
                            count <= count+1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
        
        --    GATE B 
        -- car entry
        if B(0) = '1' and B(1) = '0' then
            if B(0) = '1' and B(1) = '1' then
                if B(0) = '0' and B(1) = '1' then
                    if B(0) = '0' and B(1) = '0' then
                        if count > 0 then
                            count <= count-1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
        
        -- car exit 
        if B(0) = '0' and B(1) = '1' then
            if B(0) = '1' and B(1) = '1' then
                if B(0) = '1' and B(1) = '0' then
                    if B(0) = '0' and B(1) = '0' then
                        if count < max_space then
                            count <= count+1;
                        end if;
                    end if;
                end if;
            end if;
        end if;       
        
    end process;

    parkfree <= count;

    process(count)
    begin
        if count > 9 then
            seg2 <= "1111001"; --1
            case count is 
                when "1010" => seg1 <= "1000000"; --0
                when "1011" => seg1 <= "1111001"; --1
                when "1100" => seg1 <= "0100100"; --2 "1011011"
                when "1101" => seg1 <= "0110000"; --3 "1001111"
                when "1110" => seg1 <= "0011001"; --4 "1100110"
                when "1111" => seg1 <= "0010010"; --5 "1101101"
                when others => seg1 <= "1000000"; -- by default
            end case;      
--        end if;
        elsif count < 9 then
            seg2 <= "1000000";
            case count is
                when "0000" => seg1 <= "1000000"; --0
                when "0001" => seg1 <= "1111001"; --1 --0000110
                when "0010" => seg1 <= "0100100"; --2
                when "0011" => seg1 <= "0110000"; --3
                when "0100" => seg1 <= "0011001"; --4
                when "0101" => seg1 <= "0010010"; --5
                when "0110" => seg1 <= "1111101"; --6  --1111101
                when "0111" => seg1 <= "1111000"; --7  --0000111
                when "1000" => seg1 <= "0000000"; --8  --1111111
                when "1001" => seg1 <= "0010000"; --9  --1101111
                when others => seg1 <= "1000000";  -- by default
            end case;
        end if;
    end process;
    
    full <= '1' when count = din else '0'; 
    empty <= '1' when count = 0 else '0';   -- count = "0000"  should be in this way but it gave an error so changed it to 0
    
    
end Behavioral;
