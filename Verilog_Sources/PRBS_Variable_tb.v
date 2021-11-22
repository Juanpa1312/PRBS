`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2021 13:34:01
// Design Name: 
// Module Name: PRBS_Variable_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module PRBS_Variable_tb();   
    //Entradas y Salidas del Sistema 
    reg Clk;
    reg Reset;
    reg [0:29] Semilla;
    reg [0:1] Longitud;
    //reg [0:1] Polinomio;
    wire Salida;
    //Módulo PRBS_Variable   
    PRBS_Variable UUT(.Clk(Clk), .Reset(Reset), .Semilla(Semilla), .Longitud(Longitud), /*.Polinomio(Polinomio),*/ .Salida(Salida));
always // no sensitivity list, so it always executes
begin
//Definición del clock
Clk = 1; #15; Clk = 0; #15; // período de 10ns
end

//Configuración de la simulación
initial begin
    //Escriba el valor deseado para la Semilla
    Semilla = 30'b101100111010111011001110010100;
    //Longitud del polinomio
    //Longitud = 00 -> shift_reg[29] x^30
    //Longitud = 01 -> shift_reg[24] x^25
    //Longitud = 11 -> shift_reg[19] x^20
    Longitud = 2'b00;
    //Polinomio de realimentacion
    //Polinomio = 00 -> shift_reg[19] x^20
    //Polinomio = 01 -> shift_reg[14] x^15
    //Polinomio = 11 -> shift_reg[9]  x^10
    //Polinomio = 2'b00;
    //Botón de Reset
    // Reset = 0 El Flip flop funciona normalmente
    // Reset = 1 El Flip flop resetea sus valores
    Reset = 1'b0;
    #15;
    Reset = 1'b1;
    #15;
    Reset = 1'b0;
    //Tiempo de duración de la simulación
    #2000000;
    $stop;
end
endmodule
