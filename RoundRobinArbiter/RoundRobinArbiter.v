module RoundRobinArbiter(req, clk, state, gnt);

input [2:0] req;
input clk;

output reg [1:0] state;
output reg [2:0] gnt;

initial state = 2'b00;

always @(posedge clk) begin
  if (state == 2'b00)
    state <= 2'b01;
  else if (state == 2'b01)
    state <= 2'b10;
  else
    state <= 2'b00;
end


always @(*)
    begin
        gnt = 3'b000;
        if(state == 2'b00)
        begin
            if(req[0])
                gnt = 3'b001;
            else if(req[1])
                gnt = 3'b010;
            else if(req[2])
                gnt = 3'b100;
        end
        else if(state == 2'b01)
        begin
            if(req[1])
                gnt = 3'b010;
            else if(req[2])
                gnt = 3'b100;
            else if(req[0])
                gnt = 3'b001;
        end
        else // (state == 2'b10)
        begin
            if(req[2])
                gnt = 3'b100;
            else if(req[0])
                gnt = 3'b001;
            else if(req[1])
                gnt = 3'b010;    
        end
    end

endmodule