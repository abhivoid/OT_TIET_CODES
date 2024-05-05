clc 
clear
f=@(x) x(1)^2-(x(1)*x(2))+x(2)^2;
gf=@(x) [2*x(1)-x(2);-x(1)+2*x(2)];
x0=[1.0;0.5];
ap=0.01;
tol=0.05;
i=0;
gr=gf(x0);
while norm(gr)>tol
    x=x0-ap*gr;
    x0=x;
    gr=gf(x0);
    i=i+1;
end
fv=f(x0)