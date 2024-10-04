function [stable,dynamic,enmat] = W_dysentropy(mat)
%mat: timepoints*roi
len = size(mat,1);
cols = size(mat,2);
enmat = zeros(1,cols);

stable = zeros(1,cols);
dynamic = zeros(1,cols);

for col = 1 :cols
    seires = mat(:,col);
    entro = 0;
    for ind = min(mat(:)):max(mat(:))
        p = sum(seires == ind)/len;
        if p ~= 0 
        entro = p*log2(p) + entro;
        end
    end
    enmat(1,col) = -entro;

stable(1,col) = (sum(seires == 2) + sum(seires == 3))/len;
dynamic(1,col) = (sum(seires == 1) + sum(seires == 4))/len;
    


%     enmat_spatial(row,1) = -entro;
% end
end

