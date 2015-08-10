function  huffman_final( Image )

siz = size(Image);
num_of_pixels = siz(1)*siz(2);
prob = zeros(siz(1),siz(2));
h = waitbar(0,'pdf is being calculated please wait...');
for i=0:255
    for j = 1:siz(3)
    his = find(Input_Image(:,:,j) == i);
    hist_prob_RGB(i+1,1,j) = (length(his)/num_of_pixels);
    end
waitbar(i /255)
 end
close(h)

end

