module Execute_Cycle_tb();

    reg clk, rst, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    reg [2:0] ALUControlE;
    reg [31:0] RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E, ResultW;
    reg [4:0] RD_E;
    reg [1:0] ForwardA_E, ForwardB_E;
    wire PCSrcE, RegWriteM, MemWriteM, ResultSrcM;
    wire [4:0] RD_M;
    wire [31:0] PCPlus4M, WriteDataM, ALU_ResultM, PCTargetE;

    // Instantiate the Execute Cycle module
    execute_cycle uut (
        .clk(clk),
        .rst(rst),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RD_M(RD_M),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .ResultW(ResultW),
        .ForwardA_E(ForwardA_E),
        .ForwardB_E(ForwardB_E)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        RegWriteE = 1;
        ALUSrcE = 0;
        MemWriteE = 0;
        ResultSrcE = 0;
        BranchE = 0;
        ALUControlE = 3'b010; // Example ALU operation
        RD1_E = 32'h00000010;
        RD2_E = 32'h00000020;
        Imm_Ext_E = 32'h00000004;
        RD_E = 5'b00001;
        PCE = 32'h00000000;
        PCPlus4E = 32'h00000004;
        ResultW = 32'h00000030;
        ForwardA_E = 2'b00;
        ForwardB_E = 2'b00;

        // Apply reset
        rst = 0;
        #10;
        rst = 1;

        // Test ALU operation
        #20;
        ALUSrcE = 1;

        // End simulation
        #50;
        $finish;
    end

endmodule