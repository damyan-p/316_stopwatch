## This file is the constraints file. It maps the input/output variables in your design modules to the actual hardware.
## Each pin corresponds to a device on the board. For example, pin V17 corresponds to SW0, the rightmost switch.
## We use CMOS (LVCMOS33) logic on the board, meaning a "0" is 0V, and a "1" is 3.3V.
## You don't need to understand every line of this file, but be able to describe what each of the 6 uncommented lines does.

## Clock signal - Uncomment if needed (will be used in future labs)
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {sel[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sel[0]}]    
set_property PACKAGE_PIN V16 [get_ports {sel[1]}]			
	set_property IOSTANDARD LVCMOS33 [get_ports {sel[1]}]    
	
set_property PACKAGE_PIN V2 [get_ports {load[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {load[0]}]
set_property PACKAGE_PIN T3 [get_ports {load[1]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {load[1]}]
set_property PACKAGE_PIN T2 [get_ports {load[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {load[2]}]
set_property PACKAGE_PIN R3 [get_ports {load[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {load[3]}]
set_property PACKAGE_PIN W2 [get_ports {load[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {load[4]}]
set_property PACKAGE_PIN U1 [get_ports {load[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {load[5]}]
set_property PACKAGE_PIN T1 [get_ports {load[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {load[6]}]
set_property PACKAGE_PIN R2 [get_ports {load[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {load[7]}]
 
##7 segment display
set_property PACKAGE_PIN W7 [get_ports {sseg[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[0]}]
set_property PACKAGE_PIN W6 [get_ports {sseg[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[1]}]
set_property PACKAGE_PIN U8 [get_ports {sseg[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[2]}]
set_property PACKAGE_PIN V8 [get_ports {sseg[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[3]}]
set_property PACKAGE_PIN U5 [get_ports {sseg[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[4]}]
set_property PACKAGE_PIN V5 [get_ports {sseg[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[5]}]
set_property PACKAGE_PIN U7 [get_ports {sseg[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[6]}]

set_property PACKAGE_PIN V7 [get_ports dp]							
	set_property IOSTANDARD LVCMOS33 [get_ports dp]

set_property PACKAGE_PIN U2 [get_ports {an[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]

##Buttons
set_property PACKAGE_PIN U18 [get_ports R]						
	set_property IOSTANDARD LVCMOS33 [get_ports R]
set_property PACKAGE_PIN T18 [get_ports P]						
	set_property IOSTANDARD LVCMOS33 [get_ports P]
