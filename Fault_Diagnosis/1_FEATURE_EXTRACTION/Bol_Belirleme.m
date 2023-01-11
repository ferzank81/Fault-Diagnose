function Img2 = Bol_Belirleme(image)


resim=image; %Referans görüntü gelecek;%Referans görüntü

satir = 8;
sutun = 5;
I=image;
[satirlar, sutunlar]=size(I);
 mr = round(satirlar/satir); % median of rows
 mc = round(sutunlar/sutun); % median of columns
     
mr1=mr;
sayac2=0;
sayac3=1;
for i = 1 : mr : satirlar-2
    if(sayac2==satir-1)
            mr1=satirlar;
        end
    mc1=mc;
    sayac1=0;
    
    for j = 1 : mc : sutunlar-2
        if(sayac1==sutun-1)
            mc1=sutunlar;
        end

         image1(:,:)=I(i:mr1, j:mc1);
         
         %--------------------------------------
        
         
         %--------------------------------
         Img1{sayac3}=image1; %Görüntüleri bölgelere göre numaralandırma
         
%        %-------------------------------  
        
         mc1=mc1+mc;
         sayac1=sayac1+1;
         sayac3=sayac3+1;
    end
    mr1=mr1+mr;
    sayac2=sayac2+1;
end
%Seçilmiş bölgeleri numaralandırma ve bölgeleri çizme
% 
% 
%  figure,  imshow(I);
% hold on;
% for row = 1 : satirlar/satir : satirlar
%     line([1, sutunlar], [row, row], 'Color', 'r', 'LineWidth', 1);
% end
% for col = 1 : sutunlar/sutun : sutunlar
%     line([col, col], [1, satirlar], 'Color', 'r', 'LineWidth', 1);
% end
% hold off;

%Seçilen bölgeler dışında görüntüyü kesme
Img2=I;
 mr1=mr;
sayac2=0;
sayac3=1;
for i = 1 : mr : satirlar-2
    if(sayac2==satir-1)
            mr1=satirlar;
        end
    mc1=mc;
    sayac1=0;
    
    for j = 1 : mc : sutunlar-2
        if(sayac1==sutun-1)
            mc1=sutunlar;
        end

         
         
         %--------------------------------------
        
         if(sayac3==12 || sayac3==13 ||sayac3==14 ||sayac3==17 || sayac3==18 || sayac3==19 ||sayac3==22 ||sayac3==23||sayac3==24 ||sayac3==25 ||sayac3==28||sayac3==29 ||sayac3==30)
          
       
        else 
         %--------------------------------
         Img2(i:mr1, j:mc1)=255; %Görüntüleri bölgelere göre numaralandırma
         end
%        %-------------------------------  
        
         mc1=mc1+mc;
         sayac1=sayac1+1;
         sayac3=sayac3+1;
    end
    mr1=mr1+mr;
    sayac2=sayac2+1;
end
%  figure,  imshow(Img2);