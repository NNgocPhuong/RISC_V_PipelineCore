module Memory_Cycle_tb();

    reg clk, rst, RegWriteM, MemWriteM, ResultSrcM;
    reg [4:0] RD_M;
    reg [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
    wire RegWriteW, ResultSrcW;
    wire [4:0] RD_W;
    wire [31:0] PCPlus4W, ALU_ResultW, ReadDataW;

    // Instantiate the Memory Cycle module
    memory_cycle uut (
        .clk(clk),
        .rst(rst),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RD_M(RD_M),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .RD_W(RD_W),
        .PCPlus4W(PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        RegWriteM = 1;
        MemWriteM = 0;
        ResultSrcM = 0;
        RD_M = 5'b00001;
        PCPlus4M = 32'h00000004;
        WriteDataM = 32'h00000010;
        ALU_ResultM = 32'h00000020;

        // Apply reset
        rst = 0;
        #10;
        rst = 1;

        // Test memory access
        #20;
        MemWriteM = 1;

        // End simulation
        #50;
        $finish;
    end

endmodule