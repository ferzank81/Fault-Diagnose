% Özellik seçim fonksiyonları 

function model = jffs(type,feat,label,opts)
switch type
  case'nca'    ; fun = @jNeighborhoodComponentAnalysis;
  case'rf'     ; fun = @jReliefF; 
  case'mRMR'   ; fun=@jfscmrmr;
  case'pca'   ; fun=@jpca;
end

model = fun(feat,label,opts); 


end


