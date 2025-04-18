module Execute_Cycle_tb();
    // Khai báo tín hiệu test
    reg clk, rst;
    reg RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    reg [2:0] ALUControlE;
    reg [31:0] RD1_E, RD2_E, Imm_Ext_E;
    reg [4:0] RD_E;
    reg [31:0] PCE, PCPlus4E;
    reg [31:0] ResultW;
    reg [1:0] ForwardA_E, ForwardB_E;

    // Khai báo output
    wire PCSrcE, RegWriteM, MemWriteM, ResultSrcM;
    wire [4:0] RD_M;
    wire [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
    wire [31:0] PCTargetE;

    // Khởi tạo DUT (Device Under Test)
    execute_cycle dut (
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

    // Tạo xung clock
    always #5 clk = ~clk;

    // Test vectors
    initial begin
        // Khởi tạo file dump cho GTKWave
        $dumpfile("execute_cycle_tb.vcd");
        $dumpvars(0, Execute_Cycle_tb);
        
        // Khởi tạo giá trị ban đầu
        clk = 0;
        rst = 0;
        RegWriteE = 0;
        ALUSrcE = 0;
        MemWriteE = 0;
        ResultSrcE = 0;
        BranchE = 0;
        ALUControlE = 3'b000;
        RD1_E = 32'h0;
        RD2_E = 32'h0;
        Imm_Ext_E = 32'h0;
        RD_E = 5'h0;
        PCE = 32'h0;
        PCPlus4E = 32'h0;
        ResultW = 32'h0;
        ForwardA_E = 2'b00;
        ForwardB_E = 2'b00;

        // Đợi 10ns và giải phóng reset
        #10 rst = 1;

        // Test case 1: Phép cộng cơ bản
        #10;
        RD1_E = 32'h00000005;    // Số thứ nhất: 5
        RD2_E = 32'h00000003;    // Số thứ hai: 3
        ALUControlE = 3'b000;    // Phép cộng
        ALUSrcE = 0;             // Sử dụng RD2_E
        RegWriteE = 1;           // Cho phép ghi vào register
        
        // Test case 2: Phép cộng với immediate
        #10;
        RD1_E = 32'h00000005;    // Số thứ nhất: 5
        Imm_Ext_E = 32'h00000003; // Immediate: 3
        ALUControlE = 3'b000;    // Phép cộng
        ALUSrcE = 1;             // Sử dụng immediate
        
        // Test case 3: Kiểm tra forwarding
        #10;
        ForwardA_E = 2'b10;      // Forward từ Memory stage
        RD1_E = 32'h00000008;    // Giá trị gốc
        RD2_E = 32'h00000002;    // Số thứ hai
        ResultW = 32'h0000000A;  // Giá trị forward từ WriteBack
        ALUSrcE = 0;             // Sử dụng RD2_E
        
        // Test case 4: Kiểm tra branch
        #10;
        ForwardA_E = 2'b00;      // Tắt forwarding
        RD1_E = 32'h00000005;
        RD2_E = 32'h00000005;    // Giá trị bằng nhau
        BranchE = 1;             // Kích hoạt branch
        ALUControlE = 3'b001;    // So sánh bằng
        PCE = 32'h00000100;      // PC hiện tại
        Imm_Ext_E = 32'h00000010; // Offset

        // Test case 5: Kiểm tra AND operation
        #10;
        BranchE = 0;
        ALUControlE = 3'b010;    // AND operation
        RD1_E = 32'hF0F0F0F0;
        RD2_E = 32'hFF00FF00;
        ALUSrcE = 0;

        // Test case 6: Kiểm tra OR operation
        #10;
        ALUControlE = 3'b011;    // OR operation
        RD1_E = 32'hF0F0F0F0;
        RD2_E = 32'h0F0F0F0F;
        ALUSrcE = 0;

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time=%0t rst=%b ALUControlE=%b RD1_E=%h RD2_E=%h ALU_ResultM=%h PCSrcE=%b",
                 $time, rst, ALUControlE, RD1_E, RD2_E, ALU_ResultM, PCSrcE);
    end

endmodule