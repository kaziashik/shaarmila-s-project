clear all;
close all;
clc;
 
H=0;
clockin=clock;
mstart=clockin(6)+clockin(5)*60+clockin(4)*60*60;
 
%% DATA LOADING
disp('************ DATA LOADING ***************')

% Step 1: Load Image and Reference Image
[fn pn] = uigetfile('./*.dcm','select Dicom file');
complete1 = strcat(pn,fn);
image = dicomread(complete1);
 
% 
image=imresize (image, [256 256]); %all images except DWI hospital image
H=H+1;figure(H);imshow(image,[0 max(max(image))]);title('original image');

%% PRE-PROCESSING
disp('************ PRE-PROCESSING ***************');
Newbit=10;
[image]=preprocessing(image,Newbit);
H=H+1;figure(H);imshow(image);title('pre-processed image');

%% SEGMENTATION
disp('************ SEGMENTATION *****************');

[image,bound]= tambahan (image);%for dark roi only
cal=sum(sum(bound));
fim=mat2gray(image);
[I2,fgm]=mcwatershed(image);

% Threshold image - manual threshold
    binaryImage = I2 <0.3098;
    maskedImage = I2;
    maskedImage(~binaryImage) = 0;
    H=H+1;figure(H);
    imshow(maskedImage);
    title('maskedImage');

    image=maskedImage;



    fprintf('1 = Bright Lesion \n');% acute, hemorhhage and isles dwi & flair image
    fprintf('2 = Dark Lesion \n');%chronic dwi image
    selecttype = input('Type of Lesion = ');  

if  selecttype==1
    
%     Threshold image - manual threshold
%     binaryImage = I2 >0.49;% DWI A DATABASE
%             binaryImage = I2 >0.4549;% DWI A DATABASE
%     binaryImage = I2 >0.46667;%DWI H 
    binaryImage = I2 >0.49804;% DWI ISLES
%     binaryImage = I2 >0.27843;
%     binaryImage = I2 >0.70588;%FLAIR A&H DATABASE
%     binaryImage = I2 >0.62745;%FLAIR ISLES (Newbit=16)
    % Create masked image.
    maskedImage = I2;
    maskedImage(~binaryImage) = 0;
    H=H+1;figure(H);
    imshow(maskedImage);
    title('maskedImage');

    image=maskedImage;

elseif  selecttype==2
    
    se2 = strel(ones(5,5));
    fgm2 = imclose(fgm, se2);
    fgm3 = imerode(fgm2, se2);
    fgm4 = bwareaopen(fgm3, 3);
    
    I2 = image;
    I2(fgm4) = 0;
    H=H+1;figure(H);
    imshow(I2);
    title('Modified regional maxima superimposed on original image (fgm4)');

                % Threshold image - manual threshold
    BW1 = I2 > 0;
 
    % Erode mask with disk
    radius = 3;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW1 = imerode(BW1, se);
 
    % Create masked image.
    maskedImage1 = image;
    maskedImage1(~BW1) = 0;
    H=H+1;figure(H);
    imshow(maskedImage1);
    title('maskedImage1');
    
    fprintf('1 = Yes \n');
    fprintf('2 = No \n');
    select = input('Does the brain image has CSF = ');
 
    if select == 1
        [maskedImage3]=maskCSF(BW1,I2,maskedImage1);
        image=maskedImage3;
 
    elseif  selecttype==2
        image=maskedImage1;
    end
       
end

%% FEATURES EXTRACTION
    disp('************ FEATURES EXTRACTION ***************');
    [filename,pathname]=uigetfile('*.mat','Select the .mat file');
    [~, name,~] = fileparts(filename);
    load([pathname,filename]);
 
    [Data] = classicalfeatures(image);

%% Performance Verification

disp('************ PERFORMANCE VERIFICATIONS ***************');
clockin=clock;
mstop=clockin(6)+clockin(5)*60+clockin(4)*60*60;
simtime=mstop-mstart;
