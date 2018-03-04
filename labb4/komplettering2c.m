clf

%godtycklig matris, vektor och tal
B = randMatrix(4);
b = randVector(4);
r = 14;

gTimeVector = [0];
nTimeVector = [0];
relFelVector = [0];
iVector = 0:250;

for i=1:250
    B = randMatrix(i);
    b = randVector(i);

    f1 = @() gauss(B, b);
    gaussTime = timeit(f1, 1);
    gTimeVector = [gTimeVector gaussTime];

    f2 = @() neumann(B, b, r);
    neumannTime = timeit(f2, 1);
    nTimeVector = [nTimeVector neumannTime];

    relFelVector = [relFelVector relativtFel(B, b, r)];
    i
end

maxY = max(max(gTimeVector), max(nTimeVector));
hold on

subplot(1,3,3)
plot(iVector, gTimeVector, '-')
axis([0 i 0 maxY]);
title("Gauss");
xlabel("Matrix size");
ylabel("Time");

subplot(1,3,2)
plot(iVector, nTimeVector, '-')
axis([0 i 0 maxY]);
title("Neumann");
xlabel("Matrix size");
ylabel("Time");

subplot(1,3,1)
plot(iVector, relFelVector, '-')
axis([0 i 0 10^(-4)]);
title("Relativt fel");
xlabel("Matrix size");
ylabel("Relativt fel")



hold off

function out = relativtFel (A, b, r)
    out = norm(neumann(A, b, r) - gauss(eye(length(A))-A, b))/norm(gauss(eye(length(A))-A, b)) ; %enligt uppgift
end


function A = randMatrix(size)
    % skapa matrisen
    A = rand(size);
    
    % se till att norm(A) = 1/2
    A = A / (norm(A) * 2);
end

function V = randVector(size)
    V = rand(size, 1);
end



function solutionVector = gauss(A, b)
    n = size(A, 1);                             % plockar ut antal rader i matrisen
    A = [A b];                                  % skapa den augmenterade matrisen med b som sista kolumn tillagt p� A
    
    for j = 2:n                                 % nedan f�ljer algorithm f�r gausselimination
        for i = j:n                             
            A(i, :) = A(i, :) + (A(j - 1, :) * (-A(i, j - 1) / A(j - 1, j - 1)));
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
