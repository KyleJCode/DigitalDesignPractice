module SynchronousFIFO(clk, rd_en, wr_en, reset, in, out, full, empty);

localparam NUM_ENTRIES = 128;
localparam ENTRY_WIDTH = 64;

input clk;
input rd_en;
input wr_en;
input reset;

input [ENTRY_WIDTH-1:0] in;
reg [ENTRY_WIDTH-1:0] mem_FIFO [0:NUM_ENTRIES-1]; // Entries 64-bits wide with 128 entries
output reg [ENTRY_WIDTH-1:0] out;
reg [7:0] count; // 8 bits because 0-128 can be represented

// 7 bits because 2^7 = 128 entries (pointers act as counters in verilog)
reg [6:0] wptr;
reg [6:0] rptr;

output full;
output empty;

assign empty = (count == 0);
assign full = (count == NUM_ENTRIES);

always @(posedge clk)
begin
    if(reset) 
    begin
        wptr <= 0;
        rptr <= 0;
        count <= 0;
        out <= 0;
    end
    else
    begin
        if(wr_en && !full) 
        begin
            mem_FIFO[wptr] <= in;
            wptr <= wptr + 1;
        end
    
        if(rd_en && !empty)
        begin
            out <= mem_FIFO[rptr];
            rptr <= rptr + 1;
        end

        case({(wr_en && !full), (rd_en && !empty)})
            2'b10: count <= count + 1;
            2'b01: count <= count - 1;
            default: count <= count;
        endcase
    end
end
endmodule