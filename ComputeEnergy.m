function [ E ] = ComputeEnergy( U, V, Beta )
%Compute the energy (debugging purposes).
    E = V.^2 ./ U.^2 + 2 * log(U);

    Ui = abs(cat(1, U, U(size(U, 1), :)) - cat(1, U(1, :), U));%Compute gradient on rows
    Ui = Ui(1:size(U, 1), :);
    Uj = abs(cat(2, U, U(:, size(U, 2))) - cat(2, U(:, 1), U));%Compute gradient on columns
    Uj = Uj(:, 1:size(U, 2));

    E = E + Beta * (Ui + Uj);
    E = sum(E(:));
end

