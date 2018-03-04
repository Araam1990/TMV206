% Grupp 8
% CIDs
% jacped
% ostcarl
% ellenwi
% vikfran
% tankred

% clear the plot-window
clf

% godtyckligt tal för Neumann aproximation
r = 14;

% antalet iterationer (sätt till lägre än 500 för tydligare Neumann-graf och snabbare beräkningstider)
max = 500;

% vektor med en tiden det tar för varje uträkning m.h.a. Gauss
gTimeVector = [0];

% vektor med en tiden det tar för varje uträkning m.h.a. Neumann
nTimeVector = [0];

% vektor med alla relativa felen
relFelVector = [0];

% vektor med talen 0 t.o.m. maxtalet
iVector = 0:max;

for i=1:max
    % skapa en slumpmässig kvadrat-matris och en slumpmässig vektor, båda med storleken i
    B = randMatrix(i);
    b = randVector(i);

    % timeit initiering
    f1 = @() gauss(B, b);
    gaussTime = timeit(f1, 1);
    % spara tiden som det tar att utföra beräkningen i den matchande vektorn
    gTimeVector = [gTimeVector gaussTime];

    % timeit initiering
    f2 = @() neumann(B, b, r);
    neumannTime = timeit(f2, 1);
    % spara tiden som det tar att utföra beräkningen i den matchande vektorn
    nTimeVector = [nTimeVector neumannTime];

    % räkna ut det relativa felet och spara det i den matchande vektorn
    relFelVector = [relFelVector relativtFel(B, b, r)];
    % printa ut i så att man vet hur långt man har kommit (ZZZzzzzzzzzz)
    i
end

% räkna ut den längsta tiden som det tar att utföra antingen Gauss eller Neumann beräkningarna
maxY = max(max(gTimeVector), max(nTimeVector));

hold on

subplot(1,3,3)

% Gauss-tiden som funktion av iterationen
plot(iVector, gTimeVector, '-')

% samma axel som Neumann, för att göra skillnaden mellan de två tydligare
axis([0 i 0 maxY]);

title("Gauss");
xlabel("Matrix size");
ylabel("Time");

subplot(1,3,2)

% Neumann-tiden som funktion av iterationen
plot(iVector, nTimeVector, '-')

% samma axel som Gauss, för att göra skillnaden mellan de två tydligare
% (vid 500 iterationer kan det vara svårt att se grafen eftersom att Gauss tar så mycket mer tid, 
% men om man har olika skala på de två så blir det väldigt otydligt vad skillnaden mellan dem är, 
% därför valde vi att ha det på detta sätt.)
axis([0 i 0 maxY]);

title("Neumann");
xlabel("Matrix size");
ylabel("Time");

subplot(1,3,1)
% Det relativa felet som funktion av iterationen
plot(iVector, relFelVector, '-')
% en godtycklig skalning som det relativa felet alltid borde rymmas i
axis([0 i 0 10^(-4)]);

title("Relativt fel");
xlabel("Matrix size");
ylabel("Relativt fel")

hold off

% räknar ut det relativa felet (enligt uppgift)
function out = relativtFel (A, b, r)
    out = norm(neumann(A, b, r) - gauss(eye(length(A))-A, b))/norm(gauss(eye(length(A))-A, b)) ;
end


% En slumpad kvadrat-matris av storleken size
function A = randMatrix(size)
    % skapa matrisen
    A = rand(size);
    
    % se till att norm(A) = 1/2
    A = A / (norm(A) * 2);
end

% En slumpad kolonn-vektor av storleken size
function V = randVector(size)
    V = rand(size, 1);
end

% Gauss
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

% Neumann
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
