function backpropfinal()

% load fisheriris;
a=xlsread('Data.xlsx',1);
a2=xlsread('Data.xlsx',2);
[rows,columns]=size(a);
[rowsb,columnsb]=size(a2);
% a(1:50,columns+1)=1;
% a(51:100,columns+1)=2;
% a(101:150,columns+1)=3;
% 
% b(1:3:rows,:)=a(1:50,:);
% b(2:3:rows,:)=a(51:100,:);
% b(3:3:rows,:)=a(101:150,:);
% %'jumlah kolom data latihan :'
 dataRow = floor(0.5 * rows);
 targetRow= floor(0.5 * rowsb);
% %'jumlah baris data latihan :'
 dataTrain=a(1:dataRow,:);
 targetTrain=a2(1:targetRow,:);
% % targetTrain = zeros(3,dataRows);
% 
%  for k=1:dataRow
%      targetTrain(dataTrain(k,columns+1),k) = 1;
%  end
in = dataTrain;
t = targetTrain;
epoch = 0;
stop = false;

%n = input5
%p = hidden
%m = output

l = length(in(:,1));
n = length(in(1,:));
m = length(t(1,:));
q = length(t(:,1));
p = input('Input jumlah Hidden layer : ');
% disp(l);
% disp(n);
% disp(m);
% disp(q);


%Inisialisasi variabel dan array/matrix
v = zeros(n,p);
vj = zeros(n);
w = zeros(p,m);
wj = zeros(m);
E = zeros(m);
x = zeros(l,n);
z = zeros(p);
y = zeros(m);
z_in = zeros(p);
y_in = zeros(m);

min_msse = input('input error rate yang diinginkan : ');
alfa = input('input alfa : ');
error = zeros(l);
msse = 100;

deltaK = zeros(m);
deltaW = zeros(p,m);
deltaWo = zeros(m);

delta_in = zeros(p);
deltaJ = zeros(p);
deltaV = zeros(n,p);
deltaVo = zeros(p);

%Normalisasi input
for i = 1:l
    for j = 1:n
        x(i,j) = (2*(in(i,j) - min(in(:,j))) / (max(in(:,j)) - min(in(:,j)))) - 1;
    end
end

%step 0
%Inisialisasi bobot dengan metode nguyem widrom
beta = 0.7 * (p ^ (1/n));
vo = (-beta + ((2*beta)*rand));
wo = (-beta + ((2*beta)*rand));
for j = 1:p
    for i = 1:n
        v(i,j) = -0.5 + ((0.5+0.5)*rand);
    end 
    sum = 0;
    for i = 1:n
        sum = sum + power(v(i,j),2);
    end
    vj(j) = sqrt(sum);
    for i = 1:n
        v(i,j) = (beta * v(i,j)) / vj(j);
    end
end

for k = 1:m
    for j = 1:p
        w(j,k) = -0.5 + ((0.5+0.5)*rand);
    end 
    sum = 0;
    for j = 1:p
        sum = sum + power(w(j,k),2);
    end
    wj(k) = sqrt(sum);
    for j = 1:p
        w(j,k) = (beta * w(j,k)) / wj(k);
    end
end

while(stop == false)
    epoch = epoch + 1;
    for q = 1:l
        %Proses feedforward

        %Unit hidden
        for j = 1:p
            sum = 0;
            for i = 1:n
                sum = sum + (x(q,i)*v(i,j));
            end
            z_in(j) = vo + sum;
            z(j) = 1 / (1 + exp(-1*z_in(j)));
        end

        %Unit output
        for k = 1:m
            sum = 0;
            for j = 1:p
                sum = sum + (z(j)*w(j,k));
            end
            y_in(k) = wo + sum;
            y(k) = 1 / (1 + exp(-1*y_in(k)));
        end

        %Backpropagation of error
        %Unit output
        for k = 1:m
            deltaK(k) = (t(k) - y(k)) * (y(k) * (1-y(k)));
            for j = 1:p
                deltaW(j,k) = alfa * deltaK(k) * z(j);
            end
            deltaWo(k) = alfa * deltaK(k);
        end

        %Unit hidden
        for j = 1:p
            sum = 0;
            for k = 1:m
                sum = sum + (deltaK(k) * w(j,k));
            end
            delta_in(j) = sum;
            deltaJ(j) = delta_in(j) * (z(j) * (1-z(j)));
            for i = 1:n
                deltaV(i,j) = alfa * deltaJ(j) * x(q,i);
            end
            deltaVo(j) = alfa * deltaJ(j);
        end
        %Update bobot 
        for k = 1:m
            for j = 1:p
                w(j,k) = w(j,k) + deltaW(j,k);
            end
            wo = wo + deltaWo(k);
        end
        for j = 1:p
            for i = 1:n
                v(i,j) = v(i,j) + deltaV(i,j);
            end
            vo = vo + deltaVo(j);
        end
        %Menghitung total Error
        sum = 0;
        for k = 1:m
            E(k) = ((t(k) - y(k)) ^ 2);
            sum = sum + (0.5 * E(k));
        end
        error(q) = sum;
    end
    sum = 0;
    for k = 1:l
        sum = sum + error(k);
    end
    disp(sum)
    Esum(epoch) = sum;
    msse = Esum(epoch);
    %clc
    %fprintf('\nTotal Error : ');
    %disp(msse);
    %fprintf('\nTotal epoch : ');
    %disp(epoch);

    if(msse < min_msse)
        stop = true;
    end
end
finalError = msse;
fprintf('\nTotal epoch : ');
disp(epoch);
 fprintf('\nTotal Error : ');
disp(finalError);
figure();
plot(Esum);
grid
end