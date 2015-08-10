function [ Tiled_img, Tiles ] = Tiling( data_Array )

Size0 = size (data_Array);
if (length(Size0) == 2)
    Size0(3) = 1;
end

m = (Size0(1) - mod (Size0(1), 64))/64; 
n = (Size0(2) - mod (Size0(2), 64))/64;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (mod(Size0(1), 64) == 0)
    m1 = 0;
else 
    m1 = floor (log2(mod (Size0(1), 64)));
end
if (mod(Size0(2), 64) == 0)
    n1 = 0;
else 
    n1 = floor (log2(mod (Size0(2), 64)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (n1 == 0 && m1 == 0)
    Tiles = m*n;
elseif (n1 == 0)
    Tiles = m*n +(64*n/(2^m1));
elseif (m1 == 0)
    Tiles = m*n +(64*m/(2^n1)) ;
else
   Tiles = m*n +(64*n/(2^m1)) +(64*m/(2^n1));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
arr = [0  0  0  0  0  0  ;...
       0  1  2  4  8  16 ;...
       0  2  1  2  4  8  ;...
       0  4  2  1  2  4  ;...
       0  8  4  2  1  2  ;...
       0  16 8  4  2  1  ];
Tiles = Tiles + arr(m1+1, n1+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Tiled_img(1:Tiles) = struct('tile',[]);
count = 1;
for i = 1:m
    for j = 1:n
        a = 64*(i-1)+1 :1: 64*i;
        b = 64*(j-1)+1 :1: 64*j;
        Tiled_img(count).tile =  data_Array(a, b,:);
        count = count +1;
    end
end
if (count> Tiles)
  return  
end
if (m1 ~= 0)
for k = 1:(64*n/(2^m1))
    a = Size0(1)-mod(Size0(1),64)+1 :1: (Size0(1)-mod(Size0(1),64)+2^m1);
    b = 2^m1*(k-1)+1 :1: 2^m1*k;
    Tiled_img(count).tile =  data_Array(a, b,:);
    count = count +1;
end
end
if (count> Tiles)
  return  
end
if (n1 ~= 0)
for j = 1:(64*m/(2^n1))
        b = Size0(2)-mod(Size0(2),64)+1 :1: (Size0(2)-mod(Size0(2),64)+2^n1);
        a = 2^n1*(j-1)+1 :1: 2^n1*j;
        Tiled_img(count).tile =  data_Array(a, b,:);
        count = count +1;
end  
end
if (count> Tiles)
  return  
end
for k = 1:arr(m1+1, n1+1)
        if (m1 < n1)
            a = Size0(2)-mod(Size0(2),64)+1 :1: (Size0(2)-mod(Size0(2),64)+2^m1);
            b = Size0(1)-mod(Size0(1),64)+1+2^m1*(k-1) :1: Size0(1)-mod(Size0(1),64)+ 2^m1*k;             
            Tiled_img(count).tile =  data_Array(a, b,:);
            count = count +1;
        end
        if (m1 > n1)
            a = Size0(2)-mod(Size0(2),64)+1+2^n1*(k-1) :1: Size0(2)-mod(Size0(2),64)+ 2^n1*k;            
            b = Size0(1)-mod(Size0(1),64)+1            :1: Size0(1)-mod(Size0(1),64)+ 2^n1   ;
            Tiled_img(count).tile =  data_Array(a, b,:);
            count = count +1;
        end
        if (m1 == n1)
            a = Size0(1)-mod(Size0(1),64)+1 :1: Size0(1)-mod(Size0(1),64)+ 2^m1*k;
            b = Size0(2)-mod(Size0(2),64)+1 :1: Size0(2)-mod(Size0(2),64)+ 2^n1*k;
            Tiled_img(count).tile =  data_Array(a, b,:);
            count = count +1;
        end
end  


end