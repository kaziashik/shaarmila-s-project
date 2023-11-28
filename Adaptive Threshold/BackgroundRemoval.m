function [imageout]=BackgroundRemoval(imagein0,type)
%type = 1 for background white
%type = 0 for background Black
H=200;
Threshold=0.023;% Acute, Chronic and Hemorrhage DWI Stroke
% Threshold=0.26275;%AH Flair Hospital
fprintf('\n----- Separating brain from background \n');
fprintf('\t\t threshold Value =  %g\n', Threshold); 
BW = im2bw(imagein0,Threshold);
[B,Image_Bwd] = bwboundaries(BW);
 
[K,L]=size(Image_Bwd);
for k=1:K
  for l=1:L
      if Image_Bwd(l,k)>0.5
          Image_Bwd(l,k)=1;
      else
          Image_Bwd(l,k)=0;
      end
  end
end
 
fprintf('\n----- Small pixels removal \n');
BW2 = bwareaopen(Image_Bwd,500);
 
[K,L]=size(BW2);
for k=1:K
  for l=1:L
      if BW2(l,k)==0
          imageout(l,k)=type;
      else
          imageout(l,k)=imagein0(l,k);
      end
  end
end
H=H+1;figure(H);imshow(Image_Bwd);
title('background removal');
H=H+1;figure(H);imshow(BW2);
title('after small pixel removal');


