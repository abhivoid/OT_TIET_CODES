clc
clear
A=[1,1,1,0;2,-1,0,-1];
b=[6;9];
c=[3,-5,0,0];
m=size(A,1);
n=size(A,2);
nCm=nchoosek(n,m);
pair=nchoosek(1:n,m);
bfs=[];
basicsol=[];
for i=1:nCm
    y=zeros(n,1);
    a=A(:,pair(i,:));
    x=inv(a)*b;
    y(pair(i,:))=x;
    basicsol=[basicsol y];
    if(y>=0)
        bfs=[bfs y];
    end
end
f=@(x)c*x;
cost=f(bfs);
[fmin,index]=min(cost);
opsol=bfs(:,index)