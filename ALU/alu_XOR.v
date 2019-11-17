// XOR circuit
// define gates with delays

`define XOR xor 

module structuralXOR
(
    output result,
    input a, 
    input b 
);

    `XOR xorgate(result, a, b);
    
endmodule

module XOR32
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
        structuralXOR xorindex(result[index], a[index], b[index]);  
      end
    endgenerate
endmodule
   
