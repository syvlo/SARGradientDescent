function [ U, Energy, NormGrad, Steps ] = Main( Input, Beta, Thresh, StopCriterion, Epsilon, stepInit, nbIterMax, Original )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    Tau = 50;
    %Default values
    if nargin < 7
        nbIterMax = 5000;
        if nargin < 6
            stepInit = 0.01;
            if nargin < 5
                Epsilon = 1E-15;
                if nargin < 4
                    disp('Usage: Main(Input, Beta, Thresh, StopCriterion, [Epsilon, [stepInit, [nbIterMax]]]);');
                end
            end
        end
    end

    [MaskI, MaskJ] = ComputeMask(Input, Thresh);

    V = Original;
    U = Input;

    for i=1:nbIterMax
        Grad = ComputeGrad(Original, U, MaskI, MaskJ, Beta, Epsilon);
        NormGrad(i) = norm(Grad);
        if NormGrad(i) < StopCriterion
            break;
        end
        Energy(i) = ComputeEnergy(U, Original, Beta);

        %D'après: http://www.iro.umontreal.ca/~bengioy/ift6266/H12/html/gradient_fr.html
        Steps(i) = (Tau * stepInit) / (Tau + i);%findOptimalStep(stepInit, U, Grad, V, Beta);%
        U = U - Grad * stepInit;

        U(U < 1) = 1;
    end
end

