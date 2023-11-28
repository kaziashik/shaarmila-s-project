function [CutHigh, CutLow]=Autothreshold (x2,Z)
%Finding the automatic thresholding values
H=400;
Ny=length(Z);
[a,Normalpeak]=max(Z);

for i=2:Ny
    Div(i)=Z(i-1)-Z(i);
end

Div=10*smooth(Div,50);
H=H+1;figure(H);plot(x2,Z);title('Histogram ROI');
H=H+1;figure(H);plot(x2,Div,'g');title('Divergence');

Tri=0;
Divthres=0.15;
Divthresd=0.15;
for i=Normalpeak+50:Ny       
    if (abs(Div(i)) <= Divthres)&& (Tri==0)
        CutHigh=i;
        Tri=1;
    end
end
Tri=0;
for i=Normalpeak-50:-1:1      
    if (abs(Div(i)) <= Divthresd)&& (Tri==0)
        CutLow=i;
        Tri=1;
    end
end
Normalpeak=Normalpeak/(Ny-1);
CutHigh =CutHigh /(Ny-1);
CutLow =CutLow /(Ny-1);

fprintf('\n\t\t Normal Peak = %g', Normalpeak );
fprintf('\n\t\t Max Cut off = %g', CutHigh );
fprintf('\n\t\t Min Cut off = %g\n', CutLow );