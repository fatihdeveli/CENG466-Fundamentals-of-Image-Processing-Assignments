%{
Berk Arslan   2110245
Fatih Develi  2330892
%}
clc;

gaussian = [1/16 1/8 1/16; 1/8 1/4 1/8; 1/16 1/8 1/16];

C1_blurred = the1_convolution(C1, gaussian);
C2_blurred = the1_convolution(C2, gaussian);
C3_blurred = the1_convolution(C3, gaussian);

imwrite(C1_blurred, 'C1_blurred.png');
imwrite(C2_blurred, 'C2_blurred.png');
imwrite(C3_blurred, 'C3_blurred.png');
