module dual_dice (
  input clk, input button, input reset,
  output wire [3:0] digit, output wire [6:0] segment,
  output reg [2:0] LEDs, output reg [1:0] stage
);

  parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;
  
  reg [2:0] state, next_state;
  
  wire [3:0] dice;
  reg [3:0] sum1 = 4'b0000;
  reg [3:0] sum2 = 4'b0000;
  reg disp_en = 0;
  
  wire debounced;
  
  // Instantiating counters
  counter counter1 (.clk(clk), .enable(debounced), .count(dice));

  // Instantiating debouncer
  Debounce debouncer (.clk(clk), .button(button), .debounced(debounced));
  
  // Instantiating display
  Display disp (.clk(clk), .disp_en(disp_en), .C1(sum1), .C2(sum2), .seg(segment), .digit(digit));
  
  // State transition logic
  always @(*) begin
    case (state)
      S0: next_state = debounced ? S1 : S0;
      S1: next_state = debounced ? S1 :
                    ((dice == 4'b0011 || dice == 4'b0110 || dice == 4'b1001) ? S2 :
                     ((dice == 4'b0010 || dice == 4'b1000 || dice == 4'b1011) ? S3 : S4) );
      S2: next_state = reset ? S2 : S0;
      S3: next_state = reset ? S3 : S0;
      S4: next_state = debounced ? S5 : S4;
      S5: next_state = debounced ? S5 :
                    ((dice == 4'b0011 || dice == 4'b0110 || dice == 4'b1001) ? S3 :
                    ((dice == sum1) ? S2 : S4) );
      default: next_state = S0;
    endcase
  end

  // State flip flops
  always @(posedge clk) begin
    if (~reset) state <= S0;
    else state <= next_state;
  end

  // Assigning outputs
  always @(*) begin
    case (state)
      S0: begin
        disp_en = 0;
        sum1 = 4'b0000;
        sum2 = 4'b0000;
        stage = 2'b01;
        LEDs = 3'b000;
      end
      S1: begin
        sum1 = dice;
        disp_en = 1;
      end
      S2: begin
        LEDs = 3'b100;
        stage = 2'b00;
      end
      S3: begin
        LEDs = 3'b010;
        stage = 2'b00;
      end
      S4: begin
        LEDs = 3'b001;
        stage = 2'b10;
		  if(sum2!=4'b0000)begin
			sum1=sum2;
			sum2=4'b0000;
		  end
      end
      S5: begin
		  sum2=dice;
      end
    endcase
  end

endmodule
