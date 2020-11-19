# simple_edge_detector

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
