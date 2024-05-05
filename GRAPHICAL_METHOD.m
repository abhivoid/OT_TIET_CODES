clc
clear
% Step 1: Input Parameters
C=[3,2];
A=[2 4;3 5];
B=[8;15];

% Step 2: Plotting the graph
x1=0:max(B);
x21=(B(1)-A(1,1)*x1)/A(1,2);
x22=(B(2)-A(2,1)*x1)/A(2,2);
x21=max(0,x21);
x22=max(0,x22);
plot(x1,x21,'r',x1,x22,'g');
title('x1 vs x2');
xlabel('x1');
ylabel('x2');

% Step 3: Find corner point with Axes.

C1=find(x1==0);
C2=find(x21==0);
C3=find(x22==0);

const1=[x1(:,[C1 C2]);x21(:,[C1,C2])];
const2=[x1(:,[C1 C3]);x22(:,[C1,C3])];

corpt=unique([const1,const2],'rows');

%Step 4: Find intersection Point
intpt=[];
for i=1:size(A,1)
    for j=i+1:size(A,1)
        a=[A(i,:);A(j,:)];
        b=[B(i);B(j)];
        X=a\b;
        if X>=0
          pt=X;
        else
          pt=[];
        end
        intpt=[intpt;pt];
    end
end
 
% Step 5: Write all points
allpt=[intpt;corpt];
u_pt=unique(allpt,'rows');

% Step 6: Find all feasible points
for i=1:size(A,1)
    constraint=A(i,1)*u_pt(:,1)+A(i,2)*u_pt(:,2)-B(i);
    NF=find(constraint>0);
    u_pt(NF,:)=[];
end
disp(u_pt)
FP=unique(u_pt,'rows');

%Step 7 : Find optimal Points for min and max
for i=1:size(FP,1)
    z(i,:)=FP(i,:)*C;
end
[opt_valmin,index]=min(z);
[opt_valma,index1]=max(z);
 opt_minpt=FP(index,:);
opt_maxpt=FP(index1,:);