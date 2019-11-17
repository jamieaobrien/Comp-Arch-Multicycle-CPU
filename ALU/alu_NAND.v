// NAND circuit
// define gates with delays

`define NAND nand

module structuralNAND
(
    output result,
    input A,
    input B
);

    `NAND nandgate(result, A, B);

endmodule

module NAND32
(
    output[31:0] result,
    input[31:0] A,
    input[31:0] B
);
    generate
    genvar index;
      for (index = 0; index<32;index = index + 1)
      begin:genblock
        structuralNAND nandindex(result[index], A[index], B[index]);
      end
    endgenerate
endmodule
