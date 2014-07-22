function [ U, Energy, NormGrad, Steps ] = Main( Input, Scatterers, Beta, Thresh, StopCriterion, Epsilon, stepInit, nbIterMax, Original )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    Tau = 50;
    %Default values
    if nargin < 7
        nbIterMax = 5000;
        if nargin < 6
            stepInit = 0.0001;
            if nargin < 5
                Epsilon = 1E-15;
                if nargin < 4
                    disp('Usage: Main(Input, Beta, Thresh, StopCriterion, [Epsilon, [stepInit, [nbIterMax]]]);');
                end
            end
        end
    end
    
    MessagePeriod = nbIterMax / 1000;

    [MaskI, MaskJ] = ComputeMask(Input, Thresh);

    V = Original;
    U = Input;

    nbCharToDelete = 0;
    for i=1:nbIterMax
        U(U < 1) = 1;
        
        Grad = ComputeGrad(V, U, Scatterers, MaskI, MaskJ, Beta, Epsilon);
        NormGrad(i) = norm(Grad);
        if NormGrad(i) < StopCriterion
            break;
        end
        Energy(i) = ComputeEnergy(U, V, Scatterers, Beta);
        
        if mod(i, MessagePeriod) == 0
            msg = ['Processed ', num2str(i / nbIterMax * 100), '%%'];
            fprintf(repmat('\b',1,nbCharToDelete));
            fprintf(msg);
            nbCharToDelete=numel(msg) - 1;
        end

        %D'après: http://www.iro.umontreal.ca/~bengioy/ift6266/H12/html/gradient_fr.html
        Steps(i) = (Tau * stepInit) / (Tau + i);%findOptimalStep(stepInit, U, Grad, V, Beta);%
%         for k=-100:100
%             Paysage(k + 101) = ComputeEnergy(U - Grad * k * stepInit, V, Beta);
%         end
        U = U + Grad * stepInit;
    end
end

