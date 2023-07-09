# How to run the synthesis

The current synthesis is set up to work with a clock of 7ns, expressed from `timing_constraint_ns` in the tcl file.

To sun the synthesis, first use `setsynopys` and then, in this folder:

`dc_shell-xg-t -f ./syn_script.tcl`

