module Fetch_Cycle_tb();

    reg clk, rst, PCSrcE;
    reg [31:0] PCTargetE;
    wire [31:0] InstrD, PCD, PCPlus4D;

    // Instantiate the Fetch Cycle module
    fetch_cycle uut (
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        PCSrcE = 0;
        PCTargetE = 32'h00000010;

        // Apply reset
        rst = 0;
        #10;
        rst = 1;

        // Test PC + 4
        #20;
        PCSrcE = 0;

        // Test branch target
        #20;
        PCSrcE = 1;

        // End simulation
        #50;
        $finish;
    end

endmodule