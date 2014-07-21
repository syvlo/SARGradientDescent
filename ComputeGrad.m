function [ G ] = ComputeGrad( V, U, MaskI, MaskJ, Beta, Epsilon )
%COMPUTEENERGY Summary of this function goes here
%   Detailed explanation goes here

    U = U.^2;
    V = V.^2;
    
    GV = gradient(V);

    Ui = abs(cat(1, U, U(size(U, 1), :)) - cat(1, U(1, :), U));%Compute gradient on rows
    Ui = Ui(1:size(U, 1), :);
    Uj = abs(cat(2, U, U(:, size(U, 2))) - cat(2, U(:, 1), U));%Compute gradient on columns
    Uj = Uj(:, 1:size(U, 2));
    GU = Ui + Uj;

    Vi = abs(cat(1, V, V(size(V, 1), :)) - cat(1, V(1, :), V));%Compute gradient on rows
    Vi = Vi(1:size(V, 1), :);
    Vj = abs(cat(2, V, V(:, size(V, 2))) - cat(2, V(:, 1), V));%Compute gradient on columns
    Vj = Vj(:, 1:size(V, 2));
    GV = Vi + Vj;

    G = (U - V) ./ U.^2;% 2*V ./ U .^ 3 .* (U .* GV - V .* GU) + 2*GU ./ U;

%	G = (2*(U .^ 2 - V .^ 2) .* Ui + U .* V .* Vi + 2 * (U .^2 - V .^ 2) .* Uj + U .* V .* Vj) ./ U .^ 3;
    GTV = Ui ./ sqrt(Ui .^ 2 + Epsilon) + Uj ./ sqrt(Uj .^ 2 + Epsilon);%(Ui + Uj) ./ sqrt(Ui .^ 2 + Uj .^ 2 + Epsilon);
    G = G + Beta * GTV;

end

