
`include "decoder.v"

module decoderTest();
    wire [4:0]  rs, rt, rd;
    wire [15:0] immediate;
    wire [25:0] address;
    wire [5:0]  opcode;
    wire [5:0]  funct;
    reg [31:0]  instruction;

    reg [5:0] testopcode;
    reg [4:0] testrs;
    reg [4:0] testrt;
    reg [4:0] testrd;
    reg [5:0] testfunct;
    reg [15:0] testimmediate;
    reg [25:0] testaddress;


decoder dut(.rs(rs),
            .rt(rt),
            .rd(rd),
            .immediate(immediate),
            .address(address),
            .opcode(opcode),
            .funct(funct),
            .instruction(instruction));


initial begin
$display("                                                                                                                        ");
$display("decoder test");
$display("                                                                                                                        ");
$display("           instruction            |  opcode | rs |  rt | rd | test funct |");
instruction = 32'b00000011111000001111100000111111; testopcode = 6'b000000; testrs = 5'b11111; testrt = 5'b00000; testrd = 5'b11111; testfunct = 6'b111111; #100000
$display(" %b |    %b    | %b  |  %b  |  %b |     %b      |", instruction, opcode == testopcode, rs == testrs, rt == testrt, rd == testrd, funct == testfunct);
$display("                                                                                                                        ");
$display("           instruction            | opcode |  rs  | test rt | test immediate |");
instruction = 32'b00000011111000001111111111111111; testopcode = 6'b000000; testrs = 5'b11111; testrt = 5'b00000; testimmediate = 16'b1111111111111111; #100000
$display(" %b |    %b   |   %b  |    %b    |       %b        |", instruction, opcode == testopcode, rs == testrs, rt == testrt, immediate == testimmediate);
$display("                                                                                                                        ");
$display("           instruction            | test opcode | test address |");
instruction = 32'b00000011111111111111111111111111; testopcode = 6'b00000; testaddress = 26'b11111111111111111111111111; #100000
$display(" %b |      %b      |       %b      |", instruction, opcode == testopcode, address == testaddress);
$display("                                                                                                                        ");
end
endmodule
