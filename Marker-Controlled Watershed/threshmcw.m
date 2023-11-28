function [BW1,maskedImage1]=threshmcw(image,I2)
H=0;
% Threshold image - manual threshold
    BW1 = I2 > 0;
 
    % Erode mask with disk
    radius = 1;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW1 = imerode(BW1, se);
 
%     % Dilate mask with disk% flair chronic
%     BW1 = imdilate(BW1, se);

    % Create masked image.
    maskedImage1 = image;
    maskedImage1(~BW1) = 0;
    H=H+1;figure(H);
    imshow(maskedImage1);
    title('maskedImage1');
 
 