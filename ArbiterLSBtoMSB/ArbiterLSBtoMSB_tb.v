`timescale 1ns / 1ns
`include "ArbiterLSBtoMSB.v"

module ArbiterLSBtoMSB_tb;

reg [3:0] req;
wire [3:0] gnt;
wire valid;

ArbiterLSBtoMSB arb(req, gnt, valid);

initial 
begin
    $dumpfile("ArbiterLSBtoMSB_tb.vcd");
    $dumpvars(0, ArbiterLSBtoMSB_tb);

    // Test 1: Check for correct prioritization
    req = 4'b1000;
    #10;
    req = 4'b1110;
    #10;
    req = 4'b0011;
    #10;
    req = 4'b0001;
    #10;

    // Test 2: Check for correct valid bit
    req = 4'b0000;
    #10;
    req = 4'b0001;
    #10;

    $display("Test Complete");
end


endmodule