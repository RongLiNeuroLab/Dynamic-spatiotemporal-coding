function [dynamic_r,stable_r] = W_state_cooccurence(mat,flag)
% mat:states*roi

roi = size(mat,2);
stable_r = zeros(roi,roi);
dynamic_r = zeros(roi,roi);
stable_space = single(mat == 2 | mat == 3);
dynamic_space = single(mat == 1 | mat == 4);

for row = 1 : roi
    stable_a = stable_space(:,row);
    dynamic_a = dynamic_space(:,row);
    
    for col = 1 : roi
        if row < col
            stable_b= stable_space(:,col);
            dynamic_b = dynamic_space(:,col);
            
            stable_r(row,col) = (sum(mat(:,row) == 2 & mat(:,col) == 2) + sum(mat(:,row) == 3 & mat(:,col) == 3)) / sum(stable_a | stable_b);
            dynamic_r(row,col) = (sum(mat(:,row) == 1 & mat(:,col) == 1) + sum(mat(:,row) == 4 & mat(:,col) == 4)) / sum(dynamic_a | dynamic_b);

        end
    end
end
stable_r(isnan(stable_r)) = 0;
dynamic_r(isnan(dynamic_r)) = 0;
stable_r = stable_r + stable_r';
dynamic_r = dynamic_r + dynamic_r';

if flag == 1
    stable_r = squareform(stable_r);
    dynamic_r = squareform(dynamic_r);
end

end