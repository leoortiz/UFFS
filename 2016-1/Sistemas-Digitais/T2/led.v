/**
 * Conta até 50.000.000, volta a 0, repete o processo
 */ 
module counter(input clock, input reset, input w, output [25:0] out);
	reg [25:0] counter;
	
	assign out = counter;

	always @(clock,reset) begin
		if(reset | w) begin
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
	assign w = (counter_out == 26'd50) ? 1 : 0;
endmodule

/**
 *	Representa o resultado final do circuito
 *		A cada um segundo muda o estado do led
 */
module led(input clock, input w, output final_out);
	reg state = 0;
	
	assign final_out = state;
	
	always @(posedge w) begin
		state = ~state;
	end
endmodule

/**
 *	Módulo de Teste
 *		Apresenta como saída o valor do contador(0 a 50 milhões) e o valor do 
 *		LED(1 segundo aceso, 1 segundo apagado).
 *
 *	@TODO Ajustar tempo
 */
module test;
	wire [25:0] counter_out;
	reg  CLOCK_50;
	wire w; 
	reg  [0:0] KEY; 
	wire [0:0] LEDG;

	counter c	  ( CLOCK_50,KEY, w, counter_out );
	one_second os ( counter_out, w );
	led l		  ( CLOCK_50, w, LEDG );

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
