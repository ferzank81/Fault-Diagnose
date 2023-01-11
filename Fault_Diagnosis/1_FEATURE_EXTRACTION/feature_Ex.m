function data= feature_Ex(img,i,j,data)
%%Feature Extraction

% Create the Gray Level Cooccurance M_Eatrices (GLCMs)
 glcms = graycomatrix(img);
%Evaluate 10 features from the disease affected region only
% Derive Statistics from GLCM
  stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');
  %textural features : 
  FE.Contrast = stats.Contrast;
  FE.Correlation = stats.Correlation;
  FE.Energy = stats.Energy;
  FE.Homogeneity = stats.Homogeneity;
  
  FE.Mean = mean2(img);
  FE.StD = std2(img);
  FE.Entropy = entropy(img);
  FE.Kurtosis = kurtosis(double(img(:)));
  FE.Skewness = skewness(double(img(:)));
  FE.RMS = mean2(rms(img));
data(i,j)=FE.Contrast;
data(i,j+1)=FE.Correlation;
data(i,j+2)=FE.Energy;
data(i,j+3)=FE.Homogeneity;
data(i,j+4)=FE.Mean;
data(i,j+5)=FE.StD;
data(i,j+6)=FE.Entropy;
data(i,j+7)=FE.Kurtosis;
data(i,j+8)=FE.Skewness;
data(i,j+9)=FE.RMS;
%    feat_disease = [Contrast,Correlation,Energy,Homogeneity, Mean, Standard_Deviation, Entropy, RMS, Kurtosis, Skewness];
end

