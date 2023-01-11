function RF = jReliefF(feat,label,opts)
% Parameter
K = 5;

if isfield(opts,'Nf'), num_feat = opts.Nf; end
if isfield(opts,'K'), K = opts.K; end

% Convert format to categorical
label         = categorical(label); 
% Relief-F Algorithm
[idx, weight] = relieff(feat,label,K);
% Select features based on ranking
Sf            = idx(1:num_feat);
sFeat         = feat(:, Sf); 
% Store results 
RF.sf = Sf; 
RF.ff = sFeat; 
RF.l  = double(label);

end

