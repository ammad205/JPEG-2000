function [D,siz01]=RLC(I)
siz01 = size(I);
Counter = 0;
k = 0;
for j = 1:siz01(2)
    for i = 1:siz01(1)        
        if (I(i,j)~=0)
        k = k+1;
        D(k,1)= Counter;
        k = k+1;
        D(k,1) = I(i,j);
        Counter = 0;
        else
        Counter = Counter+1;
        end    
    end
end
D(k+1,1) = Counter;
end