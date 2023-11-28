function [HistXaxis,HistdataMax]= ImageBlockAnalysis(ImageBlock,Ndiv,XShift,YShift,Newbit)
H=300;
[Nz,Nx,Ny]=size(ImageBlock);
H=H+1;figure(H);
 
for z=1:Nz
    newimage(1:Nx,1:Ny)=ImageBlock(z,1:Nx,1:Ny);
    subplot(Ndiv,Ndiv,z,'FontSize',5);imshow(newimage,[0.1 0.7]);
    title(z);
end
 
 
disp('----- Calculating histogram');
H=H+1;figure(H);
 
for z=1:Nz
    myimage(1:Nx,1:Ny)=ImageBlock(z,1:Nx,1:Ny);
    [Sum_Pixels,Pixel_intens] = imhist(myimage,2^Newbit);
    Sum_Pixels(length(Sum_Pixels))=0;
    subplot(Ndiv,Ndiv,z,'FontSize',5);
    plot(Pixel_intens,smooth (Sum_Pixels,30));
    title(z);
     HistData0(z,:)=Sum_Pixels;
end
 
HistXaxis=Pixel_intens;
 
N1=45;  %region abnormal
N2=37;
N3=1;
N4=1;
N5=1;
N6=1;
N7=1;
N8=1;
N9=1;
 
B1=44;     %   region normal
B2=52;
B3=53;
B4=36;
B5=27;
B6=1;
 
HistData=HistData0;
HistData(N1,:)=0; % to assign normal histogram
HistData(N2,:)=0;
HistData(N3,:)=0;
HistData(N4,:)=0;
HistData(N5,:)=0;
HistData(N6,:)=0;
HistData(N7,:)=0;
HistData(N8,:)=0;
HistData(N9,:)=0;
[Nz,Nx]=size(HistData);
RangeROI=zeros(Nx,1);  % to mark abnormal histogram range
 
for n=1:Nx
    ROINormal=[HistData(B1,n),HistData(B2,n),HistData(B3,n),HistData(B4,n),HistData(B5,n),HistData(B6,n)];
    MaxNormal(n)=max(ROINormal);
    ROIData1=[HistData0(N1,n),HistData0(N2,n),HistData0(N3,n),HistData0(N4,n),HistData0(N5,n)];
    ROIData2=[HistData0(N6,n),HistData0(N7,n),HistData0(N8,n),HistData0(N9,n)];
    a= max(ROIData1);
    b= max(ROIData2);
    MaxROI(n)=max(a,b);
    HistdataMax(n)=max(HistData0(:,n));
end
 
MaxNormal(1)=0;
MaxROI(1)=0;
M=50;
MaxNormal=smooth(MaxNormal,M);
MaxROI=smooth(MaxROI,M);
for n=1:Nx
    if ((MaxNormal(n)==0) && (MaxROI(n)>0))
        RangeROI(n)=5;
    end
end
 
% H=H+1;figure(H);hold on;
% plot(HistXaxis,MaxNormal,'g');
% plot(HistXaxis,MaxROI,'r');
% plot(HistXaxis,RangeROI,'b');hold off;
 
title('Range of Abnormal ROI');
 
HistdataMax(1)=0;
M=50;
HistdataMax=smooth(HistdataMax,M);
% H=H+1;figure(H);plot(HistXaxis, HistdataMax,'g');
% title('Maximum block histogram');
