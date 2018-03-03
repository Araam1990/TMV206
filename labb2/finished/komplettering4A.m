%Grupp8,grupp�vning2
%ostcarl
%vikfran
%ellenwi
%tankred
%jacped

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
%Plockar fram ett random v�rde mellan 0-1 f�r att best�mma vilken matris
%och vektor som skal k�ras. 
%x uppdateras rekursivt vid varje iteration.
hold on
for i=1:50000
   i
   %ger r ett slumpm�ssigt v�rde mellan 0-1
   r = rand;
   if r <= p(1)
      x = A1*x + b1;
   elseif r <= p(1) + p(2)
      x = A3*x + b3;
   elseif r <= p(1)+p(2)+p(3)
      x = A4*x + b4;
   else 
      x = A2*x+b2;
   end
   plot(x(1),x(2),'g.','markersize',4)
end
axis([-4 6 -2 12])
hold off