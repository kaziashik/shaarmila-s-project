function Data=PerfVerification (AutoImage, ManualImage)

[AO,FPR,FNR,D,Overlap]=CalSupervisedEval(ManualImage,AutoImage);
fprintf('\t\t\n Area Overlap (AO) = %g\n', AO);
fprintf('\t\t\n Over segmentation (FPR) = %g\n', FPR);
fprintf('\t\t\n Under Segmentation (FNR) = %g\n', FNR);
fprintf('D = %g/100\n', round(D));

[ROI,Mean,Nseg,Nref,Meanseg,Meanref]=CalUnsupervisedEval(ManualImage,AutoImage);
%fprintf('\t\t\n Pixel error = %g\n', ROI);
fprintf('\t\t\n Mean Absolute Percentage Error = %g\n', Mean);
fprintf('PE = %g\n', ROI);
fprintf('MAPE = %g\n', Mean);

Data(1,1)=AO;Data(1,2)=FPR;Data(1,3)=FNR;Data(1,4)=D;
Data(2,1)=ROI;Data(2,2)=Mean;Data(3,1)=Nseg;Data(3,2)=Nref;Data(3,3)=Meanseg;Data(3,4)=Meanref;