% K-nearest neighbor (10/12/2020)

function KNN = mKNearestNeighbor(feat,label,opts)
% Default 
tf    = 2;
k     = 5; 
kfold = 10;

if isfield(opts,'kfold'), kfold = opts.kfold; end
if isfield(opts,'ho'), ho = opts.ho; end
if isfield(opts,'tf'), tf = opts.tf; end
if isfield(opts,'k'), k = opts.k; end

% Hold-out
if tf == 1
  fold = cvpartition(label,'HoldOut',ho);
  % Call train & test data
  xtrain = feat(fold.training,:); ytrain = label(fold.training);
  xtest  = feat(fold.test,:);     ytest2 = label(fold.test);
  % Train model
  My_Model = fitcknn(xtrain,ytrain,'NumNeighbors',k);
  % Test 
  pred2 = predict(My_Model,xtest);
  % Accuracy
  Afold = sum(pred2 == ytest2) / length(ytest2);
  
% Cross-validation
elseif tf == 2
  % [Cross-validation] 
  fold   = cvpartition(label,'KFold',kfold);
  Afold  = zeros(kfold,1); 
  pred2  = [];
  ytest2 = []; 
  for i = 1:kfold
    % Call train & test data
    trainIdx = fold.training(i); testIdx = fold.test(i);
    xtrain   = feat(trainIdx,:); ytrain  = label(trainIdx);
    xtest    = feat(testIdx,:);  ytest   = label(testIdx);
    % Train model
    My_Model = fitcknn(xtrain,ytrain,'NumNeighbors',k);
    % Test 
    pred = predict(My_Model,xtest); clear My_Model
    % Accuracy
    Afold(i) = sum(pred == ytest) / length(ytest);
    % Store temporary
    pred2  = [pred2(1:end); pred]; 
    ytest2 = [ytest2(1:end); ytest];
  end
  
% Leave-one-out
elseif tf == 3
  fold      = cvpartition(label,'LeaveOut');
  % Size of data
  num_data  = length(label);
  Afold     = zeros(num_data,1); 
  pred2     = [];
  ytest2    = []; 
  for i = 1:num_data
    % Call train & test data
    trainIdx = fold.training(i); testIdx = fold.test(i);
    xtrain   = feat(trainIdx,:); ytrain  = label(trainIdx);
    xtest    = feat(testIdx,:);  ytest   = label(testIdx); 
    % Train model
    My_Model = fitcknn(xtrain,ytrain,'NumNeighbors',k);
    % Test 
    pred = predict(My_Model,xtest); clear My_Model
    % Accuracy
    Afold(i) = sum(pred == ytest) / length(ytest);
    % Store temporary
    pred2  = [pred2(1:end); pred]; 
    ytest2 = [ytest2(1:end); ytest];
  end
end
% Confusion matrix
confmat = confusionmat(ytest2,pred2);
% figure,confusionchart(ytest,pred)

% Overall accuracy
acc = mean(Afold);
% Sınıflandırmanın metriklere sokulması
EVAL = Evaluate(ytest2,pred2);
KNN.accuracy  = EVAL(1,1);
KNN.sensitivity  = EVAL(1,2);
KNN.precision = EVAL(1,4);
KNN.f_measure  = EVAL(1,6);
KNN.gmean  = EVAL(1,7);
KNN.con  = confmat;

if tf == 1
  fprintf('\n Accuracy (KNN-HO): %g %%',100 * acc);
elseif tf == 2
  fprintf('\n Accuracy (KNN-CV): %g %%',100 * acc);
elseif tf == 3
  fprintf('\n Accuracy (KNN-LOO): %g %%',100 * acc);
end
end

