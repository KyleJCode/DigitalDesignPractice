`timescale 1ns / 1ns
`include "CountDownTimer.v"

module counter_tb;

reg[3:0] in;
reg dec;
reg clock;
reg latch;
wire zero;

counter uut(in, latch, dec, clock, zero);


initial clock = 0;

initial begin
    $dumpfile("counter_tb.vcd");
    $dumpvars(0, counter_tb);

    in[0] = 1;
    in[1] = 1;
    in[2] = 1;
    in[3] = 1;
    latch = 1;
    clock = 1;
    #20;

    latch = 0;
    dec = 1;
    clock = 1;
    #20;
    
    clock = 1;
    #20;

    dec = 0;
    clock = 0;
    #20;



 
    $display("Test Complete");

end


endmodule