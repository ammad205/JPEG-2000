function [ img_result ] = myiDWT2_haar( img , levels )

siz = size (img);
if (length(siz) == 2)
    siz(3) = 1;
end
a = floor (siz(1)/(2^(levels)));
b = floor(siz(2)/(2^(levels)));


img_scaled  = img(1:a, 1:b, :);
img_H_wave  = img(1:a, b+1:2*b, :);
img_V_wave  = img(a+1:2*a, 1:b, :);
img_D_wave  = img(a+1:2*a, b+1:2*b, :);

% flag = 0 for up sampling in row direction
% flag = 1 for up sampling in column direction  

img_scaled = Up_sample( img_scaled ,0 );
img_H_wave = Up_sample( img_H_wave ,0 );
img_V_wave = Up_sample( img_V_wave ,0 );
img_D_wave = Up_sample( img_D_wave ,0 );

img_scaled = img_scaled';
img_H_wave = img_H_wave';
img_V_wave = img_V_wave';
img_D_wave = img_D_wave';

% flag0 = 0 for computing scaling factor 
% flag0 = 1 for computing wavelet factor 

 img_0  = idwt_haar( img_scaled , 0 );
 img_1  = idwt_haar( img_H_wave , 1 );
 img_2  = idwt_haar( img_V_wave , 0 );
 img_3  = idwt_haar( img_D_wave , 1 );

img_0 = img_0';
img_1 = img_1';
img_2 = img_2';
img_3 = img_3';

 img_result0 = img_0 + img_1;
 img_result1 = img_2 + img_3;

 img_result0 = Up_sample( img_result0 ,1 );
 img_result1 = Up_sample( img_result1 ,1 );
 
%%

img_result0  = idwt_haar( img_result0 , 0 );
img_result1  = idwt_haar( img_result1 , 1 );

img_result = img_result0 + img_result1 ;

end