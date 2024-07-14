----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2024 18:47:38
-- Design Name: 
-- Module Name: final_project_tb - Behavioral
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

entity final_project_tb is
--  Port (  );
end final_project_tb;

architecture Behavioral of final_project_tb is
    
    -- component declaration
    component final_project
        port(
               A      : in unsigned(1 downto 0);
               B        : in unsigned(1 downto 0);
               clk      : in std_logic;
               we       : in std_logic;
               din      : in unsigned(3 downto 0);
               full     : out std_logic;
               empty    : out std_logic;
               parkfree : out unsigned(3 downto 0)
           );
           
       end component;
       
       -- tb signals
    signal A        :     unsigned(1 downto 0);
    signal B        :     unsigned(1 downto 0);
    signal clk      :     std_logic;
    signal we       :     std_logic;
    signal din      :     unsigned(3 downto 0);
    signal full     :     std_logic;
    signal empty    :     std_logic;
    signal parkfree :     unsigned(3 downto 0);

    constant clk_period : time := 10 ns;
    
begin

    uut: final_project
        port map ( A => A,
                   B => B,
                   clk => clk,
                   we => we,
                   din => din,
                   full => full,
                   empty => empty,
                   parkfree => parkfree
        );
    
    clk_process : process
    begin
        clk <= '0';
        wait for 20 ns;
        clk <= '1';
        wait for 20 ns;
    end process;
    
    -- stimulus
    stim_proc: process
    begin
            -- Set the total number of parking spaces to 8 and enable write
            din <= "1000";
            we <= '1';
            wait for clk_period;
            we <= '0';
            wait for 20 ns;
    
            --  car entry at gate A
            A <= "10";
            wait for 20 ns;
            A <= "01";
            wait for 20 ns;
            A <= "00";
            wait for 20 ns;
    
            -- car exiting at gate A
            A <= "01";
            wait for 20 ns;
            A <= "10";
            wait for 20 ns;
            A <= "00";
            wait for 20 ns;
    
            -- car entry at gate B
            B <= "10";
            wait for 20 ns;
            B <= "01";
            wait for 20 ns;
            B <= "00";
            wait for 20 ns;
    
            -- car exiting at gate B
            B <= "01";
            wait for 20 ns;
            B <= "10";
            wait for 20 ns;
            B <= "00";
            wait for 20 ns;
    
            --  simultaneous operation TEST
            A <= "10"; B <= "10";
            wait for 20 ns;
            A <= "01"; B <= "01";
            wait for 20 ns;
            A <= "00"; B <= "00";
            wait for 20 ns;
    

            wait;
    end process;

end Behavioral;





--clk_gen: process is
--begin

--wait for 10 ns; clk <= '0';
--wait for 10 ns; clk <= '1';

--end process clk_gen;

--stimuli: process is 
--begin  
--     A(0) <= '1';
--     A(1) <= '0';
--     wait for 20 ns;  
--     A(0) <= '1';
--     A(1) <= '1';
--     wait for 20 ns; 
--     A(0) <= '0';
--     A(1) <= '1';
--     wait for 20 ns;
--     B(0) <= '0';
--     B(1) <= '1';
--     wait for 20 ns; 
--     B(0) <= '0';
--     B(1) <= '1';
--     wait for 20 ns; 
--     B(0) <= '0';
--     B(1) <= '1';
--     wait for 20 ns;     
--     A(0) <= '0' ;
--     A(1) <= '0' ;
--     B(0) <= '0' ;
--     B(1) <= '0' ;
--    wait for 300 ns;    
--     wait;
--end process stimuli;
  
