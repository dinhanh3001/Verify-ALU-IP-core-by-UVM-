interface tinyalu_if (input bit clk, input bit reset_n); 
   import tinyalu_pkg::*; 

   // cac tin hieu noi voi dut 

   logic [7:0]  A; 
   logic [7:0]  B; 
   operation_t op; 
   logic        start; 
   logic        done;
   logic [15:0] result; 

   // BFM task : cac ham dieu khien cap thap 

   // task 1: reset 
   // chuan hoa quy trinh reset de dam bao moi test deu reset giong nhau 

   task reset_alu(); 
      start <= 1'b0; 
      A     <= 1'b0; 
      B     <= 8'h00; 
      op    <= NO_OP; 
      // doi 2 chu ki clock de dam bao reset on dinh 
      repeat(2) @(posedge clk); 
   endtask 
   // task 2: gui  lenh den ALu ( driver logic )
   // input: Du lieu can tinh 
   // Output: Ket qua tra ve tu DUT 
   task send_op(input byte iA, input byte iB, input operation_t iop, output shortint alu_result); 
     @(posedge clk); 
     // lai du lieu len bus 
     start <= 1'b1; 
     A     <= iA; 
     B     <= iB; 
     op    <= iop; 

     // xu ly giao thuc bat ta 
     if(iop == NO_OP) begin 
        // khong sinh ra tin hieu done, chi can ha start sau 1 chu ky 
        @(posedge clk); 
        start     <= 1'b0; 
        alu_result<=0;
     end 
     else begin 
        // voi cac lenh tinh toan , phai doi tin hieu done tu DUT 
        do begin 
            @(posedge clk) ; 
        end while(done ===0); 
        // thu thap ket qua 
        start  <= 1'b0; 
        alu_result = result; 
     end 

   endtask

   // task 3: monitor 

   task  monitor_alu(output byte mA, output byte mB, output operation_t mop, output shortint mres); 
      @(posedge clk iff (start ==1'b1)); 
      // thu thap input 
      mA = A; 
      mB = B; 
      mop = operation_t '(op); // eep kieu ve enu m

      // cho ket qua 
      if(mop == NO_OP) begin 
         @(posedge clk iff (start ==1'b0)); 
         mres = 0; 
      end 
      else begin 
         @(posedge clk iff (done ==1'b1)); 
         mres = result; 
      end 
   endtask 
   
endinterface:tinyalu_if
