function [I]=Inv_RLC(D,row,col)

[rD,cD]=size(D);
k=0;
for i=1:rD
    
    nemo=mod(i,2);
    if (nemo==0)
        k=k+1;
        I(k,1)=D(i,1);
    else
        bb=D(i,1);
        for ii=1:bb
            k=k+1;
            I(k,1)=0;
        end
    end
end

I = reshape(I,row,col);
% figure;imshow(I,[0 255]); title('Reconstructed')
end