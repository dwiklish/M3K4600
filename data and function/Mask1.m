function [mask] = Mask1(image1,image2,maskname)
% Create a polygonal mask. Input argument are the two images and the
% maskname in format txt.(maskname.txt)

im1 = imread(image1);
im2 = imread(image2);

figure(1);
imagesc(im1);
set(gca,'Ydir','reverse')
h = impoly();
mask = h.createMask();
dlmwrite(maskname,mask);
end

