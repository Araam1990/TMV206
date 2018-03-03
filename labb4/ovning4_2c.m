% Grupp 8
%jacped
%ostcarl
%tankred
%ellenwi
%vikfran



%en slumpad matris
A = randMatris;

%godtycklig svarsvektor
b = A(:, randi(length(A)))*(rand(1));

%godtyckligt nummer som oftast ger ett relativt fel i storleksordningen
% 10.^-5
r = 14; 

fel = relativtFel(A, b, r);

tid = timer(A, b, r); % = [tidFörGauss; tidFörNeumann]


% plottar relativt fel
a1 = subplot(1,2,1);
bar(fel)
xlabel(a1, "Relativt fel");

%plottar tiderna för gauss och neumann
a2 = subplot(1,2,2);
bar(tid)
xlabel(a2, 'Gauss respektive Neumann')
ylabel(a2, 'Tid');


%matrismultiplikation
function y = matrismul(A, B)
    rader = length(A(:,1));
    kolumner = length(B(1,:));   
    for(arad = 1:rader)       %gå egenom matris A
        for(bkolumn = 1:kolumner)   %gå egenom matirs B.
            result = 0;             
            for(i = 1:rader)
               result = result + A(arad,i) * B(i,bkolumn);  
               %summera alla summor av i:te raden och i:te kolumnen, för
               %varje i
            end
            y(arad, bkolumn) = result;  %returnera resultatet 
        end
    end
end

%gauss-jordan
function out = Gauss(A, b)
    rader = length(A(:,1));
    kolumner = length(A(1,:));
    % bottom left triangle
    for kolumn=1:kolumner
        for rad=(kolumn+1):rader
            k = -A(rad,kolumn)/A(kolumn,kolumn);
            A(rad,:) = A(rad,:)+(k)*A(kolumn,:);
            b(rad,1) = b(rad,1)+(k)*b(kolumn,1);
        end
    end
    % diagonalen = 1
    for kolumn=1:kolumner
        k = 1/A(kolumn,kolumn);
       A(kolumn,:) = A(kolumn,:)*k;
       b(kolumn,:) = b(kolumn,:)*k;
    end
    
    % top right triangle
    for kolumn = kolumner:-1:2
        for rad = kolumn-1:-1:1
           k = -(A(rad,kolumn));
           A(rad,:) = A(rad,:) + k*(A(kolumn,:));
           b(rad,:) = b(rad,:) + k*(b(kolumn,:));
        end
    end
    out = b;
end

% räkna ut (I-A)*x = b
function matris = neumann(A, b, r)
    % A upphöjt till k (1 från början)
    nyA = A;
    matris = matrismul(nyA, b);
    for (k=2:r)
        nyA = matrismul(nyA, A);
        % uppdatera matrisen
        matris = matris +  matrismul(nyA, b);
    end
    % lägg till A upphöjt till 0 (I) gånger b
    matris = matris + matrismul(eye(length(A)), b);
end


function out = relativtFel (A, b, r)
    out = norm(neumann(A, b, r) - Gauss(eye(length(A))-A, b))/norm(Gauss(eye(length(A))-A, b)) ; %enligt uppgift
end

%tar tiden på gauss och neumann
function tid = timer(A, b, r)

    %gauss
    f = @() Gauss(eye(length(A))-A, b);      
    t1 = timeit(f);
    
    %neumann
    g = @() norm(neumann(A, b, r));
    t2 = timeit(g);
    %tiden returneras som en vektor
    tid = [t1;t2];
end

% Slumpar fram en n*n matris, där n är slumpmässigt 1-500 med normen = 0.5
function matris = randMatris
    size = randi(500);
    
    %skapa matris
    matris = magic(size);
    for row = 1:size
        for col = 1: size
            %fyll matrisen
           matris(row, col) = randi(100)/100;
        end
    end
    % se till att normen är 0.5
    matris = matris / (norm(matris)*2);
end

