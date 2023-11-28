function [data] = classicalfeatures(image)

disp('-----Calculating 1st order features');
H=100;
g=image; %duplicate I
n=0;
[Nx Ny]= size(image);
for j=1:Nx
    for k=1:Ny
       if image(j,k)~=0
           n=n+1;
           DataROI(n)=image(j,k);
       end
    end
end
N=n ; 
Mean=sum(DataROI)/N; %mean
NROI=N;

for i=1:N
    v(i)=(DataROI(i)-Mean)^2;
end
vari=sum(v)/N;  % varian
Stdev=sqrt(vari);  % stdeviation

for i=1:N
    skew(i)=((DataROI(i)-Mean)/Stdev)^3;
    kurt(i)=((DataROI(i)-Mean)/Stdev)^4;
end
skewness=sum(skew)/N;  % skewness
kurtosis=sum(kurt)/N - 3; % kurtosis

%**********************1st Order Textural Features************************
[Ny,Nx]=size(g);
ABS(1:Ny,1:Nx)=0;
for i=1+2:Ny-2
    for j=1+2:Nx-2
        ABS(i,j)=((g(i+2,j)-g(i-2,j))^2+(g(i,j+2)-g(i,j-2))^2)^0.5;        
    end
end

N=0;
for i=1:Ny
    for j=1:Nx
        N=N+1;        
    end
end
MGR= sum(sum(ABS))/N;

for i=1:Ny
    for j=1:Nx
        vgr(i,j)= (ABS(i,j)-MGR)^2;         
    end
end
VGR= sum(sum(vgr))/N;


g0(1:Ny,Nx)=0;
g1(1:Ny,Nx)=0.5;
k=1;
for i=2:Ny-1
    for j=2:Nx-1
        if (image(i,j) == 0) && (image(i,j+1) ~= 0)
            g0(i,j+1)=1;
        end
        if (image(i,j) == 0) && (image(i+1,j) ~= 0)
            g0(i+1,j)=1;
        end
        if (image(i,j) == 0) && (image(i,j-1) ~= 0)
            g0(i,j-1)=1;
        end
        if (image(i,j) == 0) && (image(i-1,j) ~= 0)
            g0(i-1,j)=1;
        end
        if (g0(i-1,j-1) == 1) 
            g1(i-1,j-1)= 0; %I(i,j) ;
        end
        if image(i,j)~= 0
        ModeROI0(k)=image(i,j);
        k=k+1;
        end
    end
end
g1=g0.*image;


H=H+1;figure(H);imshow(g0); title ('features boundary');
%figure(101);imshow(g1, 0.2);
Median=median(DataROI);
Perimeter=sum(sum(g0));
Compactness=Perimeter^2/NROI;
MeanBound=sum(sum(g1))/Perimeter;
ModeROI=mode(ModeROI0);

StdMode=((ModeROI-Mean)^2)^0.5/Mean*100;


%Contrast=contrast(DataROI)

fprintf('Mean = %g\n',Mean);
fprintf('Stdev = %g\n',Stdev);
fprintf('Median = %g\n',Median);
fprintf('ModeROI = %g\n',ModeROI);
fprintf('StdMode= %g\n',StdMode);
fprintf('MeanBound= %g\n',MeanBound);
fprintf('Area = %g\n',NROI);
fprintf('Perimeter = %g\n',Perimeter);
fprintf('Compactness = %g\n',Compactness);


%fprintf('\n');
fprintf('skewness = %g\n',skewness);
fprintf('kurtosis = %g\n',kurtosis);
fprintf('MGR = %g\n',MGR);
fprintf('VGR = %g\n',VGR);

data(1)=Mean;
data(2)=Stdev;
data(3)=Median;
data(4)=ModeROI;
data(5)=StdMode;
data(6)=MeanBound;
data(7)=NROI;
data(8)=Perimeter;
data(9)=Compactness;
data(10)=skewness;
data(11)=kurtosis;
data(12)=MGR;
data(13)=VGR;

