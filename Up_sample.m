function [ img_out ] = Up_sample( img, flag )

siz = size (img);
if (length(siz) == 2)
    siz(3) = 1;
end

%% Upsampling in Rows (Nearest Neighbour)
if (flag == 0 )
%     siz_new = siz;
%     siz_new(1) = 2*siz_new(1);
%     rowIndex = min(round(((1:siz_new(1))-0.5)./2+0.5),siz(1));
%     img_out = img(rowIndex,:,:);
        img_out = zeros(2*siz(1), siz(2),siz(3));
        img_out (1:2:2*siz(1),:,: ) = img;
end
%% Upsampling in Columns (Nearest Neighbour)
if (flag == 1 )
%     siz_new = siz;
%     siz_new(2) = 2*siz_new(2);
%     colIndex = min(round(((1:siz_new(2))-0.5)./2+0.5),siz(2));
%     img_out = img(:,colIndex,:);
    
        img_out = zeros(siz(1),2*siz(2),siz(3));
        img_out (:,1:2:2*siz(2),: ) = img;
end
%% Upsampling in Rows and Columns (Nearest Neighbour)
if (flag == 2 )
    
    siz_new = 2.*siz;
    rowIndex = min(round(((1:siz_new(1))-0.5)./2+0.5),siz(1));
    colIndex = min(round(((1:siz_new(2))-0.5)./2+0.5),siz(2));
    img_out = img(rowIndex,colIndex,:);
    
%          img_out = zeros(2*siz(1),2*siz(2),siz(3));
%          img_out (2:2:2*siz(1),2:2:2*siz(2),: ) = img;
    
end
end