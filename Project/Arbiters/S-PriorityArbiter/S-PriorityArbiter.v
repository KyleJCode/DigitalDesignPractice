module PriorityArbiter(clk, req, rst, prios, gnt, valid); // Uses round-robin for tie breaker scenarios. Prevents process starvation. 

input clk;
input [2:0] req;
input [8:0] prios; // Source0 = prios[2:0], Source1 = prios[5:3], Source2 = prios[8:6]
input rst;

wire [2:0] p0 = prios[2:0];
wire [2:0] p1 = prios[5:3];
wire [2:0] p2 = prios[8:6];

// Priority and Tie Calculation
wire [2:0] highest_prio = req[0] && (!req[1] || p0 >= p1) && (!req[2] || p0 >= p2) ? p0 :
                          req[1] && (!req[2] || p1 >= p2) ? p1 : p2;

wire [2:0] ties = {req[2] && (p2 == highest_prio),
                   req[1] && (p1 == highest_prio),
                   req[0] && (p0 == highest_prio)};

reg [1:0] state;
output reg [2:0] gnt;
output valid;

assign valid = |gnt;

always @(posedge clk)
begin
    if(rst)
    begin
        gnt <= 0;
        state <= 0;
    end
    else
    begin

        gnt <= 0;
        
        case(ties)
        3'b011: // req 0/1 tie
        begin
            // see if this works too: gnt <= (state == 2'b00 || state == 2'b10) ? 3'b001 : 3'b010; 
            if(state == 2'b00 || state == 2'b10)
                gnt <= 3'b001;
            else
                gnt <= 3'b010;
        end
        3'b110: // req 1/2 tie
        begin
            if(state == 2'b00 || state == 2'b10)
                gnt <= 3'b100;
            else
                gnt <= 3'b010;
        end
        3'b101: // req 0/2 tie
        begin
            if(state == 2'b00 || state == 2'b10)
                gnt <= 3'b001;
            else
                gnt <= 3'b100;
        end
        3'b111: // req 2/1/0 tie
        begin
            if(state == 2'b00)
                gnt <= 3'b001;
            else if(state == 2'b01)
                gnt <= 3'b010;
            else
                gnt <= 3'b100;
        end
        default:  
        begin
            gnt[0] <= ties[0];
            gnt[1] <= ties[1];
            gnt[2] <= ties[2];
        end
        endcase               

        // State changes
        if(valid)
        begin
            if(state == 2'b00)
                state <= 2'b01;
            else if(state == 2'b01)
                state <= 2'b10;
            else if(state == 2'b10)
                state <= 2'b11;
            else
                state <= 2'b00;  
    
        end  
    end 
end


endmodule