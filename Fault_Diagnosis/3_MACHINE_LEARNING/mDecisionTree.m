% Decision Tree (10/12/2020)

function DT = mDecisionTree(feat,label,opts)
% Default 
num_split = 50; 
kfold     = 10; 
tf        = 2;

if isfield(opts,'kfold'), kfold = opts.kfold; end
if isfield(opts,'ho'), ho = opts.ho; end
if isfield(opts,'tf'), tf = opts.tf; end
if isfield(opts,'nSplit'), num_split = opts.nSplit; end 

% [Hold-out]
if tf == 1
  fold   = cvpartition(label,'HoldOut',ho); 
  % Call train & test data
  xtrain = feat(fold.training,:); ytrain = label(fold.training); 
  xtest  = feat(fold.test,:);     ytest2 = label(fold.test);
  % Perform decision tree
  Model = fitctree(xtrain,ytrain,'MaxNumSplits',num_split);
  % Test 
  pred2 = predict(Model,xtest);
  % Accuracy
  Afold = sum(pred2 == ytest2) / length(ytest2); 
  
% [Cross-validation]
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
    % Perform decision tree
    Model = fitctree(xtrain,ytrain,'MaxNumSplits',num_split);
    % Test 
    pred = predict(Model,xtest); clear Model
    % Accuracy
    Afold(i) = sum(pred == ytest) / length(ytest);
    % Store temporary
    pred2  = [pred2(1:end); pred]; 
    ytest2 = [ytest2(1:end); ytest];
  end
  
% [Leave one out]
elseif tf == 3
  fold     = cvpartition(label,'LeaveOut');
  % Size of data
  num_data = length(label); 
  Afold    = zeros(num_data,1);
  pred2    = [];
  ytest2   = []; 
  for i = 1:num_data
    % Call train & test data
    trainIdx = fold.training(i); testIdx = fold.test(i);
    xtrain   = feat(trainIdx,:); ytrain  = label(trainIdx);
    xtest    = feat(testIdx,:);  ytest   = label(testIdx); 
    % Perform decision tree
    Model = fitctree(xtrain,ytrain,'MaxNumSplits',num_split);
    % Test 
    pred = predict(Model,xtest); clear Model
    % Accuracy
    Afold(i) = sum(pred == ytest) / length(ytest);
    % Store temporary
    pred2  = [pred2(1:end); pred];
    ytest2 = [ytest2(1:end); ytest];
  end
end
% Confusion matrix
confmat = confusionmat(ytest2,pred2);
% Overall accuracy
acc = mean(Afold);
% Store results
EVAL = Evaluate(ytest2,pred2);
DT.accuracy  = EVAL(1,1);
DT.sensitivity  = EVAL(1,2);
DT.precision = EVAL(1,4);
DT.f_measure  = EVAL(1,6);
DT.gmean  = EVAL(1,7);
DT.con  = confmat;


if tf == 1
  fprintf('\n Accuracy (DT-HO): %g %%',100 * acc);
elseif tf == 2
  fprintf('\n Accuracy (DT-CV): %g %%',100 * acc);
elseif tf == 3
  fprintf('\n ccuracy (DT-LOO): %g %%',100 * acc);
end  
end

