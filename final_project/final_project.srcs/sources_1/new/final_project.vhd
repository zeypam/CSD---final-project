----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2024 15:51:29
-- Design Name: 
-- Module Name: final_project - Behavioral
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

entity final_project is
  Port ( A  : in unsigned(1 downto 0);
        B   : in unsigned(1 downto 0);
        clk : in std_logic;
        we  : in std_logic;
        din : in unsigned(3 downto 0);
        full : out std_logic;
        empty : out std_logic;
        parkfree: out unsigned(3 downto 0)

   );
end final_project;

architecture Behavioral of final_project is
    signal count: unsigned(3 downto 0) := "1111";
    signal max_space: unsigned(3 downto 0) := "1111"; --space capacity of parking lot
begin
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
    
    full <= '1' when count = din else '0'; 
    empty <= '1' when count = 0 else '0';   -- count = "0000"  should be in this way but it gave an error so changed it to 0
    
    
end Behavioral;

--        if A = 2 then
--            if A = 3 then
--                if A = 1 then
--                    if A = 0 then
--                        if count > 0 then
--                            count <= count-1;
--                        end if;
--                    end if;
--                end if;
--            end if;
--        end if;
