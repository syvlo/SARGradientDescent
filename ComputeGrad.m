function [ G ] = ComputeGrad( V, U, Scatterers, MaskI, MaskJ, Beta, Epsilon )
%COMPUTEENERGY Summary of this function goes here
%   Detailed explanation goes here

    AttaDo = 2*(U.^2 - V.^2) ./ U.^3;
    AttaDo(Scatterers > 0) = 0;
    
	GradU = grad(U);
    D = sqrt(Epsilon + sum3(GradU.^2,3));
	GTV = div(GradU ./ repmat(D, [1 1 2]));
	%GTV = Ui ./ sqrt(abs(Ui) .^ 2 + Epsilon) + Uj ./ sqrt(abs(Uj) .^ 2 + Epsilon);%(Ui + Uj) ./ sqrt(Ui .^ 2 + Uj .^ 2 + Epsilon);
    G = Beta * GTV - AttaDo;

end

