// Liv Kelley, Jamie O'Brien, Sabrina Pereira
// ALU testbench

`define ADD      3'd0
`define SUB      3'd1
`define XOR_SEL  3'd2
`define SLT      3'd3
`define AND_SEL  3'd4
`define NAND     3'd5
`define NOR      3'd6
`define OR_SEL   3'd7

`timescale 1 ns / 1 ps
`include "ALU/alu.v"

module testALU();
    // Setting up input, output, and intermediary wires
    reg signed[31:0] a, b;
    reg[2:0] command;
    wire carryout, zero, overflow;
    wire signed[31:0] result;

    // Initialize ALU
    ALU dut(result,carryout,zero,overflow,a,b,command);

    initial begin
    // Setting up dump for gtkwave waveforms
    $dumpfile("alu.vcd");
    $dumpvars();

    // Set to test addition
    command = 3'b000; #1000
    $display("\nALU Addition Tests: command = b%b",command);
    $display("    a        b     |    res     cout  over  zero |res==a+b  correct flags");
    a = 32'hD0000000; b = (32'h90000000); #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a+b), (carryout==1)&(overflow==1)&(zero==0) );
    a = 32'h50000000; b = (32'hF0000000); #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a+b), (carryout==1)&(overflow==0)&(zero==0) );
    a = 32'h70000000; b = 32'h60000000; #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a+b), (carryout==0)&(overflow==1)&(zero==0) );
    a = 32'h80000000; b = 32'h60000000; #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a+b), (carryout==0)&(overflow==0)&(zero==0) );
    a = 32'h00000001; b = 32'hFFFFFFFF; #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a+b), (carryout==1)&(overflow==0)&(zero==1) );

// Set to test subtraction
    command = 3'b001; #1000
    $display("\nALU Subraction Tests: command = b%b",command);
    $display("    a        b     |    res     cout  over  zero |res==a-b  correct flags");
    a = 32'hD0000000; b = -(32'h90000000); #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a-b), (carryout==1)&(overflow==1)&(zero==0) );
    a = 32'h50000000; b = -(32'hF0000000); #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a-b), (carryout==1)&(overflow==0)&(zero==0) );
    a = 32'h70000000; b = -(32'h60000000); #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a-b), (carryout==0)&(overflow==1)&(zero==0) );
    a = 32'h80000000; b = -(32'h60000000); #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a-b), (carryout==0)&(overflow==0)&(zero==0) );
    a = 32'h00000001; b = -(32'hFFFFFFFF); #10000
    $display("%h  %h |  %h    %b     %b     %b  |    %b           %b", a,b,result,carryout,overflow,zero,  result==(a-b), (carryout==1)&(overflow==0)&(zero==1) );

    // Set to test SLT
    command = 3'b011; #10000
    $display("\nALU SLT Test: command = b%b",command);
    $display("    a        b     |    res    | res==a<b");
    //a = 32'h00000010; b = 32'h00000001; #1000
    a = 32'd5; b = 31'd6;  #10000
    $display("%h  %h | %h  |     %h ",a,b,result,result==(a<b));
    a = 32'h00000001; b = 32'h00000010; #10000
    $display("%h  %h | %h  |     %h ",a,b,result,result==(a<b));
    a = 32'h00000001; b = -(32'h00000001); #10000
    $display("%h  %h | %h  |     %h ",a,b,result,result==(a<b));
    a = -(32'h00000001); b = 32'h00000001; #10000
    $display("%h  %h | %h  |     %h ",a,b,result,result==(a<b));
    a = 32'h00000005; b = 32'h00000005; #10000
    $display("%h  %h | %h  |     %h ",a,b,result,result==(a<b));

// Set to test NAND
    command = 3'b101; #10000
    $display("\nALU Nand Test: command = b%b",command);
    $display("    a        b     |    res    | res==~(a&b)");
    a = 32'b00000000111111110000000011111111; b = 32'b00000000000000001111111111111111; #10000
    $display("%h  %h | %h  |     %h ",a,b,result,result==~(a&b));

// Set to test AND
    command = 3'b100; #10000
    $display("\nALU And Test: command = b%b",command);
    $display("    a        b     |    res    | res==a&b");
    a = 32'b00000000111111110000000011111111; b = 32'b00000000000000001111111111111111; #10000
    $display("%h  %h | %h  |     %h ",a,b,result,result==(a&b));

// Set to test XOR
    command = 3'b010; #10000
    $display("\nALU Xor Test: command = b%b",command);
    $display("    a        b     |    res    | res==a^b");
    a = 32'b00000000111111110000000011111111; b = 32'b00000000000000001111111111111111; #10000
    $display("%h  %h | %h  |     %h ",a,b,result,result==(a^b));

// Set to test NOR
    command = 3'b110; #10000
    $display("\nALU Nor Test: command = b%b",command);
    $display("    a        b     |    res    | res==~(a|b)");
    a = 32'b00000000111111110000000011111111; b = 32'b00000000000000001111111111111111; #10000
    $display("%h  %h | %h  |     %h ",a,b, result,result==~(a|b));

// Set to test OR
    command = 3'b111; #10000
    $display("\nALU Or Test: command = b%b",command);
    $display("    a        b     |    res    | res==a|b");
    a = 32'b00000000111111110000000011111111; b = 32'b00000000000000001111111111111111; #10000
    $display("%h  %h | %h  |     %h ",a,b,result,result==(a|b));

    $finish();
    end
endmodule
