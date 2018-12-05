%{
Berk Arslan 2110245
Fatih Develi 2330892
%}
clear;
clc;

C1 = imread('the2_input/C1.png');
C1_height = size(C1, 1);
C1_width = size(C1, 2);

C2 = imread('the2_input/C2.png');
C2_height = size(C2, 1);
C2_width = size(C2, 2);

%%%%% C1 %%%%%
C1_t = fft2(C1);
%figure, imshow(fftshift(abs(C1_t)), [0, 40000]); % display the transform

% Construct the frequency domain filter
center_x = round(C1_width/2);
center_y = round(C1_height/2);
filter1 = zeros(C1_height, C1_width);
for x = 1:C1_width
   for y = 1:C1_height
      distance = sqrt((x-center_x)^2 + (y-center_y)^2);
      if((distance > 120)) % Can be adjusted
         filter1(y, x) = 1;
      end
   end
end
filter1 = ifftshift(filter1); % shift back
C1_t = C1_t .* filter1; % element-wise multiplication
%figure, imshow(fftshift(abs(C1_t)), [0, 40000]); % display filtered transform
C1_new = uint8(ifft2(C1_t));
%figure,imshow(C1_new, []); % display output image


%%%%% C2 %%%%%
C2_t = fft2(C2);
figure, imshow(fftshift(abs(C2_t)), [0, 40000]); % display the transform

% Construct the frequency domain filter
center_x = round(C2_width/2);
center_y = round(C2_height/2);
filter2 = ones(C2_height, C2_width);
for x = 1:C2_width
   for y = 1:C2_height
      %distance = sqrt((x-center_x)^2 + (y-center_y)^2);
      if(abs(x-center_x) < 240 && abs(y-center_y) < 140) % Values can be adjusted
         filter2(y, x) = 0;
      end
   end
end
filter2 = ifftshift(filter2); % shift back
C2_t = C2_t .* filter2; % element-wise multiplication
figure, imshow(fftshift(abs(C2_t)), [0, 40000]); % display filtered transform
C2_new = uint8(ifft2(C2_t));
figure,imshow(C2_new, []); % display output image
