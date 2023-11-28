function [MAPE_pixel, MAPE_mean,Nseg,Nref,Meanseg,Meanref] = CalUnsupervisedEval(Ref_Image,AutoImage)

RefImage=GroundthruthSegment(Ref_Image,AutoImage);

% Reference Image
[Nx,Ny]=size(RefImage);
Nref=0;
Meanref=0;
for k=1:Nx
    for n=1:Ny
        if RefImage(k,n)>0
            Nref=Nref+1;
            Meanref=Meanref+RefImage(k,n);
        end
    end
end
Meanref=Meanref/Nref;

Stdref=0;
for k=1:Nx
    for n=1:Ny
        if RefImage(k,n)>0
        Stdref=Stdref+(RefImage(k,n)-Meanref)^2;
        end
    end
end
Stdref=sqrt(Stdref/Nref);

% Segmentation Image
[Nx,Ny]=size(AutoImage);
Nseg=0;
Meanseg=0;
for k=1:Nx
    for n=1:Ny
        if AutoImage(k,n)>0
            Nseg=Nseg+1;
            Meanseg=Meanseg+AutoImage(k,n);
        end
    end
end
Meanseg=Meanseg/Nseg;

Stdseg=0;
for k=1:Nx
    for n=1:Ny
        if AutoImage(k,n)>0
        Stdseg=Stdseg+(AutoImage(k,n)-Meanseg)^2;
        end
    end
end
Stdseg=sqrt(Stdseg/Nseg);

MAPE_pixel=abs((Nref-Nseg))/Nref;
MAPE_mean=100*abs((Meanseg-Meanref))/Meanref;

disp('----------------------------------------------');
fprintf('\t\t\n pixel count segment = %g\n', Nseg);
fprintf('\t\t\n pixel count ref = %g\n', Nref);
fprintf('\t\t\n mean segment = %g\n', Meanseg);
fprintf('\t\t\n mean ref = %g\n', Meanref);
disp('----------------------------------------------');


