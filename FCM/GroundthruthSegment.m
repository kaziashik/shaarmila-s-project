function image=GroundthruthSegment(Image,Realimage)

[Ny Nx]=size(Image);
for i=1:Ny
    for j=1:Nx
        if Image(i,j)>0
            Image(i,j)=1;
        end
    end
end
image=Image.*Realimage;