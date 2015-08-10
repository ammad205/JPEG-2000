function [ img_DWT, Parts ] = DWT( img , levels )


x = levels*4 - (levels - 1);
Parts(1:x) = struct('parts',[]);
Parts0(1:levels) = struct('part0',[]);
img_scaled = img;

for i = 1:levels
    [ img_scaled,img_H_wave,img_V_wave,img_D_wave ] = myDWT2_haar( img_scaled );
    img_DWT = [img_scaled img_H_wave; img_V_wave img_D_wave];
    Parts(x-0-3*(i-1)).parts = img_D_wave;
    Parts(x-1-3*(i-1)).parts = img_V_wave;
    Parts(x-2-3*(i-1)).parts = img_H_wave;
    Parts0(i).part0 = img_DWT;
end
Parts(1).parts = img_scaled;

if (levels >= 2)
    for  j = levels:-1:2
        s = Parts0(j).part0;
        siz = size (s);
        img_DWT = Parts0(j-1).part0;
        img_DWT(1:siz(1), 1:siz(2)) = s;
        Parts0(j-1).part0 = img_DWT;
    end
end
end