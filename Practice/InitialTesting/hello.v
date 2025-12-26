module hello(A, C, B);

    input A;
    input C;
    output B;
    assign B = A | C;
endmodule