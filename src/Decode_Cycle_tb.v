module Decode_Cycle_tb();

    reg clk, rst, RegWriteW;
    reg [4:0] RDW;
    reg [31:0] InstrD, PCD, PCPlus4D, ResultW;
    wire RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    wire [2:0] ALUControlE;
    wire [31:0] RD1_E, RD2_E, Imm_Ext_E;
    wire [4:0] RS1_E, RS2_E, RD_E;
    wire [31:0] PCE, PCPlus4E;

    // Instantiate the Decode Cycle module
    decode_cycle uut (
        .clk(clk),
        .rst(rst),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .RegWriteW(RegWriteW),
        .RDW(RDW),
        .ResultW(ResultW),
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
        .RS1_E(RS1_E),
        .RS2_E(RS2_E)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        RegWriteW = 0;
        RDW = 5'b00001;
        InstrD = 32'h00000013; // Example instruction
        PCD = 32'h00000000;
        PCPlus4D = 32'h00000004;
        ResultW = 32'h00000010;

        // Apply reset
        rst = 0;
        #10;
        rst = 1;

        // Test decode logic
        #20;
        RegWriteW = 1;

        // End simulation
        #50;
        $finish;
    end

endmodule