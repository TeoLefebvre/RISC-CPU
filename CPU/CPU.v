// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.0.0 Build 614 04/24/2018 SJ Lite Edition"
// CREATED		"Mon Feb 12 00:31:08 2024"

module CPU(
	clk,
	rst
);


input wire	clk;
input wire	rst;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	[2:0] SYNTHESIZED_WIRE_2;
wire	[2:0] SYNTHESIZED_WIRE_3;
wire	[2:0] SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_28;
wire	[7:0] SYNTHESIZED_WIRE_6;
wire	[7:0] SYNTHESIZED_WIRE_7;
wire	[1:0] SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	[7:0] SYNTHESIZED_WIRE_29;
wire	SYNTHESIZED_WIRE_13;
wire	[7:0] SYNTHESIZED_WIRE_14;
wire	[7:0] SYNTHESIZED_WIRE_15;
wire	[7:0] SYNTHESIZED_WIRE_16;
wire	[7:0] SYNTHESIZED_WIRE_17;
wire	[15:0] SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_30;
wire	SYNTHESIZED_WIRE_20;
wire	[7:0] SYNTHESIZED_WIRE_23;
wire	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_25;





RF	b2v_inst(
	.clk(clk),
	.rst(rst),
	.en(SYNTHESIZED_WIRE_0),
	.rw(SYNTHESIZED_WIRE_1),
	.Addr(SYNTHESIZED_WIRE_2),
	.AddrRA(SYNTHESIZED_WIRE_3),
	.AddrRB(SYNTHESIZED_WIRE_4),
	.Input(SYNTHESIZED_WIRE_28),
	.OutA(SYNTHESIZED_WIRE_14),
	.OutB(SYNTHESIZED_WIRE_15));


ALU	b2v_inst1(
	.A(SYNTHESIZED_WIRE_6),
	.B(SYNTHESIZED_WIRE_7),
	.SelR(SYNTHESIZED_WIRE_8),
	.Status(SYNTHESIZED_WIRE_13),
	.R(SYNTHESIZED_WIRE_28));


Stack	b2v_inst2(
	.rw(SYNTHESIZED_WIRE_9),
	.en(SYNTHESIZED_WIRE_10),
	.clk(clk),
	.rst(rst),
	.Data_in(SYNTHESIZED_WIRE_28),
	.index(SYNTHESIZED_WIRE_29),
	.Data_out(SYNTHESIZED_WIRE_17));


Decode	b2v_inst3(
	.clk(clk),
	.status(SYNTHESIZED_WIRE_13),
	.inA(SYNTHESIZED_WIRE_14),
	.inB(SYNTHESIZED_WIRE_15),
	.inMem(SYNTHESIZED_WIRE_16),
	.inStack(SYNTHESIZED_WIRE_17),
	.instruction(SYNTHESIZED_WIRE_18),
	.EnStack(SYNTHESIZED_WIRE_10),
	.EnRF(SYNTHESIZED_WIRE_0),
	.EnMem(SYNTHESIZED_WIRE_25),
	.EnFetch(SYNTHESIZED_WIRE_30),
	.rwStack(SYNTHESIZED_WIRE_9),
	.rwRF(SYNTHESIZED_WIRE_1),
	.rwMem(SYNTHESIZED_WIRE_24),
	.PC_load(SYNTHESIZED_WIRE_20),
	.AddrDest(SYNTHESIZED_WIRE_2),
	.address(SYNTHESIZED_WIRE_29),
	.AddrRA(SYNTHESIZED_WIRE_3),
	.AddrRB(SYNTHESIZED_WIRE_4),
	.outA(SYNTHESIZED_WIRE_6),
	.outB(SYNTHESIZED_WIRE_7),
	.SelR(SYNTHESIZED_WIRE_8));


Fetch	b2v_inst4(
	.en(SYNTHESIZED_WIRE_30),
	.clk(clk),
	.rst(rst),
	.PC_load(SYNTHESIZED_WIRE_20),
	.PC_Jump(SYNTHESIZED_WIRE_29),
	.PC_out(SYNTHESIZED_WIRE_23));


ROM	b2v_inst5(
	.en(SYNTHESIZED_WIRE_30),
	.clk(clk),
	.rst(rst),
	.Adress(SYNTHESIZED_WIRE_23),
	.Data_out(SYNTHESIZED_WIRE_18));


RAM	b2v_inst6(
	.rw(SYNTHESIZED_WIRE_24),
	.en(SYNTHESIZED_WIRE_25),
	.clk(clk),
	.rst(rst),
	.Adress(SYNTHESIZED_WIRE_29),
	.Data_in(SYNTHESIZED_WIRE_28),
	.Data_out(SYNTHESIZED_WIRE_16));


endmodule
