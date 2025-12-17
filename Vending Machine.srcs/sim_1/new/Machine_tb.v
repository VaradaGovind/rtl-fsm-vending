`timescale 1ns / 1ps

module Machine_tb();

    reg clk;
    reg rst;
    reg [2:0] coin_in;
    reg sel_valid;
    reg [1:0] sel;
    
    wire dispense;
    wire [7:0] change;
    wire [7:0] balance;
    wire ready;

    Machine uut (
        .clk(clk),
        .rst(rst),
        .coin_in(coin_in),
        .sel_valid(sel_valid),
        .sel(sel),
        .dispense(dispense),
        .change(change),
        .balance(balance),
        .ready(ready)
    );

    always #5 clk = ~clk;

    initial begin
    
        clk = 0;
        rst = 1;
        coin_in = 3'b000;
        sel_valid = 0;
        sel = 2'b00;

        #20 rst = 0;
        #10;

        coin_in = 3'b100; #10; 
        coin_in = 3'b000; #10;
        
        coin_in = 3'b100; #10;
        coin_in = 3'b000; #10;

        sel = 2'b01; 
        sel_valid = 1; #10;
        sel_valid = 0;
        
        #20;

        repeat(3) begin
            coin_in = 3'b100; #10;
            coin_in = 3'b000; #10;
        end

        sel = 2'b10;
        sel_valid = 1; #10;
        sel_valid = 0;

        #40;

        coin_in = 3'b010; #10;
        coin_in = 3'b000; #10;

        sel = 2'b11;
        sel_valid = 1; #10;
        sel_valid = 0;

        #50;
        $stop;
    end

    initial begin
        $monitor("Time=%0t | Balance=%d | Sel=%d | Dispense=%b | Change=%d | Ready=%b", 
                 $time, balance, sel, dispense, change, ready);
    end

endmodule