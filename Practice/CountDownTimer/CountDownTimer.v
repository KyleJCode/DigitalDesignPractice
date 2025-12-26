module counter (in, latch, dec, clock, zero);

input clock;
input[3:0] in;
input latch;
input dec;

output zero;

reg[3:0] value;
wire zero;

always @(posedge clock)
    begin
        if(latch)
            value <= in;
        else if(dec && !zero) 
            value <= value - 1'b1; 
    end

assign zero = (value == 4'b0);

endmodule