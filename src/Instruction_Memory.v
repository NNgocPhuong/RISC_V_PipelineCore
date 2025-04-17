module Instruction_Memory(rst,A,RD);

  input rst;               // Tín hiệu reset.
  input [31:0]A;           // Địa chỉ đầu vào (32-bit).
  output [31:0]RD;         // Dữ liệu đọc ra (32-bit).

  reg [31:0] mem [1023:0]; // Bộ nhớ lệnh (1024 ô, mỗi ô 32-bit).
  
  assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[31:2]];
                           // Nếu reset (rst = 0), RD = 0.
                           // Nếu không, RD lấy giá trị từ bộ nhớ tại địa chỉ A[31:2].

  initial begin
    $readmemh("memfile.hex",mem); // Nạp dữ liệu từ file `memfile.hex` vào bộ nhớ.
  end
endmodule