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

      // $readmemh("spin.dat", cpu.memory.mem,0);
      $readmemh("asmtest/test2.text", cpu.memory.mem,0);


    	// Dump waveforms to file
    	// Note: arrays (e.g. memory) are not dumped by default
    	$dumpfile("cpu.vcd");
    	$dumpvars();

    	// Assert reset pulse
    	reset = 0; #20;
    	reset = 1; #10;

    	// Display a few cycles just for quick checking
    	// Note: I'm just dumping instruction bits, but you can do some
    	// self-checking test cases based on your CPU and program and
    	// automatically report the results.

    	// $display("Time | PC       | Instruction");
    	// repeat(3) begin
      //       $display("%4t | %h | %h", $time, cpu.PC_A, cpu.INS_A); #20 ;
      //       end
    	// $display("... more execution (see waveform)");

    	// End execution after some time delay - adjust to match your program
    	// or use a smarter approach like looking for an exit syscall or the
    	// PC to be the value of the last instruction in your program.
    	#2000 $finish();
    end

endmodule
