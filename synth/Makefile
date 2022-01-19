# Title:    Makefile  
# Author:   Ryan Ridley 
# Date:     19 Jan 2022
# Modified:  
# Purpose:  Basic synthesis for divider algorithm
# 
NAME	:= synth

default:
	@echo "Basic synthesis procedure for division module:"
	@echo

synth:
	@echo "DC Synthesis"
	dc_shell-xg-t -64bit -f scripts/$(NAME).tcl | tee $(NAME).out


clean:
	rm -rf WORK mapped unmapped reports analyzed $(NAME).out
	mkdir mapped unmapped reports
	rm -f default.svf
	rm -f command.log
	rm -f filenames*.log



