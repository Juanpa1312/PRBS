# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
#Import API
import numpy as np
import matplotlib.pyplot as plt

#Set variables
Clk = 0
Reset = 0
shift_reg = np.array([1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0])
Semilla = np.array([0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1])
Longitud = 1
Polinomio = 1
reg_1 = 5
Salida_record_array = np.array([])

#Loop que refleja el funcionamiento del sistema de los flip flops conectados (shift register)
for i in range(30):
    #Si reset esta en bajo se puede continuar
    if Reset == 0:
        #Si es la primera vuelta entra esta condición
        if i == 0:
            shift_reg[0:29] = Semilla[0:29]
            a = str(i)
            print(a+"---------------------------------------------------------------"+a)
            print(shift_reg)
        #Para toda las demás vueltas que no sean la primera, siguen esta condición    
        else:
            #Movimento de shift en verilog
            #shift_reg[0:29] = shift_reg << 1
            
            #Movimiento de shift al shift_reg por medio de loop y registros auxiliares
            for j in range(29):
                if reg_1 == 5:
                    reg_1 = shift_reg[j]
                    reg_2 = shift_reg[j+1]
                    shift_reg[j+1] = reg_1
                else:
                    reg_1 = reg_2
                    reg_2 = shift_reg[j+1]
                    shift_reg[j+1] = reg_1
            
            #Condición para elegir tanto la realimentación como la salida
            #Condición 1
            if Longitud == 1:
                #Realimentación
                Salida = shift_reg[29]
                shift_reg[0] = shift_reg[29] ^ shift_reg[19]
                #Imprime Salida
                print(Salida)
                #Se guarda el regitro de cada salida por vuelta, respetando el orden
                y = np.append(y, Salida)
            
            #Condición 2
            elif Longitud == 2:
                #Realimentación
                Salida = shift_reg[24]
                shift_reg[0] = shift_reg[24] ^ shift_reg[14]
                #Imprime Salida
                print(Salida)
                #Se guarda el registro de cada salida por vuelta, resptando el orden
                y = np.append(y, Salida)
            
            #Condición 3
            else:
                #Realimentación
                Salida = shift_reg[19]
                shift_reg[0] = shift_reg[19] ^ shift_reg[9]
                #Imprime Salida
                print(Salida)
                #Se guarda el regitro de cada salida por vuelta, respetando el orden
                y = np.append(y, Salida)
                
            #a = str(i)
            #print(a+"---------------------------------------------------------------"+a)
            #print(shift_reg)
            
print(y)

#Grafica que muestra el flujo de la salida de acuerdo al número de estado
#Se utilizan 30 muestras para este caso
plt.plot([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29], y, 'ro')
plt.grid(True)
plt.show()
