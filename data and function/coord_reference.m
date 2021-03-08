function [pixel] = coord_reference(coordinate,filename)
% Function to compute referance frame. The output is in pixel. The input
% argunt must be coordinate picture (as string) and the filename shold be i
%n form 'filename.txt'.
coord = imread(coordinate);
figure(21);
imagesc(coord)


%Select reference points in pixel coordinate            
h1 = impoly;
pixel = h1.getPosition;
dlmwrite(filename,pixel);
end

