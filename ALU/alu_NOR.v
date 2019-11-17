// NOR circuit
// define gates with delays

`define NOR nor 

module structuralNOR
(
    output result,
    input a, 
    input b
);

    `NOR norgate(result, a, b);
    
endmodule

module NOR32
(
    output[31:0] result,
    input[31:0] a, 
    input[31:0] b  
);
    generate
    genvar index;
      for (index = 0;
      index<32;
      index = index + 1)
      begin:genblock
        structuralNOR norindex(result[index], a[index], b[index]);  
      end
    endgenerate
endmodule
