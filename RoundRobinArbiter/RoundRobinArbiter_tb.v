`timescale 1ns / 1ns
`include "RoundRobinArbiter.v"

module RoundRobinArbiter_tb;
    reg clk = 0;
    parameter CLK_PERIOD = 20;
    always #(CLK_PERIOD/2) clk=~clk; 

    reg [2:0] req;
    wire [1:0] state;
    wire [2:0] gnt;

RoundRobinArbiter dut(req, clk, state, gnt);

initial 
begin
    $dumpfile("RoundRobinArbiter_tb.vcd");
    $dumpvars(0, RoundRobinArbiter_tb);
end

initial 
begin
    req = 3'b000;
    repeat (2) @(posedge clk);

    // Scenario 1: All lines requesting, rotate 0 -> 1 -> 2 ...
    req = 3'b111;
    repeat (6) @(posedge clk);

    // Scenario 2: 2 requesters, grant depends on turn/proximity to turn
    req = 3'b101;
    repeat (6) @(posedge clk);

    // Scenario 3: No request lines open, no grants
    req = 3'b000;
    repeat (3) @(posedge clk);

    // Scenario 4: One request line open, always gets grant when its turn comes
    req = 3'b010;
    repeat (4) @(posedge clk);

    $display("Testbench Complete");
    $finish;

end
endmodule