module Writeback_Cycle_tb();

    reg clk, rst, ResultSrcW;
    reg [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
    wire [31:0] ResultW;

    // Instantiate the Write Back Cycle module
    writeback_cycle uut (
        .clk(clk),
        .rst(rst),
        .ResultSrcW(ResultSrcW),
        .PCPlus4W(PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW),
        .ResultW(ResultW)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        ResultSrcW = 0;
        PCPlus4W = 32'h00000004;
        ALU_ResultW = 32'h00000010;
        ReadDataW = 32'h00000020;

        // Apply reset
        rst = 0;
        #10;
        rst = 1;

        // Test write back logic
        #20;
        ResultSrcW = 1;

        // End simulation
        #50;
        $finish;
    end

endmodule