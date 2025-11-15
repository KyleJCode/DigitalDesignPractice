module ArbiterLSBtoMSB(req, gnt, valid);

input[3:0] req;

output[3:0] gnt;
output valid;

assign gnt[0] = req[0];
assign gnt[1] = req[1] & ~req[0];
assign gnt[2] = req[2] & ~req[1] & ~req[0];
assign gnt[3] = req[3] & ~req[2] & ~req[1] & ~req[0];
// Alternatively can be written: assign gnt[3] = req[3] & ~(|req[2:0]) 

assign valid = |gnt;

endmodule 