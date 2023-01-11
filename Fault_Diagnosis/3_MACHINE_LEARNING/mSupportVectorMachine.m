%[1999]-"An overview of statistical learning theory"

% Support vector machine (10/12/2020)

function SVM = mSupportVectorMachine(feat,label,opts)
% Default
fun   = 'r'; 
kfold = 10;
tf    = 2;

if isfield(opts,'kfold'), kfold = opts.kfold; end
if isfield(opts,'ho'), ho = opts.ho; end
if isfield(opts,'tf'), tf = opts.tf; end
if isfield(opts,'fun'), fun = opts.fun; end 

switch fun
  case 'l' ; fun = 'linear';     
  case 'r' ; fun = 'rbf'; 
  case 'p' ; fun = 'polynomial';   
  case 'g' ; fun = 'gaussian';
end

% Hold-out
if tf == 1
  fold = cvpartition(label,'HoldOut',ho);
  % Call train & test data
  xtrain = feat(fold.training,:); ytrain = label(fold.training);
  xtest  = feat(fold.test,:);     ytest2 = label(fold.test);
  % Train model
  My_Model = fitcsvm(xtrain,ytrain,'KernelFunction',fun);
  % Test 
  pred2    = predict(My_Model,xtest);
  % Accuracy
  Afold    = sum(pred2 == ytest2) / length(ytest2);

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
    My_Model = fitcsvm(xtrain,ytrain,'KernelFunction',fun);
    % Test 
    pred     = predict(My_Model,xtest); clear My_Model
    % Accuracy
    Afold(i) = sum(pred == ytest) / length(ytest);
    % Store temporary
    pred2    = [pred2(1:end); pred]; 
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
    My_Model = fitcsvm(xtrain,ytrain,'KernelFunction',fun);    
    % Test 
    pred     = predict(My_Model,xtest); clear My_Model
    % Accuracy
    Afold(i) = sum(pred == ytest) / length(ytest);
    % Store temporary
    pred2    = [pred2(1:end); pred]; 
    ytest2   = [ytest2(1:end); ytest];
  end
end    
% Confusion matrix
confmat = confusionmat(ytest2,pred2);
% Overall accuracy
acc = mean(Afold);
% Store
SVM.acc  = acc; 
SVM.con  = confmat; 

if tf == 1
  fprintf('\n Accuracy (SVM-HO): %g %%',100 * acc);
elseif tf == 2
  fprintf('\n Accuracy (SVM-CV): %g %%',100 * acc);
elseif tf == 3
  fprintf('\n Accuracy (SVM-LOO): %g %%',100 * acc);
end 
end

