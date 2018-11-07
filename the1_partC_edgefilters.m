clc;
Sx = [-1 0 1; -2 0 2; -1 0 1];
Sy = [1 2 1; 0 0 0; -1 -2 -1];
Rx = [0 1; -1 0];
Ry = [1 0; 0 -1];

C2 = imread('./THE1_images/C1.png');
C2_Sx = the1_convolution(C2, Sx);
figure, imshow(C2);
figure, imshow(C2_Sx);

A = conv2(C2, Sx);
figure,imshow(A);
