function [ img_out ] = Inv_Comp_Transform( img, x )

siz = size (img);
if (length(siz) == 2)
    siz(3) = 1;
end
img_out = zeros(siz(1),siz(2),siz(3));

%% YC1C2 to RGB to  (approx. KLT)
if (x == 1)
    T_Matrix = [1 1 -2/3; 1 0 4/2 ; 1 -1 -2/4 ];
    for i = 1:siz(1)
        for j = 1:siz(2)
            B = img(i,j,:);
            C = double(B(:));
            img_out(i,j,:) = T_Matrix*C;  
        end
    end
end

%% YCoCg to RGB 
if (x == 2)
    T_Matrix = [1 1 -1; 1 0 1 ; 1 -1 -1 ];
    for i = 1:siz(1)
        for j = 1:siz(2)
           B = img(i,j,:);
            C = double(B(:));
            img_out(i,j,:) = T_Matrix*C; 
        end
    end
end

%% YCrCb to RGB  (lossy2000)
if (x == 3)
    T_Matrix = [1 1.402 0; 1 -0.714 -0.344 ; 1 0 1.772 ];
    for i = 1:siz(1)
        for j = 1:siz(2)
           B = img(i,j,:);
            C = double(B(:));
            img_out(i,j,:) = T_Matrix*C;
        end
    end
end

%% YCuCv to RGB (lossless2000)
if (x == 4)
    T_Matrix = [1 -1/4 3/4; 1 -1/4 -1/4 ; 1 3/4 -1/4 ];
    for i = 1:siz(1)
        for j = 1:siz(2)
           B = img(i,j,:);
            C = double(B(:));
            img_out(i,j,:) = T_Matrix*C;
        end
    end
end

end