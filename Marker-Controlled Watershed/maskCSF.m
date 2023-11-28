function [maskedImage3]=maskCSF(BW1,I2,maskedImage1)%Exclude CSF in chronic DWI image

H=0;
% Create empty mask.
BW2 = false(size(BW1));
 
% Flood fill CSF
row = 122;
column = 122;
tolerance = 6.000000e-02;
addedRegion = grayconnected(I2, row, column, tolerance);
BW2 = BW2 | addedRegion;
 
% Fill holes CSF
BW2 = imfill(BW2, 'holes');
 
% Invert mask CSF
BW2 = imcomplement(BW2);
 
% Create masked image CSF. 
maskedImage2 = maskedImage1;
maskedImage2(~BW2) = 0;
H=H+1;figure(H);
imshow(maskedImage2);
title('maskedImage2');
 
% Threshold image - manual threshold
BW3 = maskedImage2<0.31373;
 
% Create masked image CSF. 
maskedImage3 = maskedImage2;
maskedImage3(~BW3) = 0;
H=H+1;figure(H);
imshow(maskedImage3);
title('maskedImage3');