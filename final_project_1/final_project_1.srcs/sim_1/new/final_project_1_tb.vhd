----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2024 22:06:28
-- Design Name: 
-- Module Name: final_project_1_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity final_project_1_tb is
--  Port ( );
end final_project_1_tb;

architecture Behavioral of final_project_1_tb is
        -- component declaration
    component final_project_1
        port(
               A      : in unsigned(1 downto 0);
               B        : in unsigned(1 downto 0);
               clk      : in std_logic;
               we       : in std_logic;
               din      : in unsigned(3 downto 0);
               full     : out std_logic;
               empty    : out std_logic;
               parkfree : out unsigned(3 downto 0);
               seg1: out unsigned(6 downto 0);
               seg2: out unsigned(6 downto 0);
               an0 : out std_logic;
               an1 : out std_logic
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
    signal seg1     :     unsigned(6 downto 0);
    signal seg2     :     unsigned(6 downto 0);
    signal an0      :     std_logic;
    signal an1      :     std_logic;
    
    constant clk_period : time := 10 ns;

begin

    uut: final_project_1
    port map ( A => A,
               B => B,
               clk => clk,
               we => we,
               din => din,
               full => full,
               empty => empty,
               parkfree => parkfree,
               seg1 => seg1,
               seg2 => seg2,
               an0 => an0,
               an1 => an1
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

  

