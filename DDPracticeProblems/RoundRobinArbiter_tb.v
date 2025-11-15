`timescale 1ns / 1ns
`include "RoundRobinArbiter.v"

module RoundRobinArbiter_tb;

RoundRobinArbiter arb(req, clk, state, gnt);

initial 
begin
    $dumpfile("RoundRobinArbiter_tb.vcd");
    $dumpvars(0, RoundRobinArbiter_tb);

    // Test 1: Check for correct prioritization
    

    // Test 2: Check for correct valid bit
    req = 4'b0000;
    #10;
    req = 4'b0001;
    #10;

    $display("Test Complete");
end


endmodule