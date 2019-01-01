function [ se ] = disk_matrix( r )
%DISK_MATRIX Creates a binary matrix with a disk of 1's inside.
%   Detailed explanation goes here
size = 2*r-1;
center = size/2.0;
se = zeros(size, size);
for y=1:size
   for x=1:size
       distance = sqrt((y-r)^2+(x-r)^2);
       se(y, x) = center > distance;   
   end 
end

end

