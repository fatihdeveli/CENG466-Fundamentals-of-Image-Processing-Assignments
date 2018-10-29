clc;

%%%%%%%%%% B1 %%%%%%%%%%

B1 = imread('./THE1_images/B1.png');
height = size(B1, 1);
width = size(B1, 2);

B1_ref = imread('./THE1_images/B1_ref.png');
B1_ref_height = size(B1_ref,1);
B1_ref_width = size(B1_ref,2);

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
% create and fill 3 colored histograms for B1_ref
B1_ref_histogram_r=zeros(1,256);
B1_ref_histogram_g=zeros(1,256);
B1_ref_histogram_b=zeros(1,256);

for y=1:B1_ref_height
    for x=1:B1_ref_width
        value_r = B1_ref(y,x,1);
        value_g = B1_ref(y,x,2);
        value_b = B1_ref(y,x,3);
        
        B1_ref_histogram_r(value_r+1)=B1_ref_histogram_r(value_r+1)+1;
        B1_ref_histogram_g(value_g+1)=B1_ref_histogram_g(value_g+1)+1;
        B1_ref_histogram_b(value_b+1)=B1_ref_histogram_b(value_b+1)+1;
    end
end

%create cumulative histogram of B1_ref

for i=2:256
    B1_ref_histogram_r(i)=B1_ref_histogram_r(i)+B1_ref_histogram_r(i-1);
    B1_ref_histogram_g(i)=B1_ref_histogram_g(i)+B1_ref_histogram_g(i-1);
    B1_ref_histogram_b(i)=B1_ref_histogram_b(i)+B1_ref_histogram_b(i-1);
end


% find the cumulative histograms
for i = 2:256
   B1_histogram_r(i) = B1_histogram_r(i) + B1_histogram_r(i-1);
   B1_histogram_g(i) = B1_histogram_g(i) + B1_histogram_g(i-1);
   B1_histogram_b(i) = B1_histogram_b(i) + B1_histogram_b(i-1);
end


% create the new B1_histeq_output image
B1_histeq_output = zeros(height, width, 3, 'uint8');
c = 255/(height*width); % c is a constant for (L-1)/N*M = 255/(N*M)
for y = 1:height
   for x = 1:width
       B1_histeq_output(y,x,1) = round(c * B1_histogram_r(B1(y,x,1)+1));
       B1_histeq_output(y,x,2) = round(c * B1_histogram_g(B1(y,x,2)+1));
       B1_histeq_output(y,x,3) = round(c * B1_histogram_b(B1(y,x,3)+1));
   end
end

%create the new B1_ref_histeq_output image
B1_ref_histeq_output = zeros(B1_ref_height, B1_ref_width, 3, 'uint8');
d = 255/(B1_ref_height*B1_ref_width); % d is a constant for (L-1)/N*M = 255/(N*M)
for y = 1:B1_ref_height
   for x = 1:B1_ref_width
       B1_ref_histeq_output(y,x,1) = round(d * B1_ref_histogram_r(B1_ref(y,x,1)+1));
       B1_ref_histeq_output(y,x,2) = round(d * B1_ref_histogram_g(B1_ref(y,x,2)+1));
       B1_ref_histeq_output(y,x,3) = round(d * B1_ref_histogram_b(B1_ref(y,x,3)+1));
   end
end
% finding mappings
B1_mapping_r = zeros(1,256);
B1_ref_mapping_r= zeros(1,256);
B1_mapping_g= zeros(1,256);
B1_ref_mapping_g= zeros(1,256);
B1_mapping_b= zeros(1,256);
B1_ref_mapping_b= zeros(1,256);

for i=1:256
    B1_mapping_r(i)= round(B1_histogram_r(i)*c);
    B1_ref_mapping_r(i)=round(B1_ref_histogram_r(i)*d);
    B1_mapping_g(i)= round(B1_histogram_g(i)*c);
    B1_ref_mapping_g(i)=round(B1_ref_histogram_g(i)*d);
    B1_mapping_b(i)= round(B1_histogram_b(i)*c);
    B1_ref_mapping_b(i)=round(B1_ref_histogram_b(i)*d);
end




%histogram specification process
M1 = zeros(256,1,'uint8');
for idx = 1 : 256
    diff = abs(B1_mapping_r(idx) - B1_ref_mapping_r);
    [~,ind] = min(diff);
    M1(idx) = ind-1;
end
M2 = zeros(256,1,'uint8');
for idx = 1 : 256
    diff = abs(B1_mapping_g(idx) - B1_ref_mapping_g);
    [~,ind] = min(diff);
    M2(idx) = ind-1;
end
M3 = zeros(256,1,'uint8');
for idx = 1 : 256
    diff = abs(B1_mapping_b(idx) - B1_ref_mapping_b);
    [~,ind] = min(diff);
    M3(idx) = ind-1;
end

B1_hismatch_output = zeros(height,width,3,'uint8');
for y=1:height
    for x=1:width
        B1_hismatch_output(y,x,1)=M1(B1(y,x,1)+1);
        B1_hismatch_output(y,x,2)=M2(B1(y,x,2)+1);
        B1_hismatch_output(y,x,3)=M3(B1(y,x,3)+1);
    end
end
imwrite(B1_hismatch_output,'B1_hismatch_output.png');


%figure, imshow(B1);
%autohisteq = histeq(B1);
%figure, imshow(B1_histeq_output);
%figure, imshow(autohisteq);


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

%figure, bar(B2_histogram);

% find the cumulative histogram
for i = 2:256
    B2_histogram(i) = B2_histogram(i) + B2_histogram(i-1);
end

c = 255/(height*width);
B2_mapping = zeros(1,256);
for i = 1:256
   B2_mapping(i) = round(c * B2_histogram(i));
end

%figure, bar(B2_mapping);

% create the new image
B2_histeq_output = zeros(height, width, 'uint8');

for y = 1:height
   for x = 1:width
       B2_histeq_output(y, x) = B2_mapping(B2(y,x)+1);
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

%set(gcf,'Visible','off');
%bar(B2_histeq);
%print -dpng B2_histeq.png
%imwrite(B2_histeq_output, 'B2_histeq_output.png');

%figure, bar(B2_histogram);
%figure, bar(B2_histeq);
%figure, imshow(B2_histeq_output);
%figure, imshow(B2);

%%% Specification part
B2_ref = imread('./THE1_images/B2_ref.png');
B2_ref_height = size(B2_ref,1);
B2_ref_width = size(B2_ref,2);

% create and fill the histogram
B2_ref_histogram = zeros(1,256);
for y = 1:B2_ref_height
    for x = 1:B2_ref_width
        value = B2(y, x);
        B2_ref_histogram(value+1) = B2_ref_histogram(value+1) + 1;
        % hist(n) holds the value for color value n-1 since hist(0) is not
        % reachable for color value 0.
    end
end



% Convert to cumulative
for i = 2:256
    B2_ref_histogram(i) = B2_ref_histogram(i) + B2_ref_histogram(i-1);    
end

B2_ref_mapping = zeros(1,256);
c = 255/(B2_ref_height * B2_ref_width);
for i = 1:256
   B2_ref_mapping(i) = round(c * B2_ref_histogram(i));
end

mapping = zeros(1,256);
for i = 1:256
    [~, ind] = min(abs(B2_ref_mapping - B2_mapping(i)));
    mapping(i) = ind - 1;
end

% Create the new image
B2_histmatch_output = zeros(height, width, 'uint8');
for y = 1:height
    for x = 1:width
        B2_histmatch_output(y,x) = mapping(B2(y,x)+1);       
    end
end

%figure, imshow(B2_histmatch_output);
%figure, imshow(B2);


