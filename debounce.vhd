----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2019 04:02:33 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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


entity debounce is
port(clk: in std_logic;
btn: in std_logic;
dbnc: out std_logic);
end debounce;

architecture debounce_ckt of debounce is
signal reg : std_logic_vector (1 downto 0);
signal counter : std_logic_vector(21 downto 0);
begin

process (clk)
begin

if (rising_edge(clk)) then
    reg(1) <= reg(0);
    reg(0) <= btn;
    
if (unsigned(counter)<= 2499999) then
    dbnc <= '0';
    if reg(1) = '1' then
    counter <= std_logic_vector(unsigned(counter)+1);
    elsif (reg(1)='0') then
    counter <= (others => '0');
    end if;
    elsif(unsigned(counter)= 2500000) then
    if(reg(1)='1') then
    dbnc <='1'; 
    else
    dbnc <='0';
    counter <= (others =>'0');
    end if;
end if;
end if;
end process;

end debounce_ckt;

