%{
Berk Arslan 2110245
Fatih Develi 2330892
%}
clc;
clear;

B1 = imread('THE3_inputs/partB/B1.png');
B2 = imread('THE3_inputs/partB/B2.png');
B3 = imread('THE3_inputs/partB/B3.png');

B1_out = segmentation_function(B1);
B2_out = segmentation_function(B2);
B3_out = segmentation_function(B3);

figure, imshow(B1_out);
figure, imshow(B2_out);
figure, imshow(B3_out);

imwrite(B1_out, 'the3_B1_output.png');
imwrite(B2_out, 'the3_B2_output.png');
imwrite(B3_out, 'the3_B3_output.png');