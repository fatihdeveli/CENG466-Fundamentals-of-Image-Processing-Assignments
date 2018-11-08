%{
Berk Arslan   2110245
Fatih Develi  2330892
%}

% This script combines the results obtained in the1_partC_edgefilters  

clc;

C1_height = size(C1, 1);
C1_width = size(C1, 2);
C1_S_edges = zeros(C1_height, C1_width, 'uint8');
C1_R_edges = zeros(C1_height, C1_width, 'uint8');

C2_height = size(C2, 1);
C2_width = size(C2, 2);
C2_S_edges = zeros(C2_height, C2_width, 'uint8');
C2_R_edges = zeros(C2_height, C2_width, 'uint8');

C3_height = size(C3, 1);
C3_width = size(C3, 2);
C3_S_edges = zeros(C3_height, C3_width, 'uint8');
C3_R_edges = zeros(C3_height, C3_width, 'uint8');

% CX_?? images must be casted to double to be able to do the calculations.
C1_Sx = double(C1_Sx);
C1_Sy = double(C1_Sy);
C1_Rx = double(C1_Rx);
C1_Ry = double(C1_Ry);

C2_Sx = double(C2_Sx);
C2_Sy = double(C2_Sy);
C2_Rx = double(C2_Rx);
C2_Ry = double(C2_Ry);

C3_Sx = double(C3_Sx);
C3_Sy = double(C3_Sy);
C3_Rx = double(C3_Rx);
C3_Ry = double(C3_Ry);

for y = 1:C1_height
    for x = 1:C1_width
        C1_S_edges(y, x) = round(sqrt(C1_Sx(y,x)^2 + C1_Sy(y,x)^2));
        C1_R_edges(y, x) = round(sqrt(C1_Rx(y,x)^2 + C1_Ry(y,x)^2));
    end
end

for y = 1:C2_height
    for x = 1:C2_width
        C2_S_edges(y, x) = round(sqrt(C2_Sx(y,x)^2 + C2_Sy(y,x)^2));
        C2_R_edges(y, x) = round(sqrt(C2_Rx(y,x)^2 + C2_Ry(y,x)^2));
    end
end

for y = 1:C3_height
    for x = 1:C3_width
        C3_S_edges(y, x) = sqrt(C3_Sx(y,x)^2 + C3_Sy(y,x)^2);
        C3_R_edges(y, x) = sqrt(C3_Rx(y,x)^2 + C3_Ry(y,x)^2);
    end
end


imwrite(C1_S_edges, 'C1_S_edges.png');
imwrite(C1_R_edges, 'C1_R_edges.png');
imwrite(C2_S_edges, 'C2_S_edges.png');
imwrite(C2_R_edges, 'C2_R_edges.png');
imwrite(C3_S_edges, 'C3_S_edges.png');
imwrite(C3_R_edges, 'C3_R_edges.png');
