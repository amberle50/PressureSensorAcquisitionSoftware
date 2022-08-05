DAQ_acquire - January 2021

This program reads continuous data from a set of eight piezoelectric pressure sensors hooked up to a NI DAQ. It then converts the resulting voltage into pascals and creates two figures, one with the raw voltages and one with the converted pascals. This function uses a built-in dq function and requires the NI DAQ toolbox to run. This does not work on Mac OS.

INPUTS
-8 separate 5V input signals from a DAQ hooked up to 8 piezoelectric pressure sensors

OUTPUTS
-figure with all eight raw voltage signals stacked on top of each other
-figure with each of the eight converted pressure signals in a separate subplot
-a .mat file with the raw voltage signals from each sensor

IMPORTANT
-You need to change the save paths before use.
-You need to change the conversion equations to match your specific sensors.

