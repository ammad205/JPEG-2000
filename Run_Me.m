
%% Project Title: Image Compression using DWT (Roughly JPEG 2000)
%% Digital Image Processing Project

%% Name1: Muhammad Saqlain                      Name2: Rai Ammad Khan
%% Roll No: 2013-10-0170                        Roll No: 2013-10-0205

clc
clear all
close all

%% Input Query Image From user
[FileName,PathName] = uigetfile('*.*','Select the image file');
img = imread([PathName FileName]);
siz = size (img);
if (length(siz) == 2)
    siz(3) = 1;
end
                    
img = double(img); 
%% Encoder
[Img_Y_DWT_Quant_enc, Img_Chroma1_DWT_Quant_enc ,Img_Chroma2_DWT_Quant_enc, Tiles, transform_sel,levels,Parts0,Parts1,Parts2 ] = Encoder( img );

%% Decoder
img_decoded = Decoder(Img_Y_DWT_Quant_enc, Img_Chroma1_DWT_Quant_enc ,Img_Chroma2_DWT_Quant_enc, Tiles, transform_sel,levels,siz );

%%

siz_dec = size (img_decoded );
if (length(siz_dec) == 2)
    siz_dec(3) = 1;
end
img_1 = img(1:siz_dec(1), 1:siz_dec(2), :);

[ mse ] = MSE( img_1 , img_decoded );
img_decoded = uint8(img_decoded);
figure;
subplot (1,2,1)
imshow (uint8(img));
title ('Origonal Image')
subplot (1,2,2)
imshow (uint8(img_decoded));
title ('Image with Compression');

%% Compression Ration Calculation

 size_image0 = Compressed_size( Img_Y_DWT_Quant_enc);
 size_image1 = Compressed_size( Img_Chroma1_DWT_Quant_enc);
 size_image2 = Compressed_size( Img_Chroma2_DWT_Quant_enc);
 compressed_size = size_image0 + size_image1 + size_image2;
 input_size = siz(1)*siz(2)*siz(3);
 compression_ratio = input_size/compressed_size;