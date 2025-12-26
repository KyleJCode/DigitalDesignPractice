module RoundRobinArbiter(clk, req, rst, valid, gnt);

input [2:0] req;
input clk;
input rst;

reg [1:0] state;
output reg [2:0] gnt;
output valid;

assign valid = |gnt;

always @(posedge clk) 
begin
    if(rst)
    begin
        state <= 0;
        gnt <= 0;
    end
    else
    begin

        gnt <= 3'b000; // If no requesters, no grants
        
        case(state)
            2'b00: begin
                if(req[0])
                    gnt <= 3'b001;
                else if(req[1])
                    gnt <= 3'b010;
                else if(req[2])
                    gnt <= 3'b100;
            end 
            2'b01: begin
                if(req[1])
                    gnt <= 3'b010;
                else if(req[2])
                    gnt <= 3'b100;
                else if(req[0])
                    gnt <= 3'b001;
            end
            2'b10: begin
                if(req[2])
                    gnt <= 3'b100;
                else if(req[0])
                    gnt <= 3'b001;
                else if(req[1])
                    gnt <= 3'b010;   
            end
        endcase

        if(valid) 
        begin
            if(state == 2'b00)
                state <= 2'b01;
            else if(state == 2'b01)
                state <= 2'b10;
            else 
                state <= 2'b00;
        end
    end
end


endmodule