----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2019 04:01:46 PM
-- Design Name: 
-- Module Name: clock_div - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clk_div is
port (clk : in std_logic;
  div : out std_logic);
end clk_div;

architecture clk_ckt of clk_div is
signal counter : std_logic_vector (25 downto 0) := (others => '0');

begin
process(clk) 
begin
if rising_edge(clk) then
   if(unsigned(counter) < 1085) then
      div <= '0';
      counter <= std_logic_vector( unsigned(counter) + 1 );
   else
      counter <= (others => '0');
      div <= '1';
  end if;
end if;
end process;

end clk_ckt;