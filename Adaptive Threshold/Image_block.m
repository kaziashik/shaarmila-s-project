function [ImageBlock]=Image_block(norm_image,Ndiv,XShift, YShift)
disp('----- Devide Image');
[Nx,Ny]=size(norm_image);
Xdiv=Ndiv;
Ydiv=Ndiv;
Rx=Nx/Xdiv;
Ry=Ny/Ydiv;
N=1;
 
for Px=0:Xdiv-1
    for Py=0:Ydiv-1
        J=1;
        for j=(Px*Rx+1+XShift):(Px*Rx+1+XShift)+Rx-1
            if j > Nx
                j0=Nx;
            else
                j0=j;
            end
            K=1;
            for k=(Py*Ry+1+YShift):(Py*Ry+1+YShift)+Ry-1
             if k > Ny
                k0=Ny;
            else
                k0=k;
             end
                ImageBlock(N,J,K)=norm_image(j0,k0);
                K=K+1;
            end
            J=J+1;
        end
        N=N+1;
    end
end
