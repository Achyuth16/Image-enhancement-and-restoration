clc;
clear all;
close all;
load('Image22.mat');
I=IMAGE;
I=mat2gray(I)
imshow(I)   
%% med filt
I1=medfilt2(I,[3,3]);
figure
imshow(I1)
title('denoised image');
%% 
%  LEN = 21;
% THETA = 11;
% N=11;
% h1=fir1(N-1,0.2,'high',hamming(N));  % desgning a 1-D FIR filter   
% h=ftrans2(h1);
%  PSF = fspecial('gaussian',LEN,THETA);
%   noise_var =0.02; 
%  estimated_nsr = noise_var / var(I1(:));
% wnr3 = deconvwnr(I1,h,PSF,estimated_nsr);
% figure, imshow(wnr3)
% title('Restoration of Blurred, Noisy Image Using Estimated NSR');
% I1=medfilt2(I,[5,5]);
% figure
% imshow(I1)
% title('denoised image');
LEN = 21;
THETA = 11;
N=11;
h1=fir1(N-1,0.5,'low',hamming(N));  % desgning a 1-D FIR filter   
h=ftrans2(h1);
 PSF = fspecial('disk',3);
  noise_var =10;
 estimated_nsr = noise_var / var(I1(:));
wnr3 = deconvlucy(I1, h);
figure, imshow(wnr3)
title('Restoration of Blurred, Noisy Image Using Estimated NSR');

%% 
N=11;
[z1,z2]=freqspace(64);  %two-dimensional frequency vectors f1 and f2 for an 64-by-64 matrix.
[c,d]=meshgrid(z1,z2);  % representing on a grid
H=zeros(size(c));      % generating a zeros matrix of the size w1
r=sqrt(c.^2+d.^2);
d=find(r<3);        %finding the values which satisfy the condition
H(d)=ones(size(d)); %  generating a ones matrix of the size d
  noise_var =10;
 estimated_nsr = noise_var / var(I1(:));
 h1=fwind1(H,hamming(N),hamming(N));
% h1=fir1(N-1,0.001,'high',hamming(N));  % desgning a 1-D FIR filter   
% h=ftrans2(h1);
DB=deconvwnr(I1,h1,PSF,estimated_nsr);
figure
% subplot(1,2,1)
imshow(mat2gray(DB));
title('Deblurred');
 %ab=I-DB;

 

%figure,imshow(mat2gray(ab));title('Removed');
% I2= medfilt2(DB,[3,3])
% subplot(1,2,2)
% imshow(I2)




%% 
N=11;
h1=fir1(N-1,0.9,'low',hamming(N));  % desgning a 1-D FIR filter   
h=ftrans2(h1);    % 2-D filter design using transformation method
% figure
% freqz2(h)
DB1=deconvwnr(I1,h);
figure,imshow(mat2gray(DB1));
title('Deblurred');
%% \

W=zeros(480,480);
R0=247;
for i=1:380
    for j=1:380
        x_ = j - 190.5;
        y_ = 190.5 - i;
  
        x = abs(x_);
        y = abs(y_);
        
         t = abs(atan(y/x));
        r_ = sqrt(x^2+y^2);
        r = abs(R0.*(asin((r_/R0))));
        
        
       
        
         x = r.*cos(t) ;
         y = r.*sin(t) ;
        if x_ < 0
            x = -x;
        end
        
        if y_ < 0
            y = -y;
        end
        i_= (ceil(300- y));
        j_ = (ceil(x +300));
        W(i_,j_) = DB(i,j);
    end
end
figure,imshow(mat2gray(W));title('Unwarped Image')
W1=medfilt2(W);
figure
imshow(W1);
W2=medfilt2(W1);
figure; imshow(W2);
W3=medfilt2(W2);
figure; imshow(W3);
W4=medfilt2(W3);
figure; imshow(W4)





