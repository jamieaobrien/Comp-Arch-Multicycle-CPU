// Liv Kelley, Sabrina Pereira, and Jamie O'Brien
// Multiplexer circuit



/*
8:1 Multiplexer

The multiplexer takes in the outputs from all of the modules, as well as the
ALUindex from the LUT, and the ifslt control line from the LUT. The ALUindex's
three bits become the three select lines used to choose between seven arithmetic
circuits. It's seven because the subtraction module is also used for addition.
AND gates are used to select the appropriate module result according to the
ALUindex. The outputs of the AND gates go through an OR gate to  get the final
result of the ALU module.
*/
module structuralMultiplexer
(
    output[31:0] result,
    input[2:0] ALUindex,
    input[31:0] difference,slt_result,XORresult,ANDresult,NANDresult,NORresult,ORresult,//, etc.
    input ifslt
);
    // Your multiplexer code here

    wire a0inv;
    wire a1inv;
    wire a2inv;
    wire nslt;
    wire[31:0] out0;
    wire[31:0] out1;
    wire[31:0] out2;
    wire[31:0] out3;
    wire[31:0] out4;
    wire[31:0] out5;
    wire[31:0] out6;
    `NOT ifsltinv(nslt,ifslt);
    `NOT address0inv(a0inv, ALUindex[0]);       // inverter named address0inv, produces a0inv, inverse of ALUindex[0]
    `NOT address1inv(a1inv, ALUindex[1]);	      // inverter named address1inv, produces a1inv, inverse of ALUindex[1]
    `NOT address2inv(a2inv, ALUindex[2]);       // inverter named address2inv, produces a2inv, inverse of ALUindex[2]
    generate
    genvar index;
      for (index = 0;
      index<32;
      index = index + 1)
      begin
        and andgate0(out0[index],a0inv,a1inv,a2inv,difference[index],nslt);
        and andgate1(out1[index],ALUindex[0],a1inv,slt_result[index],ifslt);
        and andgate2(out2[index],a0inv,ALUindex[1],a2inv,XORresult[index],nslt);
        and andgate3(out3[index],ALUindex[0],ALUindex[1],a2inv,ANDresult[index],nslt);
        and andgate4(out4[index],a0inv,a1inv,ALUindex[2],NANDresult[index],nslt);
        and andgate5(out5[index],ALUindex[0],a1inv,ALUindex[2],NORresult[index],nslt);
        and andgate6(out6[index],a0inv,ALUindex[1],ALUindex[2],ORresult[index],nslt);
        or orgate(result[index],out0[index],out1[index],out2[index],out3[index],out4[index],out5[index],out6[index]);
      end
    endgenerate

endmodule
