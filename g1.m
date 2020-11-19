%function [g1x,g1y,g1mag] = g1(im,s)
%Computes and returns the first Gaussian derivative of image at scale s 
%in x and y directions, and the gradient magnitude.  Kernels are truncated
%beyond three standard deviations of the Gaussian function.

im = imread('mondrian_gray.jpg');
s = 1.6

im = im2gray(im);
maxx = ceil(3*s);
x = [-maxx:maxx];
h = normpdf(x,0,s);
h1 = (-x/(s^2)).*normpdf(x,0,s);
%%h1 = conv((-x/(s^2)),normpdf(x,0,s))
g1x = conv2(h,h1,im,'same');
g1y = conv2(h1,h,im,'same');
g1mag = sqrt(g1x.^2+g1y.^2);
figure;
subplot(1,4,1);
imagesc(im);axis image;colormap gray;
subplot(1,4,2);
imagesc(g1x);axis image;colormap gray;
subplot(1,4,3);
imagesc(g1y);axis image;colormap gray;
subplot(1,4,4);
imagesc(g1mag);axis image;colormap gray;


