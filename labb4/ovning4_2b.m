% Grupp 8
% ostcarl
% jacped
% ellenwi
% vikfran
% tankred

%godtycklig matris, vektor och tal
B = [1 1 1; 2 2 2; 3 3 3];
b = [1;2;3];
r = 5;

x = neumann(B,b,r);
B
b
r
x

function x=neumann(B, b, r)
    n = size(B, 1);                             % h�mtar antal rader i matrisen                                
    totalSum = b;                              
    currentSum = b;                               
                                            
    for k = 1:r                                 % H�r sker ber�kningen utav summan(Neumannserie)                             
        currentSum = B * currentSum;                  
        totalSum = totalSum + currentSum;                   
    end
    
    x = totalSum;     
end