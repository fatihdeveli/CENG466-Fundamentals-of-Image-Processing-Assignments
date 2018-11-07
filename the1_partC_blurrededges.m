
C1_Sx_blurred = the1_convolution(C1_blurred, Sx);
C2_Sx_blurred = the1_convolution(C2_blurred, Sx);
C3_Sx_blurred = the1_convolution(C3_blurred, Sx);
C1_Sy_blurred = the1_convolution(C1_blurred, Sy);
C2_Sy_blurred = the1_convolution(C2_blurred, Sy);
C3_Sy_blurred = the1_convolution(C3_blurred, Sy);
C1_Rx_blurred = the1_convolution(C1_blurred, Rx);
C2_Rx_blurred = the1_convolution(C2_blurred, Rx);
C3_Rx_blurred = the1_convolution(C3_blurred, Rx);
C1_Ry_blurred = the1_convolution(C1_blurred, Ry);
C2_Ry_blurred = the1_convolution(C2_blurred, Ry);
C3_Ry_blurred = the1_convolution(C3_blurred, Ry);


C1_S_blurred = zeros(C1_height, C1_width);
C1_R_blurred = zeros(C1_height, C1_width);

C2_S_blurred = zeros(C2_height, C2_width);
C2_R_blurred = zeros(C2_height, C2_width);

C3_S_blurred = zeros(C3_height, C3_width);
C3_R_blurred = zeros(C3_height, C3_width);

% CX_?? images must be casted to double to be able to do the calculations.
C1_Sx_blurred = double(C1_Sx_blurred);
C1_Sy_blurred = double(C1_Sy_blurred);
C1_Rx_blurred = double(C1_Rx_blurred);
C1_Ry_blurred = double(C1_Ry_blurred);

C2_Sx_blurred = double(C2_Sx_blurred);
C2_Sy_blurred = double(C2_Sy_blurred);
C2_Rx_blurred = double(C2_Rx_blurred);
C2_Ry_blurred = double(C2_Ry_blurred);

C3_Sx_blurred = double(C3_Sx_blurred);
C3_Sy_blurred = double(C3_Sy_blurred);
C3_Rx_blurred = double(C3_Rx_blurred);
C3_Ry_blurred = double(C3_Ry_blurred);

for y = 1:C1_height
    for x = 1:C1_width
        C1_S_blurred(y, x) = ...
            round(sqrt(C1_Sx_blurred(y,x)^2 + C1_Sy_blurred(y,x)^2));
        C1_R_blurred(y, x) = ...
            round(sqrt(C1_Rx_blurred(y,x)^2 + C1_Ry_blurred(y,x)^2));
    end
end

for y = 1:C2_height
    for x = 1:C2_width
        C2_S_blurred(y, x) = ...
            round(sqrt(C2_Sx_blurred(y,x)^2 + C2_Sy_blurred(y,x)^2));
        C2_R_blurred(y, x) = ...
            round(sqrt(C2_Rx_blurred(y,x)^2 + C2_Ry_blurred(y,x)^2));
    end
end

for y = 1:C3_height
    for x = 1:C3_width
        C3_S_blurred(y, x) = ...
            round(sqrt(C3_Sx_blurred(y,x)^2 + C3_Sy_blurred(y,x)^2));
        C3_R_blurred(y, x) = ...
            round(sqrt(C3_Rx_blurred(y,x)^2 + C3_Ry_blurred(y,x)^2));
    end
end
asd=edge(C2,'Sobel');
figure , imshow(asd);
imwrite(C1_S_blurred, 'C1_S_blurred.png');
imwrite(C1_R_blurred, 'C1_R_blurred.png');
imwrite(C2_S_blurred, 'C2_S_blurred.png');
imwrite(C2_R_blurred, 'C2_R_blurred.png');
imwrite(C3_S_blurred, 'C3_S_blurred.png');
imwrite(C3_R_blurred, 'C3_R_blurred.png');
