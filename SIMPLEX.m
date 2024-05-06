clc
clear

%declare
c=[4 3 6];
a=[2 3 2;4 0 3;2 5 0];
b=[440;470;430];

%formation of table
[m,n]=size(a);
s=eye(m);
A=[a s b];
cost=zeros(1,size(A,2));
cost(1:n)=c;
bv=n+1:size(A,2)-1;
zjcj=cost(bv)*A-cost;
table1=[zjcj;A];
table1=array2table(table1);
fprintf('Initial Tablet\n');
table1

%iteration
zc=zjcj(1:end-1);
while any(zc<0)
    disp("Above table is not optimal");
    [mv,pvtc]=min(zc);
    cl=A(:,end);
    sol=A(:,pvtc);
    for i=1:m
        if(sol(i)>0)
            r(i)=cl(i)./sol(i);
        else
            r(i)=inf;
        end
    end
    [rv,pvtr]=min(r);
    k=A(pvtr,pvtc);
    A(pvtr,:)=A(pvtr,:)./k;
    for i=1:m
        if i~=pvtr
            A(i,:)=A(i,:)-A(i,pvtc).*A(pvtr,:);
        end
    end
    zjcj=zjcj-zjcj(pvtc).*A(pvtr,:);
    zc=zjcj(1:end-1);
    tablei=[zjcj;A];
    tablei=array2table(tablei);
    fprintf("After enter %d col and exiting %d row",pvtc,pvtr);
    tablei
    bv(pvtr)=pvtc;
end

disp("Opimality reached");
fprintf("Value of Z=%d\n",zjcj(1,end));
fprintf("Basic variables:-\n");
bv
disp("Values of BV:");
A(:,end)
