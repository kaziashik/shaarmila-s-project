function [imageout]=imagenhancement(imagein,Gamma,C,Nbit)
H=300;
fprintf('\n----- Image Enhancement using Power Law Transformation \n'); 
 
for i=1:(2^Nbit)-1
    LevelInp(i)=1/(2^Nbit)*i;
    LevelOut(i)=C*LevelInp(i)^Gamma;
end
 
[Ny,Nx]=size(imagein);
for k=1:Ny
    for n=1:Nx
        imageout(k,n)=C*imagein(k,n)^Gamma;
    end
end
 
 H=H+1;figure(H);plot(LevelInp,LevelOut);grid;
 title('Power-Law Transformation Response');
