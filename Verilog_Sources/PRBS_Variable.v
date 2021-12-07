`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DCILab - Tecnológico de Costa Rica
// Engineer: Juan Pablo Salazar Sánchez
// 
// Create Date: 25.05.2021 05:19:23
// Design Name: PRBS Variable
// Module Name: PRBS_Variable
// Project Name: PRBS de longitud y polinomio variable con semilla configurable
// Target Devices: Circuito Integrado
// Tool Versions: Vivado 2020.2
// Description: Pulso pseudoaleatorio de longitud y polinomio variable con semilla configurable
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:

/*Se han intentado quitar todos los latch posibles, pero finalmente el sistema
es el más simple y limpio que he podido implementar, este tiene solamente 2 latches
que no se han podido eliminar todavía.*/

// 
//////////////////////////////////////////////////////////////////////////////////


//Instancia del módulo de PRBS Variables
module PRBS_Variable(
        //Entradas y Salidas del Sistema
        input Clk,
        input Reset,
        input [0:29] Semilla,
        input [0:1] Longitud,
        //input [0:1] Polinomio,
        output reg Salida
    );

//Registro para los flip-flops del PRBS   
// reg [0:29] shift_reg = 30'b000000000000000000000000000000;
reg shift_reg [0:29] = Semilla [0:29];
/*
//Selector de MUX A (Salida/Longitud Variable)
always@(*)
    case(Longitud)
       //Opción #1 -> x^30
       2'b00: Salida = shift_reg[29];
       //Opción #2 -> x^25
       2'b01: Salida = shift_reg[24];
       //Opción #3 -> x^30
       2'b10: Salida = shift_reg[19];
    endcase

//Selectores de MUX B (Polinomio/Realimentación XOR Variable)
always@(*)
    case(Longitud)
       //Opción #1 -> XOR (x^30)^(x^20)
       2'b00: shift_reg[0] = (shift_reg[29] ^ shift_reg[19]);
       //Opción #2 -> XOR (x^25)^(x^15)
       2'b01: shift_reg[0] = (shift_reg[24] ^ shift_reg[14]);
       //Opción #3 -> XOR (x^20)^(x^10)
       2'b10: shift_reg[0] = (shift_reg[19] ^ shift_reg[9]);
    endcase
*/ 

//Definición de los flip-flops
always @(posedge Clk)
begin
    //Entra la condición solo si el reset tiene un valor de 0
    //Si no se cumple la condición el sistema simplemente deja de funcionar
    if (Reset == 1'b1)begin
        shiftreg[0:29] = Semilla[0:29];
    end
    else begin
    
    //if(Reset == 1'b0)begin
        //Condición para inicializar la semilla, solo se da en el primer ciclo
        //if (shift_reg[0:29] == 30'b000000000000000000000000000000)
        //begin
            //Se inicializa la semilla
            //shift_reg [0:29] = Semilla [0:29];
        //end
        //else begin
        //Se aplica shitf left al registro shift_reg para mover un dato a la izquierda
        shift_reg[0:29] = shift_reg >> 1;
        
        //Combinación Lógica de selección para Salida y el nuevo primer elemento de de shift_reg (shift_reg[0])
        if(Longitud == 2'b00)
        begin
            //Estado S1: Longitud -> 00
            //Opción #1 -> x^30
            Salida = shift_reg[29];
            //Opción #1 -> XOR (x^30)^(x^20)
            shift_reg[0] = (shift_reg[29] ^ shift_reg[19]);
        end
        else if(Longitud == 2'b01)
        begin
            //Estado S2: Longitud -> 01
            //Opción #2 -> x^25
            Salida = shift_reg[24];
            //Opción #2 -> XOR (x^25)^(x^15)
            shift_reg[0] = (shift_reg[24] ^ shift_reg[14]);
        end
        else begin
            /*
            //Estado S3: Longitud -> 10, 11 (Estado no deseado)
            //Opción #3 -> x^30
            Salida = shift_reg[19];
            //Opción #3 -> XOR (x^20)^(x^10)
            shift_reg[0] = (shift_reg[19] ^ shift_reg[9]);
            */
                
            Salida = shift_reg[5];
            shift_reg[0] = (shift_reg[5] ^ shift_reg[3]);
        end
    end
end
endmodule
