BV = double(imw2mat9('BV.imw')); %Should be a background image.
Noisy = double(imw2mat9('Noisy.imw'));
Thresh = 42;
MaxSteps = 10;
StepSize = 0.01;
Tau = 5000;
Beta = 0.6;
StopCriterion = 1;

clear Energy;
clear GradNorm;
clear Steps;

%Compute the local hyperparameters
%We do not use MATLAB's gradient, because we want a forward approx.
%MATLAB does it centered.
Vi = abs(cat(1, BV, BV(size(BV, 1), :)) - cat(1, BV(1, :), BV));%Compute gradient on rows
Vi = Vi(1:size(BV, 1), :);
Vj = abs(cat(2, BV, BV(:, size(BV, 2))) - cat(2, BV(:, 1), BV));%Compute gradient on columns
Vj = Vj(:, 1:size(BV, 2));

MaskI = double(Vi > Thresh);
MaskJ = double(Vj > Thresh);

%Descente de gradient
%Initialiation
U = BV;

%Iteration
for i=1:MaxSteps
    disp(strcat('Iter #', int2str(i)));
    Energy(i) = ComputeEnergy(Noisy, U, Beta);
    
    Gradient = ComputeGrad(BV, U, MaskI, MaskJ, Beta, 1E-5);
    GradNorm(i) = norm(Gradient);
    if norm(Gradient) < StopCriterion
        break;
    end
    
    Steps(i) = Tau * StepSize / (Tau + i);%findOptimalStep(StepSize, U, Gradient, Noisy, Beta);%
    U = U - Steps(i) * Gradient; %From http://www.iro.umontreal.ca/~bengioy/ift6266/H12/html/gradient_fr.html
    U(U<1) = 1;
end