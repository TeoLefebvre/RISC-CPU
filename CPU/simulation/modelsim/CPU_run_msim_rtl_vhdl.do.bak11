transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/Users/teo/Documents/CS/2A/cours/architecture_des_systemes_numeriques/projet/CPU_Teo/ALU.vhd}
vcom -93 -work work {D:/Users/teo/Documents/CS/2A/cours/architecture_des_systemes_numeriques/projet/CPU_Teo/RF.vhd}
vcom -93 -work work {D:/Users/teo/Documents/CS/2A/cours/architecture_des_systemes_numeriques/projet/CPU_Teo/Decode.vhd}
vcom -93 -work work {D:/Users/teo/Documents/CS/2A/cours/architecture_des_systemes_numeriques/projet/CPU_Teo/Fetch.vhd}
vcom -93 -work work {D:/Users/teo/Documents/CS/2A/cours/architecture_des_systemes_numeriques/projet/CPU_Teo/RAM.vhd}
vcom -93 -work work {D:/Users/teo/Documents/CS/2A/cours/architecture_des_systemes_numeriques/projet/CPU_Teo/ROM.vhd}
vcom -93 -work work {D:/Users/teo/Documents/CS/2A/cours/architecture_des_systemes_numeriques/projet/CPU_Teo/Stack.vhd}

vcom -93 -work work {D:/Users/teo/Documents/CS/2A/cours/architecture_des_systemes_numeriques/projet/CPU_Teo/CPU_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  CPU_tb

add wave *
view structure
view signals
run 15 us
