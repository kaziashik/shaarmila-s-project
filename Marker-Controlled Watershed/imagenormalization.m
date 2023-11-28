function [imageout]=imagenormalization(imagein,Nbit)
 
fprintf('\n----- Image Normalization \n'); 
 
imageout=double(imagein)/((2^Nbit)-1);
ColorMax=max(max(imageout));
fprintf('\t\t max normalized intensity = %g\n', ColorMax);
