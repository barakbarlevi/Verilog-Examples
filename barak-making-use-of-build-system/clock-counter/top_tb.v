// Testbench for a clock- divided 4-bit counter
// Heavily based on Shawn Hymel's and John Winans's FPGA tutorials.

`timescale 1 ns / 10 ps		// ` is a compiler directive for iverilog.
				// Defines timescale for simulation: <time_unit> / <time_precision>
				// <time_unit> is equivalent to #1. So in this case, #10 is 10[ns]
module tb();
    // We have no ports in our ports list. There are not inputs/outputs in the testbench. Everything is contained internally.
    wire[3:0] led;
    reg       clk = 0;
    reg       rst = 0; 

    localparam DURATION = 2000000000;	// Simulation duration time
    
    // Generate clock signal: 1 / ((2 * 41.67) * 1 ns) = 11,999,040.08 MHz. The 2* for a complete cycle
    // This always block doesn't have a sensitivity list. When we're simulating, we can do this. See John's
    // lecture on timing at https://www.youtube.com/watch?v=xZhl64vHJ-E&list=PL3by7evD3F52On-ws9pcdQuEL-rYbNNFB&index=11
    always begin	
        // Delay for 41.67 time units
        // 10 ps precision means that 41.667 is rounded to 41.67
        #41.667
        clk = ~clk;
    end
    
   // Instantiate the unit under test (UUT)
   top #(.COUNT_WIDTH(32), .MAX_COUNT(6000000 - 1)) uut (
	.clk(clk),
	.rst_btn(~rst),
	.led(led)
   );
    
    // Pulse reset line high at the beginning
    // Initial blocks only run once, and are only for simulation
    initial begin
        #10
        rst = 1'b1;
        #1
        rst = 1'b0;
    end
    
    // Run simulation (output to .vcd file)
    initial begin
        $dumpfile("top_tb.vcd");  // $ denote system task/function. Helps control the simulation, not synthesizable
        $dumpvars(0, tb);	  // First parameter is depth of recorded modules. 0 - record all
        #(DURATION)
        $display("Finished!");
        $finish;
    end
    
endmodule
