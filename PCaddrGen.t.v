`include "PCaddrGen.v"

module test_PCaddrGen();

wire [31:0]   PC4;
wire [31:0]   branchAddress;
wire [31:0]   jumpAddress;
reg  [25:0]   address;
reg  [15:0]   immediate;
reg  [5:0]    opcode;
reg  [31:0]   R_rs;
reg  [31:0]   PC;
reg           clk;


// Instantiate PC module
PCaddrGen PCaddrGen(.PC4(PC4),.branchAddress(branchAddress),.jumpAddress(jumpAddress),.address(address),.immediate(immediate),.opcode(opcode),.R_rs(R_rs),.PC(PC),.clk(clk));
initial clk=0;
always #10 clk = !clk;

initial begin

$display("PC Address Generator Test");
$display(" address  immediate  opcode   R_rs       PC    |   PC4     branchAddress  jumpAddress");

// Check jump address when R type instruction
@(negedge clk);   // Wait for negedge of clock before proceeding
  address=26'h3; immediate=32'h3; opcode=6'b0; R_rs=32'd5; PC=32'd0;
@(posedge clk); #1   // Wait for just after posedge to inspect results
$display(" %h     %h      %h   %h  %h | %h     %h     %h   ",address,immediate,opcode,R_rs,PC,PC4,branchAddress,jumpAddress);

// Check jump address when not R type instruction
@(negedge clk);   // Wait for negedge of clock before proceeding
  address=26'h3; immediate=32'h3; opcode=6'h2; R_rs=32'd5; PC=32'd0;
@(posedge clk); #1   // Wait for just after posedge to inspect results
$display(" %h     %h      %h   %h  %h | %h     %h     %h   ",address,immediate,opcode,R_rs,PC,PC4,branchAddress,jumpAddress);

#20 $finish();  // End the simulation (otherwise the clock will keep running forever)

end
endmodule
