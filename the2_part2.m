clear;
clc;

B1 = imread('the2_input/B1.png');
B2 = imread('the2_input/B2.png');
B3 = imread('the2_input/B3.png');





%%%%% B3 %%%%%

% Transform the input image
B3_t = fft2(B3);

% Modify to display the image in frequency domain.
B3_t2 = fftshift(B3_t);
B3_t3 = abs(B3_t2);
B3_t4 = log(B3_t3+1);
B3_t5 = mat2gray(B3_t4);

%figure, imshow(B3_t5, []); % input image transformed

% Construct the frequency domain filter
% Center points: (540, 192), (540, 576), (540, 1344), (540, 1728)
filter3 = ones(1079, 1919);
for y = 530:550
   for x = 172:212
      filter3(y, x) = 0; 
   end
   for x = 556:596
      filter3(y, x) = 0; 
   end
   for x = 1324:1364
      filter3(y, x) = 0;
   end
   for x = 1708:1748
      filter3(y, x) = 0;
   end
end
filter3 = ifftshift(filter3); % shift back
%figure, imshow(filter3);

% Apply the filter
B3_t = B3_t .* filter3; % element-wise multiplication
B3_t2 = fftshift(B3_t);
B3_t3 = abs(B3_t2);
B3_t4 = log(B3_t3+1);
B3_t5 = mat2gray(B3_t4);

%figure, imshow(B3_t5, []); % display the modified transform
%figure,imshow(B3); % input image
B3_new = ifft2(B3_t);
%figure,imshow(uint8(B3_new)); % display the output image 
