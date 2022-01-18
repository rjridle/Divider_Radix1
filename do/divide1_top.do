# Title:    divide1_top.do
# Author:   ryan.ridley@okstate.edu
# Date:     5 Oct 2021
# Modified: 18 Jan 2022
# Purpose:  .do file script to simulate divide1_top.tb

onbreak {resume}

# create library
#if [file exists work] {
#    vdel -all
#}
#vlib work
#
## compile source files
#vlog divide1_top.sv divide1_top_tb.sv 

# start and run simulation
vsim -voptargs=+acc work.tb

view list
view wave

add wave -noupdate -divider -height 32 "Testbench"
add wave -binary -color #1aff00 /tb/clk
add wave -binary -color #1aff00 /tb/reset
add wave -binary -color #1aff00 /tb/start
add wave -binary -color #a200ff /tb/dividen
add wave -binary -color #a200ff /tb/divisor
add wave -binary -color #0080ff /tb/done
add wave -binary -color #0080ff /tb/sign
add wave -binary -color #0080ff /tb/err
add wave -binary -color gold    /tb/Q
add wave -binary -color gold    /tb/R

add wave -noupdate -divider -height 32 "Control Signals"
add wave -binary -color #1aff00 /tb/dut/clk
add wave -binary -color #1aff00 /tb/dut/reset
add wave -binary -color #1aff00 /tb/dut/start
add wave -binary -color #1aff00 /tb/dut/done
add wave -binary -color #1aff00 /tb/dut/err
add wave -binary -color #1aff00 /tb/dut/state0

add wave -noupdate -divider -height 32 "divide1_top"
# Input
add wave -binary -color #a200ff /tb/dut/dividen
add wave -binary -color #a200ff /tb/dut/divisor

# Internal logic
add wave -binary -color #0080ff /tb/dut/divisor2c
add wave -binary -color #0080ff /tb/dut/dividen_unsigned
add wave -binary -color #0080ff /tb/dut/Qsigned
add wave -binary -color #0080ff /tb/dut/Qnext
add wave -binary -color #0080ff /tb/dut/Rnext
add wave -binary -color #0080ff /tb/dut/Rtemp
add wave -binary -color #0080ff /tb/dut/Qtemp
add wave -binary -color #0080ff /tb/dut/en
add wave -binary -color #0080ff /tb/dut/correct_en

# Output
add wave -binary -color gold /tb/dut/Q
add wave -binary -color gold /tb/dut/R
add wave -binary -color gold /tb/dut/sign

add wave -noupdate -divider -height 32 "div: divide1(divisor2, Q, R, Qnext, Rnext)"
add wave -binary -color #1aff00 /tb/dut/clk
add wave -binary -color #1aff00 /tb/dut/start
add wave -binary -color #a200ff /tb/dut/div/D
add wave -binary -color #a200ff /tb/dut/div/Q
add wave -binary -color #a200ff /tb/dut/div/R
add wave -binary -color #0080ff /tb/dut/div/Rshift
add wave -binary -color #0080ff /tb/dut/div/Qshift
add wave -binary -color #0080ff /tb/dut/div/Rtemp
add wave -binary -color #0080ff /tb/dut/div/Rsave
add wave -binary -color gold /tb/dut/div/Qout
add wave -binary -color gold /tb/dut/div/Rout

add wave -noupdate -divider -height 32 "control: fsm(~clk, reset, start, err, done, en, state0)"
add wave -binary -color #1aff00 /tb/dut/control/clk
add wave -binary -color #1aff00 /tb/dut/control/reset
add wave -binary -color #a200ff /tb/dut/control/start
add wave -binary -color #a200ff /tb/dut/control/err
add wave -color #0080ff /tb/dut/control/CURRENT_STATE
add wave -color #0080ff /tb/dut/control/NEXT_STATE
add wave -binary -color #0080ff /tb/dut/control/COUNTER
add wave -binary -color #0080ff /tb/dut/control/COUNTER_NEXT
add wave -binary -color gold /tb/dut/control/done
add wave -binary -color gold /tb/dut/control/en
add wave -binary -color gold /tb/dut/control/correct_en
add wave -binary -color gold /tb/dut/control/state0

add wave -noupdate -divider -height 32 "Rnext_mux: mux3(R, 'b0, {correct_en, state0}, Rnext)"
add wave -binary -color #1aff00 /tb/dut/clk
add wave -binary -color #a200ff /tb/dut/Rnext_mux/d0
add wave -binary -color #a200ff /tb/dut/Rnext_mux/d1
add wave -binary -color #a200ff /tb/dut/Rnext_mux/d2
add wave -binary -color #a200ff /tb/dut/Rnext_mux/s
add wave -binary -color gold /tb/dut/Rnext_mux/y

add wave -noupdate -divider -height 32 "Qnext_mux: mux3(Q, dividen_unsigned, Qsigned, {correct_en, state0}, Qnext)"
add wave -binary -color #1aff00 /tb/dut/clk
add wave -binary -color #a200ff /tb/dut/Qnext_mux/d0
add wave -binary -color #a200ff /tb/dut/Qnext_mux/d1
add wave -binary -color #a200ff /tb/dut/Qnext_mux/d2
add wave -binary -color #a200ff /tb/dut/Qnext_mux/s
add wave -binary -color gold /tb/dut/Qnext_mux/y

add wave -noupdate -divider -height 32 "Q_flopenr: flopenr(clk, reset, en, Qnext, Q)"
add wave -binary -color #1aff00 /tb/dut/Q_flopenr/clk
add wave -binary -color #1aff00 /tb/dut/Q_flopenr/reset
add wave -binary -color #1aff00 /tb/dut/Q_flopenr/en
add wave -binary -color #a200ff /tb/dut/Q_flopenr/d
add wave -binary -color gold /tb/dut/Q_flopenr/q

add wave -noupdate -divider -height 32 "R_flopenr: flopenr(clk, reset, en, Rnext, R)"
add wave -binary -color #1aff00 /tb/dut/R_flopenr/clk
add wave -binary -color #1aff00 /tb/dut/R_flopenr/reset
add wave -binary -color #1aff00 /tb/dut/R_flopenr/en
add wave -binary -color gold /tb/dut/R_flopenr/d
add wave -binary -color gold /tb/dut/R_flopenr/q

add wave -noupdate -divider -height 32 "Qtemp_flopenr: flopenr(clk, reset, ~correct_en, Qnext, Qtemp)"
add wave -binary -color #1aff00 /tb/dut/Rtemp_flopenr/clk
add wave -binary -color #1aff00 /tb/dut/Rtemp_flopenr/reset
add wave -binary -color #1aff00 /tb/dut/Rtemp_flopenr/en
add wave -binary -color #a200ff /tb/dut/Rtemp_flopenr/d
add wave -binary -color gold /tb/dut/Rtemp_flopenr/q

add wave -noupdate -divider -height 32 "Rtemp_flopenr: flopenr(clk, reset, ~correct_en, Rnext, Rtemp)"
add wave -binary -color #1aff00 /tb/dut/Rtemp_flopenr/clk
add wave -binary -color #1aff00 /tb/dut/Rtemp_flopenr/reset
add wave -binary -color #1aff00 /tb/dut/Rtemp_flopenr/en
add wave -binary -color #a200ff /tb/dut/Rtemp_flopenr/d
add wave -binary -color gold /tb/dut/Rtemp_flopenr/q

add wave -noupdate -divider -height 32 "divisor2C: adder(~divisor(a), WIDTH'b1(b), divisor2c(y))"
add wave -binary -color #a200ff /tb/dut/divisor2C/a
add wave -binary -color #a200ff /tb/dut/divisor2C/b
add wave -binary -color gold /tb/dut/divisor2C/y

add wave -noupdate -divider -height 32 "dividen_uns: adder()"
add wave -binary -color #a200ff /tb/dut/dividen_uns/a
add wave -binary -color #a200ff /tb/dut/dividen_uns/b
add wave -binary -color gold /tb/dut/dividen_uns/y

add wave -noupdate -divider -height 32 "quotient_sig: adder()"
add wave -binary -color #a200ff /tb/dut/quotient_sig/a
add wave -binary -color #a200ff /tb/dut/quotient_sig/b
add wave -binary -color gold /tb/dut/quotient_sig/y

-- Set Wave Output Items
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ps} {75 ns}
configure wave -namecolwidth 350
configure wave -valuecolwidth 100 
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 5
configure wave -childrowmargin 2

-- Run the Simulation
run 170ns

