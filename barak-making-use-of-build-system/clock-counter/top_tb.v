// Testbench for clock divider
//
// Date: November 11, 2021
// Author: Shawn Hymel
// License: 0BSD

// Defines timescale for simulation: <time_unit> / <time_precision>
`timescale 1 ns / 10 ps

// Define our testbench
module tb();

    // Internal signals
    wire    out;
    wire[3:0] led;

    // Storage elements (set initial values to 0)
    reg     clk = 0;
    //reg     rst = 0;            
    reg     rst = 1;            

    // Simulation time: 10000 * 1 ns = 10 us
    //localparam DURATION = 10000;
    localparam DURATION = 2000000000;
    
    // Generate clock signal: 1 / ((2 * 41.67) * 1 ns) = 11,999,040.08 MHz
    always begin
        
        // Delay for 41.67 time units
        // 10 ps precision means that 41.667 is rounded to 41.67
        #41.667
        
        // Toggle clock line
        clk = ~clk;
    end
    
   // Instantiate the unit under test (UUT)

   //clock_divider #(.COUNT_WIDTH(4), .MAX_COUNT(6 - 1)) uut (
   //     .clk(clk),
   //     .rst(rst),
   //     .out(out)
   // );
   
   //clock_counter uut (
   //     .div_clk(clk),
   //     .rst(rst),
   //     .led(led)
   // );

   top #(.COUNT_WIDTH_TOPDEL(32), .MAX_COUNT_TOPDEL(6000000 - 1)) uut (
	.clk(clk),
	.rst_btn(rst),
	.led(led)
   );
    
    // Pulse reset line high at the beginning
    initial begin
        #1000
        rst = 1'b1;
        #1000
        rst = 1'b0;
        #1000
        rst = 1'b1;
    end
    
    // Run simulation (output to .vcd file)
    initial begin
    
        // Create simulation output file 
        $dumpfile("top_tb.vcd");
        $dumpvars(0, tb);
        
        // Wait for given amount of time for simulation to complete
        #(DURATION)
        
        // Notify and end simulation
        $display("Finished!");
        $finish;
    end
    
endmodule
