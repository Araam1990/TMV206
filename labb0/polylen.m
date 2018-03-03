function svar=polylen(x,y)
    n=length(x);
    svar=0;
    for i=1:n-1
        svar=svar+sqrt((x(i+1)-x(i))^2+(y(i+1)-y(i))^2);
    end
end