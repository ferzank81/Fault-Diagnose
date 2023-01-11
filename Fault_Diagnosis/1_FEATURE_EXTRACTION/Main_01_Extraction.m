%Katırcıoğlu F, Cingiz Z. 
%Fault diagnosis for overcharge and undercharge conditions in refrigeration systems using infrared thermal images.
%Proceedings of the Institution of Mechanical Engineers, Part E: Journal of Process Mechanical Engineering. 
%2023;0(0). doi:10.1177/09544089221148065


clear all;
close all;
clc;
%Be sure to define the path of the folder where the images are located correctly.
% addpath('./lowRank/');
files = dir('C:\Users\ferzan\Desktop\MATWORKS\FEATURE_EXTRACTION\giris/*.bmp');
data=zeros(180,50);
for i = 1:length(files)
    img = (imread(['C:\Users\ferzan\Desktop\MATWORKS\FEATURE_EXTRACTION\giris/' files(i).name]));
    image=rgb2gray(img);
%      image=img;
    Img2 = Bol_Belirleme(image);
    X=Img2;
    %Splitting the infrared image into 4 subcomponents using 2D-DWT
   [c,s]=wavedec2(X,2,'haar');
   [H1,V1,D1] = detcoef2('all',c,s,1);
   A1 = appcoef2(c,s,'haar',1);

LL = uint8(wcodemat(A1,255,'mat',1));
LH =uint8( wcodemat(H1,255,'mat',1));
HL = uint8(wcodemat(V1,255,'mat',1));
HH = uint8(wcodemat(D1,255,'mat',1));
j=1;
data= feature_Ex(X,i,j, data);
j=11;
data= feature_Ex(LL,i,j, data);
j=21;
data= feature_Ex(LH,i,j, data);
j=31;
data= feature_Ex(HL,i,j, data);
j=41;
data= feature_Ex(HH,i,j, data);



end


% NORMALIZATION OF THE DATA OBTAINED AND LABEL ASSIGNMENT
min_v=min(data(:,:));
max_v=max(data(:,:));
[m n]=size(data);
for i=1: m
    for j=1:n
        feat(i,j)=(data(i,j)-min_v(1,j))/(max_v(1,j)-min_v(1,j));
        if(i<=60)
        label(i,1)=1;
%         elseif(i>30 & i<=60)
%         label(i,1)=2;
%         elseif(i>60 & i<=90)
%         label(i,1)=3;
%         elseif(i>90 & i<=120)
%         label(i,1)=4;
        elseif(i>60 & i<=120)
        label(i,1)=2;
        else
        label(i,1)=3;
        end
    end
end

save('Giris_Veri_Seti.mat','feat','label');
