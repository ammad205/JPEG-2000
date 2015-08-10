function [ img_out ] = Quantization( img,  dead_zone ) % step_siz

siz = size (img);
if (length(siz) == 2)
    siz(3) = 1;
end
img_out = zeros (siz(1),siz(2),siz(3)); 
for i=1:siz(1)
    for j=1:siz(2)
        if ((img (i,j,:) >= -dead_zone) &&  (img (i,j,:) <= dead_zone))
            img_out (i,j,:) = 0;
        else 
            img_out (i,j,:) = round (img(i,j,:));
        end
    end
end
% dum = abs(img);
% dum = dum > -dead_zone*step_siz;
% dum = dum.*img;
% img_out = sign(dum).*floor((abs(dum)+step_siz*dead_zone)./step_siz);

end

