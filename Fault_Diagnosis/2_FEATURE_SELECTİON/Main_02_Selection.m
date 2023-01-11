%Katırcıoğlu F, Cingiz Z. 
%Fault diagnosis for overcharge and undercharge conditions in refrigeration systems using infrared thermal images.
%Proceedings of the Institution of Mechanical Engineers, Part E: Journal of Process Mechanical Engineering. 
%2023;0(0). doi:10.1177/09544089221148065
close all;
clear all;
clc;
% Feature Selection
 
%---Usage-------------------------------------------------------------
% If you wish to use Relief-F (RF) then you may write
% FS = jffs('rf',feat,label,opts);


%---Input-------------------------------------------------------------
% feat    : Feature vector matrix (Instances x Features)
% label   : Label matrix (Instances x 1)
% opts    : Parameter settings 
% opts.Nf : Number of selected features


%---Output------------------------------------------------------------
% FS    : Feature selection model (It contains several results)
% FS.sf : Index of selected features
% FS.ff : Selected features. Seçme işleminden sonraki veri seti
% FS.nf : Number of selected features
% FS.s  : Weight or score
% Acc   : Accuracy of validation model


%% Example : Relief-F 
% Parameters
opts.K  = 3;     % NCA ve rf için yakın komşu sayısı
opts.Nf = 25;    % Seçilecek özellik adedi girilmelidir

% Load dataset
load Giris_Veri_Seti.mat; 


%%1. numaralı Relief algoritması kullanılarak seçim yöntemi
FS     = jffs('rf',feat,label,opts);
feat=FS.ff;
label=FS.l;
save ('Cikis_Veri_Seti_01rf.mat', 'feat', 'label');

%%2. numaralı PCA algoritması kullanılarak seçim yöntemi
FS     = jpca(feat,label,opts);
feat=FS.ff;
label=FS.l;
save ('Cikis_Veri_Seti_02pca.mat', 'feat', 'label');



