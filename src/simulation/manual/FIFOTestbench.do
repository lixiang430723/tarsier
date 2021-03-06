transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+../../../extractor {../../../extractor/FIFO.sv}
vlog -sv -work work +incdir+../../../extractor {../../../extractor/FIFOTestbench.sv}

vsim -t 1ns -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L rtl_work -L work -voptargs="+acc"  FIFOTestbench

add wave *
add wave -position end -radix unsigned sim:/FIFOTestbench/fifomod/write_head
add wave -position end -radix unsigned sim:/FIFOTestbench/fifomod/read_head

view structure
view signals

run 1us
