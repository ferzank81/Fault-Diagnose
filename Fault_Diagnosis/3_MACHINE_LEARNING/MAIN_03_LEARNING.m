

%Katırcıoğlu F, Cingiz Z. 
%Fault diagnosis for overcharge and undercharge conditions in refrigeration systems using infrared thermal images.
%Proceedings of the Institution of Mechanical Engineers, Part E: Journal of Process Mechanical Engineering. 
%2023;0(0). doi:10.1177/09544089221148065

%---Input-------------------------------------------------------------
% feat       : feature vector matrix (Instances x Features)
% label      : label matrix (Instances x 1)
% opts       : parameter settings 
% opts.tf    : choose either hold-out / k-fold / leave-one-out
% opts.ho    : ratio of testing data in hold-out validation
% opts.kfold : number of folds in k-fold cross-validation


%---Output-------------------------------------------------------------
% ML      : machine learning model (It contains several results)
% ML.acc  : classification accuracy 
% ML.con  : confusion matrix
% ML.t    : computational time (s)
%----------------------------------------------------------------------

close all;
clear all;
clc;
% metric_data=zeros(4,7);%Performance metric results will be displayed in this variable.

%%1. Machine learning model 1: K-nearest neighbor (KNN) with k-fold cross-validation
% Parameter settings
opts.tf    = 2;     
opts.kfold = 10;    
opts.k     = 5;     % k-value in KNN
% Load data
% load iris.mat; 
% load Cikis_Veri_Seti_02pca.mat;
load Cikis_Veri_Seti_01rf.mat;
% Classification
ML = jml('knn',feat,label,opts);

metric_data(1,:)=ML;
% accuracy = ML.accuracy; 
%Confusion matrix
confmat  = ML.con;

figure, confusionchart(confmat,{'NC', 'UC', 'OC'});

%% 2. Machine learning model 2: Naive Bayes Algorithm (NBA)
% Parameter settings
opts.tf    = 2;     
opts.kfold = 10;    

% Load data
load Cikis_Veri_Seti_02pca.mat;
% load Cikis_Veri_Seti_01rf.mat;
% load iris.mat; 
% Classification
ML = jml('nb',feat,label,opts);
%Performance metric results will be displayed in this variable.
metric_data(2,:)=ML;
% Accuracy
% accuracy = ML.accuracy; 
% Confusion matrix
confmat  = ML.con;
figure, confusionchart(confmat,{'NC','UC','OC'})


%% %% 3. Machine learning model 3: Decision Tree (DT) with leave-one-out validation
% Parameter settings
opts.tf     = 2;  
opts.kfold = 10; 
opts.nSplit = 50;    % number of split in DT 
% Load data
% load Cikis_Veri_Seti_02pca.mat;
load Cikis_Veri_Seti_01rf.mat;
% load iris.mat; 
% Classification
ML = jml('dt',feat,label,opts);

%Performance metric results will be displayed in this variable.
metric_data(3,:)=ML;
% Accuracy
accuracy = ML.accuracy; 
% Confusion matrix
confmat  = ML.con;
figure, confusionchart(confmat,{'NC','UC','OC'})
%% %% 4. Machine learning model 3: Cascade Forward Neural Network Decision Tree (CFNN) with leave-one-out validation

% Load data
% load Cikis_Veri_Seti_02pca.mat;
load Cikis_Veri_Seti_01rf.mat;
% load iris.mat; 
% Perform neural network 
opts.tf        = 2;
opts.kfold     = 10;
opts.H         = [10, 10];
% opts.num_spread = 1; 
NN = jnn('cfnn',feat,label,opts);

%Performance metric results will be displayed in this variable.
metric_data(4,:)=NN;

% Accuracy
accuracy = NN.accuracy; 
% Confusion matrix
confmat  = NN.con;
figure, confusionchart(confmat,{'NC','UC','OC'})


