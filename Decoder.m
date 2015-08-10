function  img_decoded = Decoder(Img_Y_DWT_Quant_enc, Img_Chroma1_DWT_Quant_enc ,Img_Chroma2_DWT_Quant_enc, Tiles, transform_sel,levels,siz )

%% Decoding

tile_size = 64;
Img_Y_DWT_Quant_dec(1:Tiles) = struct('dec',[]);
h = waitbar(0,'Decoding of Y component is being done please wait...');
for m = 1:Tiles
    NAMES = fieldnames(Img_Y_DWT_Quant_enc);
    Si = getfield(Img_Y_DWT_Quant_enc(m),NAMES{2});
    Img_Y_DWT_Quant_dec(m).dec= Inv_RLC(Img_Y_DWT_Quant_enc(m).enc,Si(1),Si(2));
    waitbar(m /Tiles)
end
close (h)
dumy = Inv_Tiling( Img_Y_DWT_Quant_dec , siz, tile_size);
 figure;
 imshow (uint8(dumy));
 title ('Y component of Image after Decoding')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Img_Chroma1_DWT_Quant_dec (1:Tiles) = struct('dec',[]);
h = waitbar(0,'Decoding of Chroma1 component is being done please wait...');
for m = 1:Tiles
    NAMES = fieldnames(Img_Chroma1_DWT_Quant_enc);
    Si = getfield(Img_Chroma1_DWT_Quant_enc(m),NAMES{2});
    Img_Chroma1_DWT_Quant_dec(m).dec = Inv_RLC(Img_Chroma1_DWT_Quant_enc(m).enc,Si(1),Si(2));
    waitbar(m /Tiles)
end
close (h)
if ((transform_sel == 3) || (transform_sel == 4))
     size02 = siz([1 2])./2;
     tile_size = 32;
 else 
     size02 = siz;
     tile_size = 64;
end
dumy = Inv_Tiling( Img_Chroma1_DWT_Quant_dec , size02, tile_size );
 figure;
 imshow (uint8(dumy));
 title ('Chroma 1 component of Image after Decoding')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Img_Chroma2_DWT_Quant_dec (1:Tiles) = struct('dec',[]);
h = waitbar(0,'Decoding of Chroma2 component is being done please wait...');
for m = 1:Tiles
    NAMES = fieldnames(Img_Chroma2_DWT_Quant_enc);
    Si = getfield(Img_Chroma2_DWT_Quant_enc(m),NAMES{2});
    Img_Chroma2_DWT_Quant_dec(m).dec= Inv_RLC(Img_Chroma2_DWT_Quant_enc(m).enc,Si(1),Si(2));
    waitbar(m /Tiles)
end
close (h)
if ((transform_sel == 3) || (transform_sel == 4))
     size02 = siz([1 2])./2;
     tile_size = 32;
 else 
     size02 = siz;
     tile_size = 64;
end
dumy = Inv_Tiling( Img_Chroma2_DWT_Quant_dec , size02, tile_size );
 figure;
 imshow (uint8(dumy));
 title ('Chroma 2 component of Image after Decoding')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tile_size = 64;

%% Inv_DWT-Haar Calculations

Img_dec_Y_Inv_DWT(1:Tiles) = struct('DWTY',[]);
h = waitbar(0,'Inverse DWT of Y component is being done please wait...');
for m = 1:Tiles
    Img_dec_Y_Inv_DWT(m).DWTY = Inv_DWT( Img_Y_DWT_Quant_dec(m).dec , levels );
    waitbar(m /Tiles)
end
close (h)
 dumy = Inv_Tiling( Img_dec_Y_Inv_DWT , siz, tile_size);
 figure;
 imshow (uint8(dumy));
 title ('Y component of Image after inverse DWT')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Img_dec_Chroma1_Inv_DWT(1:Tiles) = struct('Inv_DWT1',[]);
h = waitbar(0,'Inverse DWT of chroma1 component is being done please wait...');
for m = 1:Tiles
    Img_dec_Chroma1_Inv_DWT(m).Inv_DWT1 = Inv_DWT( Img_Chroma1_DWT_Quant_dec(m).dec, levels );
    waitbar(m /Tiles)
end
close (h)
if ((transform_sel == 3) || (transform_sel == 4))
     size02 = siz([1 2])./2;
     tile_size = 32;
 else 
     size02 = siz;
     tile_size = 64;
 end
 dumy = Inv_Tiling( Img_dec_Chroma1_Inv_DWT , size02, tile_size);
 figure;
 imshow (uint8(dumy));
 title ('Chroma 1 component of Image after inverse DWT')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Img_dec_Chroma2_Inv_DWT(1:Tiles) = struct('Inv_DWT2',[]);
h = waitbar(0,'Inverse DWT of chroma1 component is being done please wait...');
for m = 1:Tiles
    Img_dec_Chroma2_Inv_DWT(m).Inv_DWT2 = Inv_DWT( Img_Chroma2_DWT_Quant_dec(m).dec, levels );
    waitbar(m /Tiles)
end
close (h)
if ((transform_sel == 3) || (transform_sel == 4))
     size02 = siz([1 2])./2;
     tile_size = 32;
 else 
     size02 = siz;
     tile_size = 64;
 end
 dumy = Inv_Tiling( Img_dec_Chroma2_Inv_DWT , size02, tile_size);
 figure;
 imshow (uint8(dumy));
 title ('Chroma 2 component of Image after inverse DWT')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Upsampling of chroma components
if ((transform_sel == 3) ||(transform_sel == 4))
for m = 1:Tiles
   Img_dec_Chroma1_Inv_DWT(m).Inv_DWT1 = Up_sample( Img_dec_Chroma1_Inv_DWT(m).Inv_DWT1, 2 );
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for m = 1:Tiles
   Img_dec_Chroma2_Inv_DWT(m).Inv_DWT2 = Up_sample( Img_dec_Chroma2_Inv_DWT(m).Inv_DWT2, 2 );
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
tile_size = 64;
%% Inv_Tiling of tiled image

img_decoded_Y_InvDWT = Inv_Tiling (Img_dec_Y_Inv_DWT, siz,tile_size );
img_decoded_Chroma1_InvDWT = Inv_Tiling (Img_dec_Chroma1_Inv_DWT, siz,tile_size );
img_decoded_Chroma2_InvDWT = Inv_Tiling (Img_dec_Chroma2_Inv_DWT, siz,tile_size );

%% Component combining

    img_rough(:,:,1) = img_decoded_Y_InvDWT;
    img_rough(:,:,2) = img_decoded_Chroma1_InvDWT;
    img_rough(:,:,3) = img_decoded_Chroma2_InvDWT;
    dum_img = img_rough ; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inverse Color Transformation of image

   Img_Tiled_DC_Inv_trans = Inv_Comp_Transform (dum_img, transform_sel);
figure;
imshow (uint8(Img_Tiled_DC_Inv_trans));
title ('Image after Inverse Color Transformation')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inverse DC level shifting of image

   img_decoded = Inv_DC_level_shift(Img_Tiled_DC_Inv_trans);
figure;
imshow (uint8(img_decoded));
title ('Image after Inverse DC level Shifting')
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

