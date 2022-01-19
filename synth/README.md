# Synthesis

This flow uses Synopsys DC_Shell to run synthesis. First, to run the flow, a
standard cell library must be implemented. in `.synopsys_dc.setup`, there is
a section to had the path to the library. Also, lines 71 and 78 in
`scripts/synth.tcl`, a driving cell must be set. Other than those two changes,
the flow ready to be used. Just run 

```
make synth
```

and reports for timing, area, power, and constraints will be made.
