function backpropagation(n,p,m)
%n = 2;
%p = 2;
%m = 2;
stop = false;
%a = 0;
%n = input
%p = hidden
%m = output

%Fungsi Aktivasi
%f(x) = 1 / 1 + exp(-1 * x)

%Turunan Fungsi Aktivasi
%f'(x) = (fx) * (1 - f(x))

%Inisialisasi variabel dan array/matrix
v = zeros(n);
vj = zeros(n);
%vo = zeros(n);
w = zeros(m);
%wo = zeros(m);
t = zeros(m);
E = zeros(m);
x = zeros(n);
z = zeros(p);
y = zeros(m);
z_in = zeros(p);
y_in = zeros(m);

deltaK = zeros(m);
deltaW = zeros(p,m);
deltaWo = zeros(m);

delta_in = zeros(p);
deltaJ = zeros(p);
deltaV = zeros(n,p);
deltaVo = zeros(p);

%step 0
%Inisialisasi bobot dengan metode nguyem widrom
beta = 0.7 * (p ^ (1/n));
%disp(beta)
fprintf('\n');

for j = 1:p
    for i = 1:n
        v(i,j) = (-0.5 + rand);
        %disp(v(i,j))
    end 
    sum = 0;
    for i = 1:n
        sum = sum + power(v(i,j),2);
    end
    vj(j) = sqrt(sum);
    for i = 1:n
        v(i,j) = (beta * v(i,j)) / vj(j);
        %disp(v(i,j))
    end
end
vo = (-beta + ((2*beta)*rand));

%step 1
%Nilai ini untuk testing
%Silahkan comment nilai ini jika ingin menggunakan dataset
v(1,1) = 0.15;
v(2,1) = 0.20;
v(1,2) = 0.25;
v(2,2) = 0.30;
w(1,1) = 0.40;
w(2,1) = 0.45;
w(1,2) = 0.50;
w(2,2) = 0.55;
x(1) = 0.05;
x(2) = 0.10;
%vo(1) = 0.35;
%vo(2) = 0.35;
vo = 0.35;
wo = 0.60;
%wo(1) = 0.60;
%wo(2) = 0.60;
t(1) = 0.01;
t(2) = 0.99;
alfa = 0.5;

while(stop == false)
    %step 2 : Proses feedforward
    
    %step 3 : Menerima input
    
    %step 4 (Unit hidden)
    fprintf('\nStep 4 \n');
    for j = 1:p
        fprintf('\nLoop %d\n', j);
        sum = 0;
        for i = 1:n
            sum = sum + (x(i)*v(i,j));
        end
        %disp(sum)
        z_in(j) = vo + sum;
        z(j) = 1 / (1 + exp(-1*z_in(j)));
        disp(z_in(j));
        disp(z(j));
    end
    %step 5
    fprintf('\nStep 5 \n');
    for k = 1:m
        fprintf('\nLoop %d\n', k);
        sum = 0;
        for j = 1:p
            sum = sum + (z(j)*w(j,k));
        end
        y_in(k) = wo + sum;
        disp(y_in(k));
        y(k) = 1 / (1 + exp(-1*y_in(k)));
        disp(y(k));
    end
    
    %Menghitung total Error
    sum = 0;
    for k = 1:m
        E(k) = 0.5 * ((t(k) - y(k)) ^ 2);
        sum = sum + E(k);
    end
    Esum = sum;
    fprintf('\nTotal Error : ');
    disp(Esum);
    
    if(Esum < 0.28)
        stop = true;
    end
    
    %step 6 (Backpropagation of error)
    fprintf('\nStep 6 \n');
    for k = 1:m
        fprintf('\nLoop %d\n', k);
        deltaK(k) = (t(k) - y(k)) * (y(k) * (1-y(k)));
        %disp(deltaK(k));
        for j = 1:p
            deltaW(j,k) = alfa * deltaK(k) * z(j);
            disp(deltaW(j,k))
        end
        deltaWo(k) = alfa * deltaK(k);
    end

    %step 7
    fprintf('\nStep 7 \n');
    for j = 1:p
        fprintf('\nLoop %d\n', j);
        sum = 0;
        for k = 1:m
            sum = sum + (deltaK(k) * w(j,k));
        end
        delta_in(j) = sum;
        deltaJ(j) = delta_in(j) * (z(j) * (1-z(j)));
        disp(deltaJ(j))
        for i = 1:n
            deltaV(i,j) = alfa * deltaJ(j) * x(i);
        end
        deltaVo(j) = alfa * deltaJ(j);
    end

    %step 8
    fprintf('\nStep 8 \n');
    fprintf('Output Layer\n');
    for k = 1:m
        fprintf('\nLoop %d\n', k);
        for j = 1:p
            w(j,k) = w(j,k) + deltaW(j,k);
            disp(w(j,k))
        end
        wo = wo + deltaWo(k);
    end
    fprintf('\nHidden Layer\n');
    for j = 1:p
        fprintf('\nLoop %d\n', j);
        for i = 1:n
            v(i,j) = v(i,j) + deltaV(i,j);
            disp(v(i,j))
        end
        vo = vo + deltaVo(j);
    end
end

end