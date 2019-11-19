// Jamie, Liv, Sabrina

/*----------------------------------------------------------------------------
 CPU test file - Used to produce waveform ouputs for analyzing behavior
----------------------------------------------------------------------------*/

`include "cpu.v"

module cpu_test ();

    reg clk;
    reg reset;

    // Clock generation
    initial clk=0;
    always #10 clk = !clk;

    initial reset=0;

    // Instantiate fake CPU
    cpu cpu(.clk(clk), .reset(reset));


    // Test sequence
    initial begin

      $readmemh("asmtest/branch.text", cpu.memory.mem,0);

    	// Dump waveforms to file
    	$dumpfile("cpu.vcd");
    	$dumpvars();

    	// Assert reset pulse
    	reset = 0; #20;
    	reset = 1; #10;

    	// End execution after some time delay
    	#2000 $finish();
    end

endmodule
