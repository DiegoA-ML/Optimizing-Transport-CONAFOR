option optcr = 0.01;

set i  /1*20/;

*Index([2, 3, 5, 6, 8, 9, 10, 12, 13, 16, 17, 18, 19, 21, 22, 23, 24, 26, 27, 28], dtype='int64')
* [14, 16, 15, 5, 18]

alias (i,j);

Table
dist(i,j)
    1       2       3       4       5       6       7       8       9       10      11      12      13      14      15      16      17      18      19      20
1   9999    0.19    0.43    0.58    0.40    0.45    0.59    0.80    0.77    1.15    1.11    1.44    1.23    1.14    1.17    1.18    1.72    1.57    1.53    1.48
2   0.19    9999    0.62    0.74    0.45    0.41    0.48    0.78    0.80    1.07    1.06    1.31    1.34    1.19    1.20    1.17    1.59    1.66    1.59    1.53
3   0.43    0.62    9999    0.28    0.50    0.68    0.87    0.91    0.77    1.34    1.23    1.69    1.01    1.03    1.14    1.22    1.97    1.38    1.36    1.38
4   0.58    0.74    0.28    9999    0.42    0.62    0.82    0.73    0.55    1.17    1.04    1.56    0.72    0.75    0.88    0.99    1.82    1.09    1.07    1.09
5   0.40    0.45    0.50    0.42    9999    0.20    0.40    0.43    0.37    0.83    0.75    1.18    0.89    0.74    0.77    0.79    1.46    1.20    1.14    1.08
6   0.45    0.41    0.68    0.62    0.20    9999    0.19    0.37    0.42    0.70    0.66    1.01    1.02    0.82    0.79    0.76    1.29    1.30    1.22    1.13
7   0.59    0.48    0.87    0.82    0.40    0.19    9999    0.39    0.53    0.58    0.59    0.84    1.14    0.90    0.83    0.76    1.13    1.39    1.30    1.19
8   0.80    0.78    0.91    0.73    0.43    0.37    0.39    9999    0.22    0.44    0.32    0.83    0.80    0.52    0.44    0.39    1.09    1.01    0.91    0.79
9   0.77    0.80    0.77    0.55    0.37    0.42    0.53    0.22    9999    0.64    0.49    1.05    0.61    0.39    0.40    0.45    1.30    0.87    0.80    0.72
10  1.15    1.07    1.34    1.17    0.83    0.70    0.58    0.44    0.64    9999    0.19    0.41    1.12    0.80    0.61    0.43    0.65    1.21    1.09    0.91
11  1.11    1.06    1.23    1.04    0.75    0.66    0.60    0.32    0.49    0.19    9999    0.59    0.93    0.60    0.42    0.24    0.82    1.02    0.91    0.73
12  1.44    1.31    1.69    1.56    1.18    1.01    0.84    0.83    1.05    0.41    0.60    9999    1.53    1.20    1.01    0.81    0.28    1.59    1.46    1.27
13  1.23    1.34    1.01    0.72    0.89    1.02    1.14    0.80    0.61    1.12    0.93    1.53    9999    0.32    0.53    0.72    1.73    0.37    0.38    0.48
14  1.14    1.19    1.03    0.75    0.74    0.82    0.90    0.52    0.39    0.80    0.60    1.20    0.32    9999    0.20    0.40    1.40    0.48    0.40    0.35
15  1.17    1.20    1.14    0.88    0.77    0.79    0.83    0.44    0.40    0.61    0.42    1.01    0.53    0.20    9999    0.19    1.20    0.60    0.49    0.35
16  1.18    1.17    1.22    0.99    0.79    0.76    0.76    0.39    0.45    0.43    0.24    0.81    0.72    0.40    0.19    9999    1.00    0.78    0.66    0.49
17  1.72    1.59    1.97    1.82    1.46    1.29    1.13    1.09    1.30    0.65    0.82    0.28    1.73    1.40    1.20    1.00    9999    1.74    1.61    1.41
18  1.57    1.66    1.38    1.09    1.20    1.30    1.39    1.01    0.87    1.21    1.02    1.59    0.37    0.48    0.60    0.78    1.74    9999    0.12    0.33
19  1.53    1.59    1.36    1.07    1.14    1.22    1.30    0.91    0.80    1.09    0.91    1.46    0.38    0.40    0.49    0.66    1.61    0.12    9999    0.20
20  1.48    1.53    1.38    1.09    1.08    1.13    1.19    0.79    0.72    0.91    0.73    1.27    0.48    0.35    0.35    0.49    1.41    0.33    0.20    9999;

variable
z;

Binary Variable
x(i,j);

Positive Variable
u(i);
Integer Variable
m;
* m: Numero de empleados
* u(i): numero de nodos visitados antes del nodo i

Equations
obj,
r1, r2, r3, r4, r5, r6
subtours;

obj.. z=E=sum((i,j),x(i,j)*(dist(i,j)/10 + 0.5));

r1.. sum((i,j) $ (ord(i) = 18 and ord(j) <> 18), x(i,j)) =E= 3;
r2.. sum((i,j) $ (ord(j) = 18 and ord(i) <> 18), x(i,j)) =E= 3;
r3(j)$(ord(j) <> 18).. sum(i, x(i,j)) =E= 1;
r4(i)$(ord(i) <> 18).. sum(j, x(i,j)) =E= 1;
r5.. sum((i,j),x(i,j)*(dist(i,j)/10 + 0.5)) =L= 8*3;
r6.. sum((i,j),dist(i,j)*x(i,j)) =G= 0;
* la suma de las horas trabajadas de todos los empleados tiene que ser menor que
* 8 veces el numero de empleados

subtours(i,j)$(ord(i)<> 18 and ord(j) <> 18 and ord(i) <> ord(j)).. u(i)-u(j)+card(i)*x(i,j)=L=card(i)-1;
* eliminacion de subrutas


model tsp1 /all/;
solve tsp1 using MIP min z;