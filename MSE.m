function [ mse ] = MSE( Image_Data, quantized_img )

siz_In = size(Image_Data);
if (length(siz_In) == 2)
    siz_In(3)=1;
end

err = (Image_Data(:,:,:) - quantized_img(:,:,:)).^2;
mse = sum(err(:))/(siz_In(1)*siz_In(2));
end

