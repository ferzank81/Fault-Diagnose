% Cascade Forward Neural Network 

function CFNN = mCascadeForwardNeuralNetwork(feat,label,opts)
% Parameters
Hidden_size   = [10,10];
Max_epochs    = 50; 
kfold         = 10; 
tf            = 2;

if isfield(opts,'kfold'), kfold = opts.kfold; end
if isfield(opts,'ho'), ho = opts.ho; end
if isfield(opts,'tf'), tf = opts.tf; end
if isfield(opts,'H'), Hidden_size = opts.H; end
if isfield(opts,'Maxepochs'), Max_epochs = opts.Maxepochs; end

% Layer
if length(Hidden_size) == 1
  h1  = Hidden_size(1); 
  net = cascadeforwardnet(h1); 
elseif length(Hidden_size) == 2
  h1  = Hidden_size(1); 
  h2  = Hidden_size(2);
  net = cascadeforwardnet([h1 h2]);
  
elseif length(Hidden_size) == 3
  h1  = Hidden_size(1); 
  h2  = Hidden_size(2);
  h3  = Hidden_size(3);
  net = cascadeforwardnet([h1 h2 h3]);
end

pred2  = [];
ytest2 = []; 

% [Hold-out]
if tf == 1
  fold  = cvpartition(label,'HoldOut',ho); 
  K     = 1;
  
% [Cross-validation] 
elseif tf == 2
  fold  = cvpartition(label,'KFold',kfold);
  K     = kfold; 
  Afold = zeros(kfold,1);
end

for i = 1:K
  % Call train & test data
  trainIdx = fold.training(i); testIdx = fold.test(i);
  xtrain   = feat(trainIdx,:); ytrain  = label(trainIdx);
  xtest    = feat(testIdx,:);  ytest   = label(testIdx); 
  % Set Maximum epochs
  net.trainParam.epochs = Max_epochs; 
  % Training model
  net      = train(net, xtrain', dummyvar(ytrain)');
 
  % Perform testing
  pred     = net(xtest'); 
  % Confusion matrix
  [~, con] = confusion(dummyvar(ytest)',pred);
  % Get accuracy for each fold
  Afold(i) = sum(diag(con)) / sum(con(:));
  % Store temporary result for each fold
  pred2    = [pred2(1:end,:), pred];
  ytest2   = [ytest2(1:end); ytest];  
end
 view(net);
% Overall confusion matrix
[~, confmat] = confusion(dummyvar(ytest2)',pred2);
% confmat      = transpose(confmat);
% Average accuracy over k-folds
acc = mean(Afold); 
% Store results 
% CFNN.acc  = acc;
% CFNN.con  = confmat; 
%Tahmini çıktı matrisinin boyutunun düşürülmesi ve label formatına dönüştürülmesi
pred2 = (vec2ind(pred2))'; 
%Performans metrik sistemine sokulması
EVAL = Evaluate(ytest2,pred2);
CFNN.accuracy  = EVAL(1,1);
CFNN.sensitivity  = EVAL(1,2);
CFNN.precision = EVAL(1,4);
CFNN.f_measure  = EVAL(1,6);
CFNN.gmean  = EVAL(1,7);
CFNN.con  = confmat;
if tf == 1
  fprintf('\n Classification Accuracy (CFNN-HO): %g %%',100 * acc);
elseif tf == 2
  fprintf('\n Classification Accuracy (CFNN-CV): %g %%',100 * acc);
end
end

