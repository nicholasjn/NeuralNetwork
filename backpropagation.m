function backpropagation(p)

load fisheriris;
a=meas;
[rows,kolom]=size(a);
a(1:50,kolom+1)=1;
a(51:100,kolom+1)=2;
a(101:150,kolom+1)=3;

b(1:3:rows,:)=a(1:50,:);
b(2:3:rows,:)=a(51:100,:);
b(3:3:rows,:)=a(101:150,:);
data = b;
dataRow = floor(0.5 * rows);
dataTrain=data(1:floor(0.5*rows),:);
targetTrain = zeros(dataRow,3);

for k=1:dataRow
    targetTrain(k,dataTrain(k,kolom+1)) = 1;
end
%disp(targetTrain);
in = dataTrain;
t = targetTrain;
epoch = 0;
stop = false;
columns = 3;
%a = 0;
%n = input
%p = hidden
%m = output

%Fungsi Aktivasi
%f(x) = 1 / 1 + exp(-1 * x)

%Turunan Fungsi Aktivasi
%f'(x) = (fx) * (1 - f(x))

n = length(in(:,1));
m = length(t(:,1));
disp(m);

%Inisialisasi variabel dan array/matrix
v = zeros(n,p);
vj = zeros(n);
w = zeros(p,m);
wj = zeros(m);
%t = zeros(m,columns);
E = zeros(m,columns);
x = zeros(n,columns);
z = zeros(p,columns);
y = zeros(m,columns);
z_in = zeros(p,columns);
y_in = zeros(m,columns);

min_msse = 0.01;
max_epoch = rows;
alfa = 0.5;
error = zeros(columns);

deltaK = zeros(m);
deltaW = zeros(p,m);
deltaWo = zeros(m);

delta_in = zeros(p);
deltaJ = zeros(p);
deltaV = zeros(n,p);
deltaVo = zeros(p);

%Standarisasi input
for i = 1:n
    for j = 1:columns
        x(i,j) = (2*(in(i,j) - min(in(:,j))) / (max(in(:,j)) - min(in(:,j)))) - 1;
    end
end

%for k = 1:m
    %for j = 1:columns
        %t(k,j) = (2*(out(k,j) - min(out(:,j))) / (max(out(:,j)) - min(out(:,j)))) - 1;
    %end
%end

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
    for l = 1:columns
        %Proses feedforward

        %Unit hidden
        for j = 1:p
            sum = 0;
            for i = 1:n
                sum = sum + (x(i,columns)*v(i,j));
            end
            z_in(j,l) = vo + sum;
            z(j,l) = 1 / (1 + exp(-1*z_in(j,l)));
        end

        %Unit output
        for k = 1:m
            sum = 0;
            for j = 1:p
                sum = sum + (z(j,l)*w(j,k));
            end
            y_in(k,l) = wo + sum;
            y(k,l) = 1 / (1 + exp(-1*y_in(k,l)));
        end

        %Backpropagation of error
        %Unit output
        for k = 1:m
            deltaK(k) = (t(k,l) - y(k,l)) * (y(k,l) * (1-y(k,l)));
            for j = 1:p
                deltaW(j,k) = alfa * deltaK(k) * z(j,l);
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
            deltaJ(j) = delta_in(j) * (z(j,l) * (1-z(j,l)));
            for i = 1:n
                deltaV(i,j) = alfa * deltaJ(j) * x(i,l);
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
            E(k) = ((t(k,l) - y(k,l)) ^ 2);
            sum = sum + E(k);
        end
        error(l) = 0.5 * sum;
    end
    sum = 0;
    for o = 1:columns
        sum = sum + error(o);
    end
    Esum(epoch) = sum / columns;
    msse = Esum(epoch);
    %fprintf('\nTotal Error : ');
    %disp(msse);
    %fprintf('\nTotal epoch : ');
    %disp(epoch);

    if(msse < min_msse || epoch > max_epoch)
        stop = true;
        epoch = epoch - 1;
    end
end
finalError = msse;
disp(epoch)
disp(finalError);
figure();
plot(Esum);
grid
end