# Machine Learning Toolbox for Classification

---
> "Toward talent scientist: Sharing and learning together"
>  --- [Jingwei Too](https://jingweitoo.wordpress.com/)
---

![Wheel](https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/f9d2bb8c-ebfe-4590-b88c-d4ff92fa6f8f/c4229dd2-aaa5-4146-bafa-4fcccb2b1d30/images/screenshot.PNG) 

* This toolbox contains 8 widely used machine learning algorithms   

* The < A_Main.m file > provides the examples of how to use these methods on benchmark dataset 

* Main goals of this toolbox are:
  + Sharing knowledge on machine learning works
  + Helping others in machine learning projects

## Usage
The main function *jml* is used to perform the classification. You may switch the algorithm by simply changes the 'da' to [other abbreviations](/README.md#list-of-available-machine-learning-methods)   
* If you wish to use discriminate analysis ( DA ) classifier then you may write
```code 
ML = jml('da',feat,label,opts); 
```

* If you want to use naive bayes ( NB ) classifier then you may write
```code 
ML = jml('nb',feat,label,opts); 
```

## Input
* feat    : feature vector matrix ( Instance x Features )
* label   : label matrix ( Instance x 1 )
* opts    : parameter settings
  + tf    : choose either hold-out / *k*-fold / leave-one-out
  + ho    : ratio of testing data in hold-out validation
  + kfold : number of folds in *k*-fold cross-validation

## Output
* ML : Machine learning model ( It contains several results )  
  + acc : classification accuracy 
  + con : confusion matrix
  + t   : computational time (s)

## How to choose the validation scheme?
There are three types of performance validations. These validation strategies are listed as following. However, if you do not select any of them, then the algorithm will automatically perform 10-fold cross-validation as default. 
  + Hold-out validation
```code 
opts.tf    = 1;
opts.ho    = 0.3;   % 30% data for testing 
```
  + *K*-fold cross-validation
```code 
opts.tf    = 2
opts.kfold = 10;    % 10-fold cross-validation
```
  + Leave-one-out validation
```code 
opts.tf    = 3 
```
  

### Example 1 : *K*-nearest neighbor ( KNN ) with *k*-fold cross-validation
```code 
% Parameter settings
opts.tf    = 2;     
opts.kfold = 10;    
opts.k     = 3;     % k-value in KNN

% Load data
load iris.mat;

% Classification
ML = jml('knn',feat,label,opts);

% Accuracy
accuracy = ML.acc; 

% Confusion matrix
confmat  = ML.con;

```

### Example 2 : Multi-class support vector machine  ( MSVM ) with hold-out validation
```code 
% Parameter settings
opts.tf    = 1;     
opts.ho    = 0.3;       
opts.fun   = 'r';     % radial basis kernel function in SVM

% Load data
load iris.mat;

% Classification
ML = jml('msvm',feat,label,opts);

% Accuracy
accuracy = ML.acc; 

% Confusion matrix
confmat  = ML.con;

```

### Example 3 : Decision Tree ( DT ) with leave-one-out validation
```code 
% Parameter settings
opts.tf     = 3;          
opts.nSplit = 50;    % number of split in DT 

% Load data
load iris.mat;

% Classification
ML = jml('dt',feat,label,opts);

% Accuracy
accuracy = ML.acc; 

% Confusion matrix
confmat  = ML.con;

```


## Requirement
* MATLAB 2014 or above
* Statistics and Machine Learning Toolbox


## List of available machine learning methods
* Click on the name of algorithm to check the parameters 
* Use the *opts* to set the specific parameters  

| No. | Abbreviation | Name                                                                              | Support      |
|-----|--------------|-----------------------------------------------------------------------------------|--------------|
| 09  | 'gmm'        | Gaussian Mixture Model                                                            | Multi-class  |
| 08  | 'knn'        | [*K*-nearest Neighbor](/Description.md#k-nearest-neighbor-knn)                    | Multi-class  |
| 07  | 'msvm'       | [Multi-class Support Vector Machine](/Description.md#support-vector-machine-svm)  | Multi-class  |
| 06  | 'svm'        | [Support Vector Machine](/Description.md#support-vector-machine-svm)              | Binary class |
| 05  | 'dt'         | [Decision Tree](/Description.md#decision-tree-dt)                                 | Multi-class  |
| 04  | 'da'         | [Discriminate Analysis Classifier](/Description.md#discriminate-analysis-da)      | Multi-class  |
| 03  | 'nb'         | [Naive Bayes](/Description.md#naive-bayes-nb)                                     | Multi-class  |
| 02  | 'rf'         | [Random Forest](Description.md#random-forest-rf)                                  | Multi-class  |
| 01  | 'et'         | [Ensemble Tree](Description.md#ensemble-tree-et)                                  | Multi-class  |                  




