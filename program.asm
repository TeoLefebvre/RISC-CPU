MOV R1 1
SUB R0 R1 8
ZJUMP 30 # attention, 29 en binaire car les adresses de la ROM commencent à 0
PUSH R1 # argument i pour GRADIENT
PUSH 7 # ligne à exécuter au retour de la fonction, 6 en binaire
JUMP GRADIENT
ADD R1 R1 1
JUMP 2

GRADIENT:
PUSH R1 # push pour sauvegarder les valeurs des registres qu'on va utiliser
PUSH R2
PUSH R3
POP R1 4 # argument i
LOAD R2 R1 # inVect[i]
SUB R1 R1 1 # i-1
LOAD R3 R1 # inVect[i-1]
MUL R2 R2 3
MUL R3 R3 2
SUB R2 R2 R3
ADD R1 R1 9 # +9 pour obtenir l'adresse en RAM de outVect[i]
WRITE R2 R1 # écrire en RAM la valeur de R2 à l'adresse contenue dans R1
POP R3 # pop pour réinitialiser les registres aux valeurs sauvagardées
POP R2
POP R1
POP R0 # ligne où retourner après la fonction
JUMP R0 # retourne à la ligne dans R0

PRINT:
LOAD R1 8
LOAD R1 9
LOAD R1 10
LOAD R1 11
LOAD R1 12
LOAD R1 13
LOAD R1 14
LOAD R1 15