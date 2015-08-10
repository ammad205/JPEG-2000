function [ img_result ] = Inv_DWT( img_DWT , levels)

siz = size (img_DWT);
if (length(siz) == 2)
    siz(3) = 1;
end
%% After IDWT I
img_result = (img_DWT);
for i = levels:-1:1 
    A = floor (siz(1)/(2^(i-1)));
    B = floor (siz(2)/(2^(i-1)));

    img_result0 = img_result(1:A, 1:B,:);
    img_result1 = myiDWT2_haar( img_result0, 1 );
    img_result(1:A, 1:B,:) = img_result1;
end

end

