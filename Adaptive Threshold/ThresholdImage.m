function [image1,image2]=ThresholdImage(image,MinVal,MaxVal);
[Ny,Nx]=size(image);
image1=image;
image2=image;
for k=1:Ny
    for n=1:Nx
        if ((image(k,n) < MaxVal) || (image(k,n) > 0.9))
            image1(k,n)=0; % bright case
        end
    end
end
for k=1:Ny
    for n=1:Nx
        if ((image(k,n) < 0.05) || (image(k,n) > MinVal))
            image2(k,n)=0; % dark case
        end
    end
end
    %Min_val=0.01;Max_val=0.29; %dark roi
    %Min_val=0.49;Max_val=1; %bright roi