module ArbiterPriority(req, prio0, prio1, prio2, gnt, valid); // 3 requesters, 4 levels of priority

// Assume prio0/1/2 correspond directly to requesters 0/1/2. 
input [1:0] prio0;
input [1:0] prio1;
input [1:0] prio2;
// Alternatively make a single input called input [5:0] prios and assign 2 bits 
// each to the assigned priority of the different request lines
input [2:0] req;

output reg [2:0] gnt;
output reg valid;

always @(*) begin
if(req[2] && (~req[1] || (prio2 >= prio1)) && (~req[0] || (prio2 >= prio0)))
        gnt = 3'b100;
    else if(req[1] && (~req[2] || (prio1 > prio2)) && (~req[0] || (prio1 >= prio0)))
        gnt = 3'b010;
    else if(req[0] && (~req[1] || (prio0 > prio1)) && (~req[2] || (prio0 > prio2)))
        gnt = 3'b001;
    else
        gnt = 3'b000;

    valid = |gnt;
end

endmodule