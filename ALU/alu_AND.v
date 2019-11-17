// AND circuit
// define gates with delays

`define AND and 

module structuralAND
(
    output result,
    input A,
    input B
);

    `AND andgate(result, A, B);

endmodule

module AND32
(
    output[31:0] results,
    input[31:0] a,
    input[31:0] b
);
    generate
    genvar index;
      for (index = 0; index<32;index = index + 1)
      begin:genblock
        structuralAND andindex(results[index], a[index], b[index]);
      end
    endgenerate
endmodule
