

function y = barley(window, exclude)

%Deklaration utav sannolikheter, matriser och vektorer
p  = [0.01 0.07 0.07 0.85];
A1 = [ 0  0; 0  .16];  
A2 = [ .85  .04;  -.04  .85]; 
A3 = [.2  -.26;  .23  .22]; 
A4 = [  -.15    .28 ;   .26   .24];
b4 = [0; 0.44];
b3 = [0; 1.6];
b2 = [0; 1.6];
b1 = [0; 0];
% x �r startpunkt
x = [0.5;0.5];
x = [0.5;0.5];
top = x;
right = x;
left = x;
bottom = x;
xMax = 0;
xMin = 20;
yMax = 0;
yMin = 20;
% Plockar fram ett slumpmässigt v�rde mellan 0 och 1 f�r att
% bestämma vilken matris och vektor som skal k�ras.
subplot(2, 5, window)
axis([-4 6 -2 12])
hold on % vänta med att rita ut alla punkter tills efter for-loopen
for i=1:5000
    i
   %ger r ett slumpm�ssigt v�rde mellan 0 och 1
   r = rand;
   if r <= p(1) && exclude ~= 1
          x = A1*x + b1;
   elseif r <= p(1) + p(2) && exclude ~= 3
      x = A3*x + b3;
   elseif r <= p(1)+p(2)+p(3) && exclude ~= 4
      x = A4*x + b4;
   elseif r <= p(1)+p(2)+p(3)+p(4) && exclude ~= 2
      x = A2*x+b2;
   end
   
   plot(x(1),x(2),'.','markersize',4)
   
    %Lokaliserar och sparar bladets yttersta punkter
   if (x(1)>xMax && x(2)<8)
    xMax = x(1);
    right = x;
   end
   if (x(1)<xMin)
    xMin = x(1);
    left = x;
   end
   if (x(2)>yMax)
    yMax = x(2);
    top = x;
   end
   if (x(2)<yMin)
    yMin = x(2);
    bottom = x;
   end
end
xPolygon = [bottom right top left bottom];
uppgift3A([1 1;1 1], [0;0], xPolygon, window + 5)
axis([-4 6 -2 12])

hold off

end
