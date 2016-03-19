/**
 * Conta até 50.000.000, volta a 0, repete o processo
 */ 
module counter(input CLOCK_50, input KEY, input w, output [25:0] out);
	reg [25:0] counter;
	
	assign out = counter;

	always @(CLOCK_50,KEY) begin
		if(KEY | w) begin
			counter <= 0;
		end
		else begin
			counter <= counter + 1;
		end
	end
endmodule

/**
 *	Conta um segundo
 *		Se saída do counter for = 50 milhões, saída recebe 1, senão recebe 0.
 */ 
module one_second(input [25:0] counter_out, output w);
	assign w = (counter_out == 26'd50000000) ? 1 : 0;
endmodule

/**
 *	Representa o resultado final do circuito
 *		A cada um segundo muda o estado do led
 */
module led_control(input w, output LEDG);
	reg state = 0;
	
	assign LEDG = state;
	
	always @(posedge w) begin
		state = ~state;
	end
endmodule

/**
 *	Representa o resultado final do circuito
 *		A cada um segundo muda o estado do led na placa
 */
module led(CLOCK_50, KEY, LEDG);
	wire [25:0] counter_out;
    input CLOCK_50;
    wire w; 
    input  [0:0] KEY;
    output [0:0] LEDG;
    
	counter c     ( CLOCK_50, KEY, w, counter_out );
    one_second os ( counter_out, w );
    led_control l ( w, LEDG[0] );
endmodule


/**
 *	Módulo de teste
 *	obs:ajustar tempo do contador para testar
 */
module teste;
	wire [25:0] counter_out;
	reg  CLOCK_50;
	wire w; 
	reg  [0:0] KEY; 
	wire [0:0] LEDG;

	counter c      ( CLOCK_50, KEY, w, counter_out );
	one_second os  ( counter_out, w );
	led_control lc ( w, LEDG );

	always #2 CLOCK_50 = ~CLOCK_50;

	initial begin
		$dumpvars(0, counter_out, LEDG);
		
		KEY = 1;
		CLOCK_50 = 0;

		#2;
		KEY = 0;

		#10000;
		$finish;
	end
endmodule
