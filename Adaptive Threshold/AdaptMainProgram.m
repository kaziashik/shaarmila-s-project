clear all;
close all;
clc;
 
H=0;
clockin=clock;
mstart=clockin(6)+clockin(5)*60+clockin(4)*60*60;
 
%% DATA LOADING
disp('************ DATA LOADING ***************')

[fn pn] = uigetfile('./DCM/*.dcm','select Dicom file');
complete1 = strcat(pn,fn);
image = dicomread(complete1);

H=H+1;figure(H);imshow(image,[0 max(max(image))]);title('original image');
[counts2,x2]=imhist(image);counts2(1)=0;%Hospital Database
Z = smooth(counts2,10);%Hospital Database
H=H+1;figure(H);plot(x2,Z,'g');title('histogram original image');
% 

%% PRE-PROCESSING
disp('************ PRE-PROCESSING ***************');
Newbit=10;
image=imresize (image, [256 256]); %all images except DWI hospital image
[image]=preprocessing(image,Newbit);
H=H+1;figure(H);imshow(image);title('pre-processed image');

%% SEGMENTATION
disp('************ SEGMENTATION *****************');
 
Segout=image;

%     fprintf('1 = Bright ROI \n');% acute, hemorhhage and isles image
%     fprintf('2 = Dark ROI \n');%chronic image
%     selecttype = input('Type of ROI = ');
%  
%     
%     if  selecttype==1
        [Bright_roi,~]=ThresholdSegment(image);
        image=Bright_roi;   
        
%     elseif  selecttype==2
%             image = tambahan (image); %for dark roi only
%             [~,Dark_roi]=ThresholdSegment(image);
%             image=Dark_roi;  
% %             image=bwareaopen(image,100,8);
%         
% %     end

 
Imax=max(max(image));
H=H+1;figure(H); imshow(image,[]), title('ROI');
BWoutline = bwperim(image);
Segout(BWoutline) = 1;
H=H+1;figure(H); imshow(Segout); title('Brain Segmentation');
fprintf('\t\t\n Max ROI intensity = %g\n',Imax);
 
 
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
