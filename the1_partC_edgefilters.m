clc;
clear;
Sx = [-1 0 1; -2 0 2; -1 0 1];
Sy = [1 2 1; 0 0 0; -1 -2 -1];
Rx = [0 1; -1 0];
Ry = [1 0; 0 -1];

C1 = imread('./THE1_images/C1.png');
C2 = imread('./THE1_images/C2.png');
C3 = imread('./THE1_images/C3.png');
C1_Sx = the1_convolution(C1, Sx);
C2_Sx = the1_convolution(C2, Sx);
C3_Sx = the1_convolution(C3, Sx);
C1_Sy = the1_convolution(C1, Sy);
C2_Sy = the1_convolution(C2, Sy);
C3_Sy = the1_convolution(C3, Sy);
C1_Rx = the1_convolution(C1, Rx);
C2_Rx = the1_convolution(C2, Rx);
C3_Rx = the1_convolution(C3, Rx);
C1_Ry = the1_convolution(C1, Ry);
C2_Ry = the1_convolution(C2, Ry);
C3_Ry = the1_convolution(C3, Ry);

imwrite(C1_Sx, 'C1_Sx.png');
imwrite(C2_Sx, 'C2_Sx.png');
imwrite(C3_Sx, 'C3_Sx.png');
imwrite(C1_Sy, 'C1_Sy.png');
imwrite(C2_Sy, 'C2_Sy.png');
imwrite(C3_Sy, 'C3_Sy.png');
imwrite(C1_Rx, 'C1_Rx.png');
imwrite(C2_Rx, 'C2_Rx.png');
imwrite(C3_Rx, 'C3_Rx.png');
imwrite(C1_Ry, 'C1_Ry.png');
imwrite(C2_Ry, 'C2_Ry.png');
imwrite(C3_Ry, 'C3_Ry.png');

