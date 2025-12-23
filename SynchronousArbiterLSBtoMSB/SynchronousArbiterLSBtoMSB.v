module SynchronousArbiterLSBtoMSB(clk, req, gnt);

input clk;
input [2:0] req;
output reg [2:0] gnt;
output reg valid;

always @(posedge clk)
begin 
    gnt[0] <= req[0];
    gnt[1] <= req[1] & ~req[0];
    gnt[2] <= req[2] & ~(|req[1:0]);
    valid <= |req;
end

endmodule