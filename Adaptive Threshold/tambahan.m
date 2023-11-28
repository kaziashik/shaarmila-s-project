function [image,image3] = tambahan (image)
H=50;
[Ny,Nx]=size(image);
 
image2=image;
image3=zeros(size(image));
w=4;
p=w+2;
for i=10:Ny
    for j=10:Nx-1
        if (image(i,j)==0 && image(i,j+1)~=0)
            image2(i,j:j+w)=0;
            image3(i,j:j+p)=1;
        end
        if (image(i,j)==0 && image(i,j-1)~=0)
            image2(i,(j-w):j)=0;
            image3(i,(j-p):j)=1;
        end
            
    end
end
 
image=image2;

