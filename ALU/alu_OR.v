// OR circuit
// define gates with delays

`define OR or 

module structuralOR
(
    output result,
    input a, 
    input b 
);

    `OR orgate(result, a, b);
    
endmodule

module OR32
(

    output[31:0] result,
    input[31:0] a, 
    input[31:0] b     
);
    generate
    genvar index;
      for (index = 0; index<32; index = index + 1)
      begin:genblock
       structuralOR orindex(result[index], a[index], b[index]);  
      end
    endgenerate
endmodule 
