function [ img_out ] = Inv_DC_level_shift( img )
img = double (img(:,:,:));
img_out = 128 + img(:,:,:);
end

