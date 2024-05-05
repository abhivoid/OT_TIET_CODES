clc
clear all

%max Z= 4x1-3x2
%x1 - x2 >= 0; 2x1 - x2>=2; x1,x2>=0

var = {'x1','x2','s1','s2','A1','A2','sol'};
M=1000;
C= [-4 +3 0 0 -M -M 0];
coeff= [1 -1 -1 0 1 0 ;2 -1 0 -1 0 1];
B= [0; 2];
s= eye(size(coeff,1));
A= [coeff B];

%Finding starting BFS
BV= [];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i) == s(:,j)
            BV = [BV i];
        end
    end
end

% value of table
B = A(:, BV);
A = inv(B)*A;
ZjCj = C(BV) *A-C;

ZCj= [ZjCj; A];
SimplexTable= array2table(ZCj);
SimplexTable.Properties.VariableNames(1:size(ZCj,2)) = var


%Simplex Method Starts
Run = true;
while Run
    ZC= ZjCj(:,1:end-1);
    if any(ZC<0)
        fprintf('BFS not optimal');
        [Entval, pvt_col]= min(ZC);
        fprintf('Entering Column = %d\n', pvt_col);

        %leaving variable
        sol= A(:,end);
        Column= A(:,pvt_col);
        if all(Column)<=0
            fprintf('Solution is UNBOUNDED\n');
        else
            for i=1:size(Column,1)
                if Column(i)>0
                    ratio(i)= sol(i)./Column(i);
                else
                    ratio(i)= inf;
                end
            end
            [minR, pvt_row]= min(ratio);
            fprintf('\nLeaving Row= %d\n', pvt_row);

            %update table
            BV(pvt_row)= pvt_col;
            B= A(:,BV);
            A= inv(B)*A;
            ZjCj= C(BV)*A- C;
            ZCj= [ZjCj; A];
            SimplexTable= array2table(ZCj);
            SimplexTable.Properties.VariableNames(1:size(ZCj,2)) = var;
        end
        else
        Run = false;
        fprintf('===============Current BFS is Optimal=============');
    end
    ZjCj
    A
end

%Final_Bfs
final_bfs= zeros(1,size(A,2));
final_bfs(BV)= A(:,end);
final_bfs(end)= sum(final_bfs.*C);

OptimalBFS= array2table(final_bfs);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2))= var;

OptimalBFS