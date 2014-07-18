function [ step ] = findOptimalStep( stepInit, image, grad, V, Beta )
%FINDOPTIMALSTEP Summary of this function goes here
%   Detailed explanation goes here

    stepMax = stepInit;
    %Look for the range;
    EInit = ComputeEnergy(V, image, Beta);
    ETest = ComputeEnergy(V, image - grad * stepMax, Beta);
    while ETest < EInit
        stepMax = stepMax + stepInit;
        ETest = ComputeEnergy(V, image - grad * stepMax, Beta);
    end

    disp(strcat('Search between [0; ', num2str(stepMax), ']'));
    if stepMax == stepInit
        step = 0;
        disp('Warning: The first step is already too big');
    else
        %LinearSearch
        nbTests = 10;
        toTest = linspace(0, stepMax, nbTests);
        
        step = stepMax;
        EMin = ETest;
        for i = toTest(1:nbTests - 1)
            ETest = ComputeEnergy(V, image - grad * i, Beta);
            if (ETest < EMin)
                EMin = ETest;
                step = i;
            end
        end
    end
    disp(strcat('Choose: ', num2str(step)));
end

