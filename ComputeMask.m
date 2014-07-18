function [ MaskI, MaskJ ] = ComputeMask( InputImage, Thresh )
%COMPUTEMASK Compute the masks to be used in the wheightening of TV.
%   Compute the two masks (one for each direction) by thresholding the forward
%   gradient.

    %We do not use MATLAB's gradient, because we want a forward approx.
    %MATLAB does it centered.
    Vi = abs(cat(1, InputImage, InputImage(size(InputImage, 1), :)) - cat(1, InputImage(1, :), InputImage));%Compute gradient on rows
    Vi = Vi(1:size(InputImage, 1), :);
    Vj = abs(cat(2, InputImage, InputImage(:, size(InputImage, 2))) - cat(2, InputImage(:, 1), InputImage));%Compute gradient on columns
    Vj = Vj(:, 1:size(InputImage, 2));

    MaskI = double(Vi > Thresh);
    MaskJ = double(Vj > Thresh);

end

