function [AO,FPR,FNR,D,Overlap]=CalSupervisedEval(RefImage,AutoImage,H)
H=600;
RefImage=double(RefImage);
AutoImage=double(AutoImage);
[Nx,Ny]=size(RefImage);

for i=1:Nx
    for j=1:Ny
        if RefImage(i,j)~=0
            RefImage(i,j)=1;
        end
        if AutoImage(i,j)~=0
            AutoImage(i,j)=1;
        end
        
        if RefImage(i,j)==0 && AutoImage(i,j)==0
            Overlap(i,j)=0;
        elseif RefImage(i,j)==1 && AutoImage(i,j)==1 % area overlap
            Overlap(i,j)=1;
        elseif RefImage(i,j)==0 && AutoImage(i,j)==1 % oversegment
            Overlap(i,j)=0.25;
        elseif RefImage(i,j)==1 && AutoImage(i,j)==0  % undersegment
            Overlap(i,j)=0.75;
        end
    end
end

H=H+1;figure(H);imshow(Overlap,[0 max(max(Overlap))]); hold on;
ISect=0;
Union=0;
ISectcom=0;
ISectcom2=0;
for i=1:Nx
    for j=1:Ny
        ISect=ISect+RefImage(i,j)*AutoImage(i,j);
        ISectcom=ISectcom+RefImage(i,j)*(1-AutoImage(i,j));
        ISectcom2=ISectcom2+(1-RefImage(i,j))*(AutoImage(i,j));
        if (RefImage(i,j)==1)||(AutoImage(i,j)==1)
            Union=Union+1;
        end
    end
end
title ('Area Overlap');
AO=double(ISect/Union);
FPR=ISectcom2/Union;
FNR=ISectcom/Union;
D=double(((2*ISect)/((ISect)+(Union)))*100);

