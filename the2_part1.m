clear;
clc;
A1=imread('the2_input/A1.png');
A2=imread('the2_input/A2.png');

[cA1,cH1,cV1,cD1] = dwt2(im2double(A1),'haar');
[cAA1,cAH1,cAV1,cAD1] = dwt2(cA1,'haar'); % Recompute Wavelet of Approximation Coefs.
[cAAA1,cAAH1,cAAV1,cAAD1] = dwt2(cAA1,'haar');
Level3=[cAAA1,cAAH1; cAAV1,cAAD1];
Level2=[Level3,cAH1; cAV1,cAD1]; %contacinat
cH1=[zeros(size(cH1,1),1) cH1];
cD1=[zeros(size(cD1,1),1) cD1];
cV1=[zeros(size(cV1,1),1) cV1];
%figure , imshow([Level2,cH1; cV1,cD1],'Colormap',pink);


%[cA2,cH2,cV2,cD2] = dwt2(im2double(A2),'haar');
[cA2,cH2,cV2,cD2] = dwt2(im2double(A2),'haar');
[cAA2,cAH2,cAV2,cAD2] = dwt2(cA2,'haar'); % Recompute Wavelet of Approximation Coefs.
[cAAA2,cAAH2,cAAV2,cAAD2] = dwt2(cAA2,'haar');
Level3=[cAAA2,cAAH2; cAAV2,cAAD2];
Level2=[Level3,cAH2; cAV2,cAD2]; %contacinat
cH2=[zeros(size(cH2,1),1) cH2];
cD2=[zeros(size(cD2,1),1) cD2];
cV2=[zeros(size(cV2,1),1) cV2];
%figure , imshow([Level2,cH2; cV2,cD2],'Colormap',pink);
%[cA3,cH3,cV3,cD3] = dwt2(im2double(A1),'haar');   cloning the A1 to A3


X3 = idwt2(cAAA1,cAAH1,cAAV1,cAAD1,'haar');
X2 = idwt2(X3,cAH1,cAV1,cAH2,'haar');
X1 = idwt2(X2,cD1,cV2,cD2,'haar');
figure,imshow(X1);

X32 = idwt2(cAAA2,cAAH2,cAAV2,cAAD2,'haar');
X22 = idwt2(X32,cAV2,cAD1,cAD2,'haar');
X12 = idwt2(X22,cH2,cH1,cV1,'haar');
figure,imshow(X12);



%cA1 = cA1 + cH1;  manipulations begin
%cA1 = cA1 + cH2;
%cA1 = cA1 + cD1;  manipulations end.


%cA3 = cD1; swaping begins
%cD1 = cH1;
%cH1 = cA3;

%cA3 = cV1;
%cV1 = cV2;
%cV2 = cA3;

%cA3 = cD1;
%cD1 = cD2;
%cD2 = cA3; swaping ends

%X = idwt2(cA1,cH1,cV1,cD1,'haar');
%figure ,imshow(X);
%figure ,imshow(A1);
%figure,imshow([cA2,cH2; cV2,cD2],'Colormap',pink);
%figure,imshow([cA1,cH1; cV1,cD1],'Colormap',pink);