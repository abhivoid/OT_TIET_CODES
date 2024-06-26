clc
clear
c=[4 3];
st=[1 1;2 1];
b=[8;10];
s=eye(size(st,1));
c=[c zeros(1,size(st,1)+1)];
a=[st s b];
bv=3:4;
zjcj=c(bv)*a-c;
table1=[zjcj;a]

zc=zjcj(1:end-1);
while any(zc<0)
    disp("Above table is not optimal");
    [mv,pvtc]=min(zc);
    fprintf("Entering column=%d\n",pvtc);
    sol=a(:,end);
    col=a(:,pvtc);
    for i=1:size(a,1)
        if col(i)>0
            r(i)=sol(i)/col(i);
        else
            r(i)=inf;
        end
    end
    [mv,pvtr]=min(r);
    fprintf("Leaving row=%d\n",pvtr);
    a(pvtr,:)=a(pvtr,:)/a(pvtr,pvtc);
    for i=1:size(a,1)
        if i~=pvtr
            a(i,:)=a(i,:)-a(i,pvtc).*a(pvtr,:);
        end
    end
    v=zjcj(pvtc);
    zjcj=zjcj-v*a(pvtr,:);
    zc=zjcj(1:end-1);
    bv(pvtr)=pvtc;
    tablei=[zjcj;a]
end
disp("Above table is optimal");
fprintf("Optimal Value=%d\n",zjcj(end));
x=zeros(1,size(a,2)-1);
x(1,bv)=a(:,end);
array2table(x)
