function [I2,fgm]=mcwatershed(image)

H=400;
% Step 2: Use the Gradient Magnitude as the Segmentation Function
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(image), hy, 'replicate');
Ix = imfilter(double(image), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
H=H+1;figure(H);
imshow(gradmag,[]); title('Gradient magnitude (gradmag)');
%  
L = watershed(gradmag);
Lrgb = label2rgb(L);
H=H+1;figure(H); imshow(Lrgb); title('Watershed transform of gradient magnitude (Lrgb)');
 
% Step 3: Mark the Foreground Objects
% se = strel('disk', 15);%isles database
% se = strel('disk', 7);%DWI A & FLAIR Chronic
% se = strel('disk', 15);%isles database
se = strel('disk', 15);%DWI H
Io = imopen(image, se);
H=H+1;figure(H);
imshow(Io); title('Opening (Io)');
 
Ie = imerode(image, se);
Iobr = imreconstruct(Ie, image);
H=H+1;figure(H);
imshow(Iobr); title('Opening-by-reconstruction (Iobr)');
 
Ioc = imclose(Io, se);
H=H+1;figure(H);
imshow(Ioc); title('Opening-closing (Ioc)');
 
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
H=H+1;figure(H);
imshow(Iobrcbr); title('Opening-closing by reconstruction (Iobrcbr)');
 
fgm = imregionalmax(Iobrcbr);
H=H+1;figure(H);
imshow(fgm); title('Regional maxima of opening-closing by reconstruction (fgm)');
 
I2 = image;
% I2(fgm) = 0;%dwi chronic
I2(~fgm) = 0;% dwi h,isles & flair chronic
H=H+1;figure(H);
imshow(I2); title('Regional maxima superimposed on original image (I2)');
 
%     D = bwdist(~fgm);
%     H=H+1;figure(H);
%     imshow(D,[],'InitialMagnification','fit'); 
%     title('Distance transform of ~fgm');
%     
%     D=~D;
%     D(~fgm)=0;
    L = watershed(I2);
    L(~fgm)=0;
    Lrgb = label2rgb(L, 'jet', 'w','shuffle');
    H=H+1;figure(H);
    imshow(Lrgb,'InitialMagnification','fit');
    title('Colored watershed label matrix (Lrgb)');
% 
    H=H+1;figure(H);
    imshow(image)
    hold on
    himage = imshow(Lrgb);
    himage.AlphaData = 0.5;
    title('Lrgb superimposed transparently on original image');

%     I3 = image;
% I3(~L) = 0;% dwi h,isles & flair chronic
% H=H+1;figure(H);
% imshow(I3); 
% title('Regional maxima superimposed on original image (I3)');
