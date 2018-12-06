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
C1_new = abs(ifft2(C1_t));

% Transformed values should be mapped.
C1_new = C1_new/255.0; % Adjust the color range to [0, 1]
% Map the gray levels to the range [0.0, 1.0]
C1_new = imadjust(C1_new,[min(C1_new(:)); max(C1_new(:))],[0.0; 1.0]);

%figure, imshow(C1_new); % Display the output image 
imwrite(C1_new, 'C1_output.png');



%%%%% C2 %%%%%
C2_t = fft2(C2);
%figure, imshow(fftshift(abs(C2_t)), [0, 40000]); % display the transform

% Construct the frequency domain filter
center_x = round(C2_width/2);
center_y = round(C2_height/2);
filter2 = zeros(C2_height, C2_width);

for x = 1:C2_width
   for y = 1:C2_height
      distance = sqrt((x-center_x)^2 + (y-center_y)^2);
      if((distance > 180)) % Can be adjusted
         filter2(y, x) = 1;
      end
   end
end
filter2 = ifftshift(filter2); % shift back
C2_t = C2_t .* filter2; % element-wise multiplication
%figure, imshow(fftshift(abs(C2_t)), [0, 40000]); % display filtered transform

C2_new = abs(ifft2(C2_t)); % Inverse Fourier transform

% Transformed values should be mapped.
C2_new = C2_new/255.0; % Adjust the color range to [0, 1]
% Map the gray levels to the range [0.0, 1.0]
C2_new = imadjust(C2_new,[min(C2_new(:)); max(C2_new(:))],[0.0; 1.0]);

%figure, imshow(C2_new); % Display the output image 
imwrite(C2_new, 'C2_output.png');
