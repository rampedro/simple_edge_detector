function emap = edge(g1x,g1y,a)
%Accepts x and y derivative maps (double format) and outputs an edge map
%(uint8 format) based upon non-maximum suppression in the gradient
%direction and thresholding at a gradient magnitude of mu + as, where mu
%and s are the mean and standard deviation of the gradient magnitude over
%the image, respectively. Edges are represented as 1, non-edges as 0.  
%
%The edge map should be the same size as the derivative maps, but no edges
%should be declared at pixels adjacent to the top, bottom, left or right of
%the image. Non-maximum suppression is based upon bilinear interpolation of
%the gradient magnitude at one-pixel displacements to either side of the
%central pixel, along the gradient direction.

[m,n] = size(g1x);

%Only compute edges for inner pixels
g1xout = g1x(2:end-1,2:end-1);
g1yout = g1y(2:end-1,2:end-1);
g1mag = sqrt(g1x.^2+g1y.^2);
g1magout = g1mag(2:end-1,2:end-1);
[X,Y] = meshgrid([1:n],[1:m]);
Xout = X(2:end-1,2:end-1);
Yout = Y(2:end-1,2:end-1);

%x and y components of gradient direction
costheta = g1xout./g1magout;
sintheta = g1yout./g1magout;

%Step in positive gradient direction
Xp = Xout + costheta;
Yp = Yout + sintheta;
%Step in negative gradient direction
Xn = Xout - costheta;
Yn = Yout - sintheta;

%Estimate gradient magnitude at these locations
g1magp = interp2(X,Y,g1mag,Xp,Yp);
g1magn = interp2(X,Y,g1mag,Xn,Yn);

mu = mean(g1mag(:));
s = std(g1mag(:));

emap = zeros(m,n);
%Enforce threshold and non-max suppression
emap(2:end-1,2:end-1) = g1magout>mu+a*s...
    & g1magout > g1magp & g1magout > g1magn;

figure;
subplot(1,2,1);
imagesc(g1mag);axis image;colormap gray;
subplot(1,2,2);
imagesc(emap);axis image;colormap gray;
