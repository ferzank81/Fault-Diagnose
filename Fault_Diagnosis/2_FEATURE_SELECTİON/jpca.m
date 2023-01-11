function PCA = jpca(feat,label,opts)
if isfield(opts,'Nf'), noofdim = opts.Nf; end
img=feat;

[r,c] = size(feat);       
 %Calculate cov matrix and the PCA matrixes
m = mean(feat')';
 S = ((feat - m*ones(1,c)) * (feat - m*ones(1,c))');     
[Coeff latent]= eig(S);
[latent, ind] = sort(diag(latent), 'descend');
M1 = Coeff(:,ind(1:noofdim));


PCA.ff = M1;

PCA.f  = feat;
PCA.l  = label;
end

