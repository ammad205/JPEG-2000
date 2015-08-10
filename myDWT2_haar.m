function [ img_scaled,img_H_wave,img_V_wave,img_D_wave ] = myDWT2_haar( img )

[ img_scal, img_wave ] = dwt_haar( img );
flag = 1;

% flag = 0 for down sampling in rows
% flag = 1 for down sampling in colums

img_out_scal = Down_sample( img_scal , flag);
img_out_wave = Down_sample( img_wave , flag);

flag = 0;
img_out_scal = img_out_scal';
[ img_scal, img_wave ] = dwt_haar( img_out_scal );
img_scal = img_scal';
img_wave = img_wave';
img_scaled = Down_sample( img_scal , flag);
img_H_wave = Down_sample( img_wave , flag);

img_out_wave = img_out_wave';
[ img_scal, img_wave ] = dwt_haar( img_out_wave );
img_scal = img_scal';
img_wave = img_wave';
img_V_wave = Down_sample( img_scal , flag);
img_D_wave = Down_sample( img_wave , flag);
end