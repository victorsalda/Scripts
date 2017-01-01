#BUILD A MATRIX IN PYTHON
matriz=[]
fi=int(raw_input("Cantidad de filas: "))
co=int(raw_input("Cantidad de columnas: "))
for i in range (fi):
    matriz.append([0]*co) #elementos de las columnas que tenga.
for f in range (fi):
    for c in range (co):
        matriz[f][c]=int(raw_input("Elemento %d, %d: " % (f,c)))
print  'the matriz is', matriz