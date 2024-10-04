function [common,specific,enmat] = W_dysentropy(mat)
%mat: timepoints*roi
len = size(mat,1);
cols = size(mat,2);
enmat = zeros(1,cols);

common = zeros(1,cols);
specific = zeros(1,cols);

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

common(1,col) = (sum(seires == 2) + sum(seires == 3))/len;
specific(1,col) = (sum(seires == 1) + sum(seires == 4))/len;
    
    %s_c(1,col) = specific(1,col) / common(1,col);
    
  
%     seires = mat(:,col);
%     entro = 0;
%     c = sum(seires == 2) + sum(seires == 3);
%     for ind = 2:3
%         p = sum(seires == ind)/c;
%         if p ~= 0 
%         entro = p*log2(p) + entro;
%         end
%     end
%     common_entro(1,col) = -entro;
%     
%     seires = mat(:,col);
%     entro = 0;
%     s = sum(seires == 1) + sum(seires == 4);
%     for ind = 1:3:4
%         p = sum(seires == ind)/s;
%         if p ~= 0 
%         entro = p*log2(p) + entro;
%         end
%     end
%     specific_entro(1,col) = -entro;      
% end
% 
% common(isinf(common)) = 0;
% specific(isinf(specific)) = 0;
%enmat = zscore(enmat);
% common = zscore(common);
% specific = zscore(specific);
% for row = 1 :len

%     
%     seires = mat(row,:);
%     entro = 0;
%     for ind = min(mat(:)):max(mat(:))
%         p = sum(seires == ind)/cols;
%         if p ~= 0 
%         entro = p*log2(p) + entro;
%         end
%     end
%     enmat_spatial(row,1) = -entro;
% end
end

