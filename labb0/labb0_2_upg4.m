subplot(1,2,1)
[x,y]=ginput;
x=[x; x(1)];
y=[y; y(1)];
plot(x,y,'-o')
fill(x,y,'p')