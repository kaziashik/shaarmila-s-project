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
 
% 
% image=imresize (image, [256 256]); %all images except DWI hospital image
H=H+1;figure(H);imshow(image,[0 max(max(image))]);title('original image');
 
%% PRE-PROCESSING
disp('************ PRE-PROCESSING ***************');
Newbit=10;
[image]=preprocessing(image,Newbit);
H=H+1;figure(H);imshow(image);title('pre-processed image');

%% SEGMENTATION
disp('************ SEGMENTATION *****************');
    
    fprintf('1 = Bright FCM \n');% acute, hemorhhage and isles image
    fprintf('2 = Dark FCM \n');%chronic image
    selecttype = input('Type of FCM = ');
 
%% Bright FCM
    if  selecttype==1
        iteration=1;
        image1st=image;
        fim=mat2gray(image1st);
        [bwfim1,level1]=fcmthresh(fim,1);
        image1st=bwfim1.*image;
        imagebest=image1st;
        while 1
                iteration=iteration+1;
                fim=mat2gray(imagebest);
                [bwfim1,level1]=fcmthresh(fim,1);
                imagebest=bwfim1.*image;
               
                if iteration==3
                    break
                end
        end

        image=imagebest;
        fim=im2bw(image,0.01);
        fim=bwareaopen(fim,100,8);
        imageclearnoise=fim.*image;
 
        if sum(sum(imageclearnoise))~=0
           H=H+1;figure(H);imshow(imagebest);title('FCM Before Clear Noise');%bright roi
           image=imageclearnoise;
           H=H+1;figure(H);imshow(image);title('FCM After Clear Noise');%bright roi
        else
           H=H+1;figure(H);imshow(image);title('FCM');%bright roi
        end

        H=H+1;figure(H);imshow(image);title('FCM');%bright roi
        
        Imax=max(max(image));
        BWoutline = bwperim(image);
        Segout(BWoutline) = 1;
        H=H+1;figure(H); imshow(Segout); title('Brain Segmentation');
 
        fprintf('\n Max ROI intensity = %g\n',Imax);
        
%% Dark FCM
    elseif  selecttype==2
            iteration=1;
            [image,bound]= tambahan (image);%for dark roi only
            cal=sum(sum(bound));
            fim=mat2gray(image);
            [bwfim1,level1]=fcmthresh(fim,1);
            imagebest=~bwfim1.*image;
            image=imagebest;
    
            fim=im2bw(image,0.1);
            fim=bwareaopen(fim,200,8);
            image=fim.*image;
              H=H+1;figure(H);imshow(image);title('before active contour');
    fprintf('1 = Active Contour \n');
 
              center_bound = zeros(size(image));    
              center_bound(round(size(center_bound,1)/2)-5:round(size(center_bound,1)/2)+5,round(size(center_bound,2)/2)-5:round(size(center_bound,2)/2)+5) = 1;
             bw2=activecontour(image,center_bound);
             figure;imshow(bw2,[]);
             cal2=sum(sum(bw2))+cal;
 
 
             image=~bw2.*image;
            H=H+1;figure(H);imshow(image);title('after active contour');
            
            H=H+1;figure(H);imshow(image);title('FCM');%bright roi
            
    end
            
            Imax=max(max(image));
            BWoutline = bwperim(image);
            Segout(BWoutline) = 1;
            H=H+1;figure(H); imshow(Segout); title('Brain Segmentation');
            fprintf('\n Max ROI intensity = %g\n',Imax);         
            
 
%% FEATURES EXTRACTION
    disp('************ FEATURES EXTRACTION 1`***************');
    [filename,pathname]=uigetfile('*.mat','Select the .mat file');
    [~, name,~] = fileparts(filename);
    load([pathname,filename]);

    [Data] = classicalfeatures(image);

%% Performance Verification
disp('************ PERFORMANCE VERIFICATIONS ***************');
clockin=clock;
mstop=clockin(6)+clockin(5)*60+clockin(4)*60*60;
simtime=mstop-mstart;


