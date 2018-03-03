i=0;
x=0;
d=1;
tol=1e-5;
while d>tol
    xny=x+(((-1)^i)/((2*i)+1));
    d=abs(x-xny);
    x=xny;
    i=i+1;
end
disp(x);