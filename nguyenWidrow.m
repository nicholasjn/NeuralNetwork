function vij = nguyenWidrow(p, n)
    beta = 0.7 * (p ^ (1/n));
    %disp(beta)
    fprintf('\n\n');
    
    for j = 1:p
        for i = 1:n
            vij(j,i) = (-0.5 + rand);
            %disp(vij(j,i))
        end 
        sum = 0;
        for a = 1:p
            sum = sum + power(vij(j,a),2);
        end
        vj(j) = sqrt(sum);
        for i = 1:p
            vij(j,i) = (beta * vij(j,i))/vj(j);
            disp(vij(j,i))
        end
        voj = (-beta + ((2*beta)*rand));
        
    end
    
end