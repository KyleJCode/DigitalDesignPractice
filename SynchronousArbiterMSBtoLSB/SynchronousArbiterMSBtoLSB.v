module SynchronousArbiterMSBtoLSB(clk, req, gnt);

input clk;
input [2:0] req;
output reg [2:0] gnt;
output reg valid;

always @(posedge clk)
begin 
    gnt[2] <= req[2];
    gnt[1] <= ~req[2] & req[1];
    gnt[0] <= ~(|req[2:1]) & req[0];
    valid <= |req;
end

endmodule