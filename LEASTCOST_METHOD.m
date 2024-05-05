clc
clear
c=[11 20 7 8; 21 7 10 12; 8 12 18 9];
[m,n]=size(c);
d=[30 25 35 40];
s=[50;40;70];
ss=sum(s);
sd=sum(d);
if(ss==sd)
    fprintf("Balanced\n");
else
    if(ss>sd)
        x=zeros(m,1);
        d=[d ss-sd];
        c=[c x];
    else
        x=zeros(1,n);
        s=[s;sd-ss];
        c=[c;x];
    end
end
dd=[d sum(s)];
bfs=[c s];
bfs=[bfs;dd];
bfs=array2table(bfs);
bfs

[m,n]=size(c);
x=zeros(m,n);
cost=c;
while(sum(s)~=0&&sum(d)~=0)
%for j=1:3
    minc=min(c(:));
    [minr,minc]=find(c==minc);
    p=min(s(minr),d(minc));
    [mx,mi]=max(p(1,:));
    fr=minr(mi);
    fc=minc(mi);
    x(fr,fc)=min(s(fr),d(fc));
    if s(fr)<d(fc)
        d(fc)=d(fc)-s(fr);
        s(fr)=0;
        c(fr,:)=inf;
    else
        s(fr)=s(fr)-d(fc);
        d(fc)=0;
        c(:,fc)=inf;
    end
    x
end
fprintf("Least Cost=%d\n",sum(x(:).*cost(:)));
