clc;
%deneme 3 
%%%%%%%%%% B1 %%%%%%%%%%

B1 = imread('./THE1_images/B1.png');
height = size(B1, 1);
width = size(B1, 2);

% create and fill histograms for 3 color channels
B1_histogram_r = zeros(1,256);
B1_histogram_g = zeros(1,256);
B1_histogram_b = zeros(1,256);
for y = 1:height
    for x = 1:width
        value_r = B1(y, x, 1);
        value_g = B1(y, x, 2);
        value_b = B1(y, x, 3);

        B1_histogram_r(value_r+1) = B1_histogram_r(value_r+1) + 1;
        B1_histogram_g(value_g+1) = B1_histogram_g(value_g+1) + 1;
        B1_histogram_b(value_b+1) = B1_histogram_b(value_b+1) + 1;
        % hist(n+1) holds the value for color value n since hist(0) is not
        % reachable for color value 0.
    end
end

%figure, bar(B1_histogram_r);
%figure, bar(B1_histogram_g);
%figure, bar(B1_histogram_b);

% find the cumulative histograms
for i = 2:256
   B1_histogram_r(i) = B1_histogram_r(i) + B1_histogram_r(i-1);
   B1_histogram_g(i) = B1_histogram_g(i) + B1_histogram_g(i-1);
   B1_histogram_b(i) = B1_histogram_b(i) + B1_histogram_b(i-1);
end

% create the new image
B1_histeq_output = zeros(height, width, 3, 'uint8');
c = 255/(height*width); % c is a constant for (L-1)/N*M = 255/(N*M)
for y = 1:height
   for x = 1:width
       B1_histeq_output(y,x,1) = round(c * B1_histogram_r(B1(y,x,1)+1));
       B1_histeq_output(y,x,2) = round(c * B1_histogram_g(B1(y,x,2)+1));
       B1_histeq_output(y,x,3) = round(c * B1_histogram_b(B1(y,x,3)+1));
   end
end

%figure, imshow(B1);
%autohisteq = histeq(B1);
%figure, imshow(B1_histeq_output);
%figure, imshow(autohisteq);
imwrite(B1_histeq_output, 'B1_histeq_output.png');






%%%%%%%%%% B2 %%%%%%%%%%

B2 = imread('./THE1_images/B2.png');
height = size(B2,1);
width = size(B2,2);

% create and fill the histogram
B2_histogram = zeros(1,256);
for y = 1:height
    for x = 1:width
        value = B2(y, x);
        B2_histogram(value+1) = B2_histogram(value+1) + 1;
        % hist(n) holds the value for color value n-1 since hist(0) is not
        % reachable for color value 0.
    end
end

 figure, bar(B2_histogram);

% find the cumulative histogram
for i = 2:256
    B2_histogram(i) = B2_histogram(i) + B2_histogram(i-1);
end


% create the new image
B2_histeq_output = zeros(height, width, 'uint8');

for y = 1:height
   for x = 1:width
       % (L-1)/N*M = 255/(N*M) = 3.2002e-04
       B2_histeq_output(y, x) = round(3.2002e-4 * B2_histogram(B2(y,x)+1));
   end
end

% create the new (equalized) histogram
B2_histeq = zeros(1,256);
for y = 1:height
    for x = 1:width
        value = B2_histeq_output(y, x);
        B2_histeq(value+1) = B2_histeq(value+1) + 1;
    end
end

set(gcf,'Visible','off');
bar(B2_histeq);
print -dpng B2_histeq.png
imwrite(B2_histeq_output, 'B2_histeq_output.png');

%figure, bar(B2_histogram);
%figure, bar(B2_histeq);
%figure, imshow(B2_histeq_output);
%figure, imshow(B2);







