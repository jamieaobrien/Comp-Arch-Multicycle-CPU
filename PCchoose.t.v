`include "PCchoose.v"

module chooseTest();
reg clk;
reg [31:0] PC4;
reg bne;
reg beq;
reg [31:0] branchAddr;
reg [31:0] jumpAddr;
reg zero;
reg jump;
reg reset;
wire [31:0] PC;

// Instantiate PC module
PCchoose dut(.clk(clk),.PC4(PC4),.bne(bne),.beq(beq),.branchAddr(branchAddr),.jumpAddr(jumpAddr),.zero(zero),.jump(jump),.reset(reset),.PC(PC));

initial begin
$display("PC Test");
$display("zero  reset | bne  beq  jump  |   currentPC   branchAddr   jumpAddr     newPC     | correct");
clk=0; PC4=32'd8; branchAddr=32'b1; jumpAddr=32'd2; zero=1'b0;jump=0; reset=1; bne=0; beq=0; #5 clk=1; #10000
$display(" %b      %b   |  %b    %b     %b   |   %h     %h    %h    %h   |    %b",
zero, reset, bne, beq, jump, PC4,branchAddr,jumpAddr, PC, (PC==PC4));
clk=0; PC4=32'd8; branchAddr=32'd16; jumpAddr=32'd2; zero=1'b0;jump=0; reset=1; bne=1; beq=0; #5 clk=1; #10000
$display(" %b      %b   |  %b    %b     %b   |   %h     %h    %h    %h   |    %b",
zero, reset, bne, beq, jump, PC4,branchAddr,jumpAddr, PC, (PC==branchAddr));
clk=0; PC4=32'd4; branchAddr=32'b1; jumpAddr=32'd20; zero=1'b0;jump=1; reset=1; bne=0; beq=0; #5 clk=1; #10000
$display(" %b      %b   |  %b    %b     %b   |   %h     %h    %h    %h   |    %b",
zero, reset, bne, beq, jump, PC4,branchAddr,jumpAddr, PC, (PC==jumpAddr));
clk=0; PC4=32'd4; branchAddr=32'd32; jumpAddr=32'd2; zero=1'b1;jump=0; reset=1; bne=0; beq=1; #5 clk=1; #10000
$display(" %b      %b   |  %b    %b     %b   |   %h     %h    %h    %h   |    %b",
zero, reset, bne, beq, jump, PC4,branchAddr,jumpAddr, PC, (PC==branchAddr));
clk=0; PC4=32'd4; branchAddr=32'd32; jumpAddr=32'd2; zero=1'b1;jump=0; reset=0; bne=0; beq=0; #5 clk=1; #10000
$display(" %b      %b   |  %b    %b     %b   |   %h     %h    %h    %h   |    %b   ",
zero, reset, bne, beq, jump, PC4,branchAddr,jumpAddr, PC, (PC==0));
clk=0; PC4=32'd4; branchAddr=32'd32; jumpAddr=32'd2; zero=1'b1;jump=0; reset=0; bne=1; beq=0; #5 clk=1; #10000
$display(" %b      %b   |  %b    %b     %b   |   %h     %h    %h    %h   |    %b   ",
zero, reset, bne, beq, jump, PC4,branchAddr,jumpAddr, PC, (PC==0));
clk=0; PC4=32'd4; branchAddr=32'd32; jumpAddr=32'd2; zero=1'b1;jump=1; reset=0; bne=0; beq=0; #5 clk=1; #10000
$display(" %b      %b   |  %b    %b     %b   |   %h     %h    %h    %h   |    %b   ",
zero, reset, bne, beq, jump, PC4,branchAddr,jumpAddr, PC, (PC==0));




end
endmodule
