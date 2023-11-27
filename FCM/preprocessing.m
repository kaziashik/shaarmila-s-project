function [image]=preprocessing(image,Newbit)
H=100;
type=0;
Gamma=0.4;C=1;
Max=max(max(image));%Hospital Database
Maxbit=round(log2(double(Max)));%Hospital Database
fprintf('\t\t max intensity =  %g\n', Max);%Hospital Database
fprintf('\t\t max Bit =  %g\n', Maxbit); %Hospital Database
  
[image]=imagenormalization(image,Newbit);
% H=H+1;figure(H);subplot(211);imshow(image,[0 max(max(image))]);title('image after normalization');
H=H+1;figure(H);imshow(image,[0 max(max(image))]);title('image after normalization');
% [counts3,x3]=imhist(image,2^Newbit);counts3(1)=0;
% Z = smooth(counts3,5);
% subplot(212);plot(x3,Z,'g');title('histogram after normalization');
%  
[image]=BackgroundRemoval(image,type);
% H=H+1;figure(H); subplot(211);imshow(image,[0 max(max(image))]);title('image after background removal');
H=H+1;figure(H);imshow(image,[0 max(max(image))]);title('image after background removal');%Hospital Database
% [counts3,x3]=imhist(image,2^Newbit);counts3(1)=0;%Hospital Database
% Z = smooth(counts3,5);%Hospital Database
% % subplot(212);plot(x3,Z,'g');title('histogram after background removal');
 
[image]=imagenhancement(image,Gamma,C,Newbit);
% H=H+1;figure(H);subplot(211);imshow(image,[0 max(max(image))]);title('image after gamma law');
H=H+1;figure(H);imshow(image,[0 max(max(image))]);title('image after gamma law');%Hospital Database
% [counts2,x2]=imhist(image,2^Newbit);counts2(1)=0;%Hospital Database
% Z = smooth(counts2,10);%Hospital Database
% % subplot(212);plot(x2,Z,'g');title('histogram after gamma law');
