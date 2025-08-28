if {[file isdirectory work]} {vdel -all -lib work}
vlib work
vmap work work

vlog -work work ../src/clock_divisor.v
vlog -work work ../src/counter.v
vlog -work work ../src/dspl_drv_NexysA7.v
vlog -work work ../src/debounce.v
vlog -work work ../src/top.v

vlog -work work tb.v
vsim -voptargs=+acc work.tb

quietly set StdArithNoWarnings 1
quietly set StdVitalGlitchNoWarnings 1

do wave.do
run -all