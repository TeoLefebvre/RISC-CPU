-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 18.0.0 Build 614 04/24/2018 SJ Lite Edition"
-- CREATED		"Sun Feb 11 23:08:38 2024"

LIBRARY ieee;
USE ieee.std_logic_1164.all;
Use ieee.numeric_std.all ; 

LIBRARY work;

ENTITY CPU_tb IS
END CPU_tb;

ARCHITECTURE bdf_type OF CPU_tb IS 

COMPONENT rf
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 en : IN STD_LOGIC;
		 rw : IN STD_LOGIC;
		 Addr : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 AddrRA : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 AddrRB : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 Input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 OutA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 OutB : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu
	PORT(A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 SelR : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 Status : OUT STD_LOGIC;
		 R : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT stack
	PORT(rw : IN STD_LOGIC;
		 en : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 Data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 index : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT decode
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 status : IN STD_LOGIC;
		 inA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 inB : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 inMem : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 inStack : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 EnStack : OUT STD_LOGIC;
		 EnRF : OUT STD_LOGIC;
		 EnMem : OUT STD_LOGIC;
		 EnFetch : OUT STD_LOGIC;
		 EnROM : OUT STD_LOGIC;
		 rwStack : OUT STD_LOGIC;
		 rwRF : OUT STD_LOGIC;
		 rwMem : OUT STD_LOGIC;
		 PC_load : OUT STD_LOGIC;
		 AddrDest : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 address : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 AddrRA : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 AddrRB : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 outA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 outB : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 SelR : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fetch
	PORT(en : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 PC_load : IN STD_LOGIC;
		 PC_Jump : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 PC_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rom
	PORT(en : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 Adress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ram
	PORT(rw : IN STD_LOGIC;
		 en : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 Adress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	EnRF :  STD_LOGIC;
SIGNAL	rwRF :  STD_LOGIC;
SIGNAL	AddrDest :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	AddrRA :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	AddrRB :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	Result :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	A :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	B :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SelR :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	rwStack :  STD_LOGIC;
SIGNAL	EnStack :  STD_LOGIC;
SIGNAL	address :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Status :  STD_LOGIC;
SIGNAL	RegA :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	RegB :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	inMem :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	inStack :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	instruction :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	EnFetch :  STD_LOGIC;
SIGNAL	PC_Load :  STD_LOGIC;
SIGNAL	InstrAddr :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	rwMem :  STD_LOGIC;
SIGNAL	EnMem :  STD_LOGIC;
SIGNAL 	EnROM : STD_LOGIC;
SIGNAL	clk : std_logic := '0';
SIGNAL	rst : std_logic := '1';
SIGNAL 	InstrAddrDec : integer range 0 to 255;


BEGIN 



RF_inst : component rf
PORT MAP(clk => clk, rst => rst,
		 en => EnRF,
		 rw => rwRF,
		 Addr => AddrDest,
		 AddrRA => AddrRA,
		 AddrRB => AddrRB,
		 Input => Result,
		 OutA => RegA,
		 OutB => RegB);


ALU_inst : component alu
PORT MAP(A => A,
		 B => B,
		 SelR => SelR,
		 Status => Status,
		 R => Result);


Stack_inst : component stack
PORT MAP(clk => clk, rst => rst,
		 rw => rwStack,
		 en => EnStack,
		 Data_in => Result,
		 index => address,
		 Data_out => inStack);


Decode_inst : component decode
PORT MAP(clk => clk,
		 rst => rst,
		 status => Status,
		 inA => RegA,
		 inB => RegB,
		 inMem => inMem,
		 inStack => inStack,
		 instruction => instruction,
		 EnStack => EnStack,
		 EnRF => EnRF,
		 EnMem => EnMem,
		 EnFetch => EnFetch,
		 EnROM => EnROM,
		 rwStack => rwStack,
		 rwRF => rwRF,
		 rwMem => rwMem,
		 PC_load => PC_Load,
		 AddrDest => AddrDest,
		 address => address,
		 AddrRA => AddrRA,
		 AddrRB => AddrRB,
		 outA => A,
		 outB => B,
		 SelR => SelR);


Fetch_inst : component fetch
PORT MAP(clk => clk, rst => rst,
		 en => EnFetch,
		 PC_load => PC_Load,
		 PC_Jump => address,
		 PC_out => InstrAddr);


ROM_inst : component rom
PORT MAP(clk => clk, rst => rst,
		 en => EnROM,
		 Adress => InstrAddr,
		 Data_out => instruction);


RAM_inst : component ram
PORT MAP(clk => clk, rst => rst,
		 rw => rwMem,
		 en => EnMem,
		 Adress => address,
		 Data_in => Result,
		 Data_out => inMem);

InstrAddrDec <= to_integer(unsigned(InstrAddr));
rst <= '0' after 50 ns;		 
clk <= not clk after 10 ns;

END bdf_type;