// Liv Kelley, Jamie O'Brien, Sabrina Pereira
// Single Cycle CPU Register


/*-----------------------------------------------------------------------------
32 bit Parameterized Register

This register is used to hold the value of the counter and the incremental
sum. The width parameter can be changed when instantiating the module to change
the size of the data being stored.
-----------------------------------------------------------------------------*/
module register
#(parameter width = 4)
(
output reg[width-1:0] q, // 4 bit output
input[width-1:0]      d, // 4 bit input
input                 wrenable,
input                 clk
);
    always @(posedge clk) begin
        if(wrenable) begin
            //q[31:0] <= d[31:0];
            q <= d;
        end
    end
endmodule



// 32 bit register output 0
module register32zero
(
output[31:0]     q,
input[31:0]      d,
input            wrenable,
input            clk
);
    assign q[31:0] = 32'b0;
endmodule
