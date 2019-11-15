module decod(
input X,
input Y,
output reg Y0,
output reg  Y1,
output  reg Y2,
output reg Y3
);

always @(X, Y) begin

if (X == 0)
begin
Y0 <= 1;
end
else if (X == 1)
begin
Y0 <= 0;
end
end
endmodule
