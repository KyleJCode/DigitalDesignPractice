`timescale 1ns / 1ns
`include "hello.v"

module hello_tb;

reg A;
reg C;
wire B;

hello uut(A, C, B);

initial begin
    $dumpfile("hello_tb.vcd");
    $dumpvars(0, hello_tb);

    A = 0;
    C = 0;
    #20;

    A = 0;
    C = 1;
    #20;

    A = 1;
    C = 0;
    #20;

    A = 1;
    C = 1;
    #20;

    $display("Test Complete");

end


endmodule