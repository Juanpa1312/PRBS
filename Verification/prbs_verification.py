#Import numpyt API
import numpy as np

#Set variables
Clk = 0
Reset = 0
shift_reg = np.array([1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0])
Semilla = np.array([1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0])
Longitud = 1
Polinomio = 1
reg_1 = 5

#Loop, number of packages in the transmision of info
for i in range(30):
    if Reset == 0:
        if i == 0:
            shift_reg[0:29] = Semilla[0:29]
            a = str(i)
            #row
            print(a+"---------------------------------------------------------------"+a)
            print(shift_reg)
        else:
            #The shift right is going to take place
            #shift_reg[0:29] = shift_reg << 1
            for j in range(29):
                if reg_1 == 5:
                    reg_1 = shift_reg[j]
                    reg_2 = shift_reg[j+1]
                    shift_reg[j+1] = reg_1
                else:
                    reg_1 = reg_2
                    reg_2 = shift_reg[j+1]
                    shift_reg[j+1] = reg_1
            #Feedback        
            if Longitud == 1:
                Salida = shift_reg[29]
                shift_reg[0] = (shift_reg[29] ^ shift_reg[19])
            elif Longitud == 2:
                Salida = shift_reg[24]
                shift_reg[0] = (shift_reg[24] ^ shift_reg[14])
            else:
                Salida = shift_reg[5]
                shift_reg[0] = (shift_reg[5] ^ shift_reg[3])
            a = str(i)
            #row
            print(a+"---------------------------------------------------------------"+a)
            print(shift_reg)
