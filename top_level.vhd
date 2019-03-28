----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2019 04:00:58 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
port(TXD, clk : in std_logic;
btn : in std_logic_vector(1 downto 0);
CTS, RTS, RXD: out std_logic);
end top_level;

architecture top_level_ckt of top_level is

signal dbnce: std_logic_vector(1 downto 0);
signal div, send, ready, tx : std_logic;
signal char: std_logic_vector(7 downto 0);

component debounce is
port( clk: in std_logic;
btn: in std_logic;
dbnc: out std_logic);
end component;

component clk_div
port( clk : in std_logic;
div : out std_logic);
end component;

component sender is
port( rst, clk, en, btn, rdy : in std_logic;
send : out std_logic;
char : out std_logic_vector(7 downto 0));
end component;

component uart is
port( clk, en, send, rx, rst : in std_logic;
charSend : in std_logic_vector(7 downto 0);
ready, tx, newChar : out std_logic;
charRec : out std_logic_vector (7 downto 0));
end component;   
    
begin

CTS <= '0';
RTS <= '0';

u1: debounce
port map(clk => clk,
btn => btn(0),
dbnc => dbnce(0));

u2: debounce
port map(clk => clk,
btn => btn(1),
dbnc => dbnce(1));
             
u3: clk_div
port map(clk => clk,
div => div);


u4: sender
port map( btn => dbnce(1),
clk => clk,
en => div,
rdy => ready,
rst => dbnce(0),
char => char,
send => send);

u5: uart
port map( charSend => char,
clk => clk,
en => div,
rst => dbnce(0),
rx => TXD,
send => send,
ready => ready, 
tx => RXD);

end top_level_ckt;