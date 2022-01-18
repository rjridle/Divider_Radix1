#Title:    Makefile
#Author:   ryan.ridley@okstate.edu
#Date:     5 Oct 2021 
#Modified: 18 Jan 2022
#Purpose:  make flow for compiling and simulating divide1 module

RUN_DIR:=$(shell pwd)
DO_DIR:=$(RUN_DIR)/do
TB_DIR:=$(RUN_DIR)/tb
MODULES_DIR:=$(RUN_DIR)/modules
OUT_DIR:=$(RUN_DIR)/out

#set which do and tb file to run
DO_FILE:=$(DO_DIR)/divide1_top.do
TB_FILE:=$(TB_DIR)/divide1_top_tb.sv

.PHONY: defualt run clean

default: run

run: clean
	cd $(DO_DIR) 
	vlib work
	vlog $(MODULES_DIR)/* $(TB_FILE)
	vsim -do $(DO_FILE)
	mv *.wlf transcript work $(DO_DIR)

clean:
	rm -rf $(DO_DIR)/vsim.wlf $(DO_DIR)/transcript $(DO_DIR)/work
