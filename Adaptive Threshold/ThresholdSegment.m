function [Imagebright, Imagedark]=ThresholdSegment(image)
 
Ndiv=8;XShift=0;YShift=0;Newbit=10;
[ImageBlock]=Image_block(image,Ndiv,XShift,YShift);
[HistXaxis,HistdataMax]=ImageBlockAnalysis(ImageBlock,Ndiv,XShift,YShift,Newbit);
[MaxVal, MinVal]=Autothreshold (HistXaxis,HistdataMax)
 
fprintf('Default MinVal=0.325513 \n');
fprintf('Default MaxVal=0.502444 \n');
% MinVal=input('Minimum Value = ');
% MaxVal=input('Maximum Value = ');
 
% MinVal=0.19957;% chronic FLAIR Stroke Image
% MaxVal=0.20816;% chronic FLAIR Stroke Image
% MinVal=0.38902;% Acute & Hemorrhage FLAIR Stroke Image
% MaxVal=0.40847;% Acute & Hemorrhage FLAIR Stroke Image
MinVal=0.316716; % ACH DWI Hospital Database
MaxVal=0.497556;% ACH DWI Hospital Database

[Imagebright, Imagedark]=ThresholdImage(image,MinVal,MaxVal);
 
fprintf('\t\t\n Minimum Threshold Value = %g\n', MinVal);
fprintf('\t\t\n Maximum Threshold Value = %g\n', MaxVal);
