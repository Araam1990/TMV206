% Grupp 8
% ostcarl
% jacped
% ellenwi
% vikfran
% tankred

% Godtycklig matris och vektor
A = [2 1 1 1; 3 4 3 -4; 1 1 1 2; 2 3 1 3];
b = [0;7;6;6];

x = gauss(A,b);
A
b
x

function solutionVector = gauss(A, b)
    n = size(A, 1);                             % plockar ut antal rader i matrisen
    disp(A);                                    % printa A
    A = [A b];                                  % skapa den augmenterade matrisen med b som sista kolumn tillagt p� A
    disp(A);                                    % printa A
    
    for j = 2:n                                 % nedan f�ljer algorithm f�r gausselimination
        for i = j:n                             
            A(i, :) = A(i, :) + (A(j - 1, :) * (-A(i, j - 1) / A(j - 1, j - 1)));
            disp(A);                            % printa A vid varje iteration
        end
    end
                                                %h�r ber�knas
                                                %l�sningsvektorn X
    x = zeros(n, 1);                        
    x(n) = A(n, n + 1) / A(n, n);             
    
    for g = n-1:-1:1                          
        cols = 0;                      
        for s = g+1:n                          
            cols = cols + (x(s) * A(g, s));
        end                                       
        x(g) = (A(g, n + 1) - cols) / A(g, g);
    end
    
    solutionVector = x;
end