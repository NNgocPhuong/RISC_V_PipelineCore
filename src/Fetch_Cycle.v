module fetch_cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);

    // Declare input & outputs
    input clk, rst;                // Tín hiệu clock và reset.
    input PCSrcE;                  // Tín hiệu chọn nguồn địa chỉ PC (PC + 4 hoặc PCTargetE).
    input [31:0] PCTargetE;        // Địa chỉ mục tiêu (target address) từ giai đoạn EXE.
    output [31:0] InstrD;          // Lệnh được lấy từ bộ nhớ (đầu ra).
    output [31:0] PCD, PCPlus4D;   // Giá trị PC và PC + 4 được truyền sang giai đoạn Decode.

    // Declaring interim wires
    wire [31:0] PC_F, PCF, PCPlus4F;  // Các tín hiệu liên quan đến PC.
    wire [31:0] InstrF;               // Lệnh được đọc từ bộ nhớ lệnh.

    // Declaration of Register
    reg [31:0] InstrF_reg;            // Thanh ghi lưu lệnh.
    reg [31:0] PCF_reg, PCPlus4F_reg; // Thanh ghi lưu giá trị PC và PC + 4.


    // Initiation of Modules
    // Declare PC Mux
    // Chọn giữa PC + 4 và PCTargetE dựa trên tín hiệu PCSrcE.
    // Nếu reset (rst = 0), giá trị sẽ là 0.
    Mux PC_MUX (.a(PCPlus4F),
                .b(PCTargetE), 
                .s(PCSrcE), 
                .c(PC_F)
                );

    // Declare PC Counter
    // Lưu trữ giá trị PC hiện tại và cập nhật nó theo tín hiệu clock.
    PC_Module Program_Counter (
                .clk(clk),
                .rst(rst),
                .PC(PCF),
                .PC_Next(PC_F)
                );

    // Declare Instruction Memory
    // Lấy lệnh từ bộ nhớ theo địa chỉ PC.
    // Nếu reset (rst = 0), lệnh sẽ là 0.
    Instruction_Memory IMEM (
                .rst(rst),
                .A(PCF),
                .RD(InstrF)
                );

    // Declare PC adder
    // Tính toán giá trị PC + 4 để sử dụng trong giai đoạn tiếp theo.
    // Nếu reset (rst = 0), giá trị sẽ là 0.
    PC_Adder PC_adder (
                .a(PCF),
                .b(32'h00000004),
                .c(PCPlus4F)
                );

    // Fetch Cycle Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end
        else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end


    // Assigning Registers Value to the Output port
    assign  InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
    assign  PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
    assign  PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;


endmodule
