function [ img_out ] = Down_sample( img , flag)

%% Subsampling in Rows
if (flag == 0 )
    img_out = img(1:2:end,:,:);
end
%% Subsampling in Columns
if (flag == 1 )
    img_out = img(:,1:2:end,:);
end
%% Subsampling in Rows and Columns
if (flag == 2 )
img_out = img(2:2:end,2:2:end,:);
end

end