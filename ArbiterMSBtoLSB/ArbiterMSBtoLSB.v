module ArbiterMSBtoLSB(req, gnt, valid);

input [2:0] req;

output [2:0] gnt;
output valid;

assign gnt[2] = req[2];
assign gnt[1] = ~req[2] & req[1];
assign gnt[0] = ~req[2] & ~req[1] & req[0];
// Alternatively can be written: assign gnt[0] = ~(|req[2:1]) & req[0];

assign valid = |gnt;

endmodule