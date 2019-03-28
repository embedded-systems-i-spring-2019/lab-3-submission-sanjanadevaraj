----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2019 04:00:04 PM
-- Design Name: 
-- Module Name: sender - Behavioral
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

entity sender is
port(rst, clk, en, btn, rdy : in std_logic;
send : out std_logic;
char : out std_logic_vector(7 downto 0));
end sender;

architecture Behavioral of sender is

type str is array (0 to 5) of std_logic_vector(7 downto 0);
signal NETID : str := (X"73", X"64", X"31", X"30", X"34", X"39");
type state is (idle, busyA, busyB, busyC);
signal curr : state := idle;
signal i : std_logic_vector(4 downto 0);

begin
FSM: process(clk, en)
     begin
        if rising_edge(clk) and en = '1' then
            if rst = '1' then
                char <= "00000000";
                i <= "00000";
                curr <= idle;
                send <= '0';
            end if;
        case curr is
        when idle =>
        if rdy = '1' and btn = '1' then
           if unsigned(i) < 6 then
              send <= '1';
              char <= netid(to_integer(unsigned(i)));                       
              i <= std_logic_vector(unsigned(i) + 1);
              curr <= busyA;
           else
              i <= "00000";
              curr <= idle;
           end if;
        end if;
        
        when busyA =>
        curr <= busyB;
        
        when busyB =>
        send <= '0';
        curr <= busyC; 
        
        when busyC =>
        if rdy = '1' and btn = '0' then
           curr <= idle;
        end if;                
      end case;
    end if;
end process;
end Behavioral;
