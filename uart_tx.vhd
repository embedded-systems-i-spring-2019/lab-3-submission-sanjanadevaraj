----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2019 03:34:30 PM
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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

entity uart_tx is
port (clk , en , send , rst : in std_logic ;
char : in std_logic_vector (7 downto 0);
ready , tx : out std_logic);
end uart_tx ;

architecture Behavioral of uart_tx is

type state is (idle, start, data);
signal curr : state := idle;
signal d : std_logic_vector(7 downto 0) := (others => '0');
signal d_count : std_logic_vector(3 downto 0);

begin
process(clk)
begin
if rising_edge(clk) then
   if rst = '1' then
      d <= (others => '0');
      ready <= '1';
      tx <='1';
      curr <= idle;
      d <= (others => '0');
      
   end if;
   
   if en = '1' then
      case curr is
      when idle => 
      ready <= '1';
      tx <= '1';
      if send = '1' then
         d <= char;
         curr <= start;
      else 
         ready <= '1';
         tx <= '1';
         curr <= idle;
      end if;
           
       when start => 
       ready <='0';
       tx <= '0';
       curr <= data;
           
       when data =>
       if unsigned(d_count) < 8 then
          tx <= d(to_integer(unsigned(d_count)));    
          d_count <= std_logic_vector(unsigned(d_count) + 1);             
          curr <= data;
       else
           ready <= '1';
           tx <= '1';
           d_count <= "0000";
           curr <= idle;
       end if;
          
       end case;
    end if;
 end if;
end process;
end Behavioral;
