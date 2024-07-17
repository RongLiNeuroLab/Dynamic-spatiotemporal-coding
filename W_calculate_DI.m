function [DI,within_similarity, between_similarity] = W_calculate_DI(mat)
%input:similarity matrix(100*100)
%output:DI = differential identifiabilty

if any(isnan(mat))
    error('Find NaN value,check your data!');
end
if all(diag(mat))
    mat = mat - diag(ones(100,1));
end
within_similarity = [];

start = 1;
for i = 1:10
    sub = squareform(mat(start:start+9,start:start+9));
    within_similarity = [within_similarity,sub];
    mat(start:start+9,start:start+9) = nan;
    start = start+10;
end
mat(isnan(mat)) = 0;
between_similarity = squareform(mat);
between_similarity(between_similarity == 0) = [];
DI = mean(within_similarity)-mean(between_similarity);

end

