function [ img_out ] = DC_level_shift( img )
img = double (img(:,:,:));
img_out = img(:,:,:)- 128;
end

