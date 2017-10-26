load fisheriris;
a=meas;
[rows,columns]=size(a);
a(1:50,columns+1)=1;
a(51:100,columns+1)=2;
a(101:150,columns+1)=3;

b(1:3:rows,:)=a(1:50,:);
b(2:3:rows,:)=a(51:100,:);
b(3:3:rows,:)=a(101:150,:);

database=b;
train=0.5;
test=1-train;
Ntrain=floor(train*rows);
dataTrain=database(1:floor(train*rows),:);
dataTest=database(floor(train*rows)+1:rows,:);

alpha=0.3;
V=rand(5,10)-0.5;
W=rand(11,3)-0.5;
targetTrain=zeros(floor(train*rows),3);
for k=1:Ntrain
    targetTrain(k,dataTrain(k,columns+1))=1;
end

e=1;

% for k=1:Ntrain
k=1;
    x=[1 dataTrain(k,1:columns)];
    zin=zeros(1,10);
    for L=1:10
        for M=1:5
        zin(L)=zin(L)+x(M)*V(M,L);
        end
    end
    z=[1 1./(1+exp(-zin))];
    yin=zeros(1,3);
    for L=1:3
        for M=1:11
        yin(L)=yin(L)+z(M)*W(M,L);
        end
    end
    y=[1./(1+exp(-yin))];
    yo=zeros(1,3);
    yo(find(y==max(y)))=1;
%     backward
%e=sum(1/2*(target(k,:)-y).^2);
% end
% while e>0.001
% end



% database=xlsread('iris.xlsx');