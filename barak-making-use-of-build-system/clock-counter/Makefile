TOP=../..

-include  $(TOP)/Make.local
include $(TOP)/Make.rules

.PHONY: all clean burn world timings

#FILES= \
#	clock_counter.v \
	#clock_divider.v \
	#top.v clock_counter.v
	#top.v clock_counter.v clock_divider.v 

FILES= \
	top.v \
	clock_counter.v \
	clock_divider.v 

	

all:: top.bin


#top.blif: $(FILES)
#	$(COMPILE.v) -p "synth_ice40 -top top -blif $@" $^

top.json: $(FILES)
	$(COMPILE.v) -p "synth_ice40 -top top -json $@" $^


timing: top.asc
	icetime -tmd $(DEVICE) $^


top_tb.vvp : top_tb.v $(FILES)
	iverilog -o $@ $^

# Run a simulation. But don't plot it.
run: top_tb.vvp
	vvp top_tb.vvp

plot: top_tb.vcd
	gtkwave $^

prog: top.bin
	$(FLASH_PROG) $^


# extra dependancies
top.asc: $(PINMAP)
