InputNoisy = 'Images/CNESNoisy.imw';
InputBV = 'Images/CNESBV0.4.imw';
%These can be left empty (i.e. = '') if not available.
InputS = 'Images/CNESS0.4.imw';
InputClean = 'Images/CNESClean.imw';

%Parameters
Beta = 0.03;
Thresh = 42;
StopCriterion = 0.2;
Epsilon = 1E-15;
stepInit = 5;
NbIterMax = 1000;

%Load images
Noisy = double(imw2mat9(InputNoisy));
BV = double(imw2mat9(InputBV));
if isempty(InputS)
    S = zeros(size(InputBV));
else
    S = double(imw2mat9(InputS));
end
if isempty(Clean)
    Clean = zeros(size(InputBV));
else
    Clean = double(imw2mat9(InputClean));
end

%Computation
[U , energy, normgrad, steps] = Main(BV, S, Beta, Thresh, StopCriterion, Epsilon, stepInit, NbIterMax, Noisy);

%Display results
if isempty(Clean)
    subplot(2,2,1);
    imshow(displayableSARImage(Noisy));
    title('Noisy Input');
    
    subplot(2,2,2);
    imshow(displayableSARImage(BV));
    title('Ishikawa Solution');
    
    subplot(2,2,3);
    imshow(displayableSARImage(U));
    title(strcat('Grad (beta = ', num2str(Beta), ')'));
    
    subplot(2,2,4);
    plot(energy);
    title('Énergie');
else
    subplot(2,3,1);
    imshow(displayableSARImage(Noisy));
    title('Noisy Input');

    subplot(2,3,2);
    imshow(displayableSARImage(BV));
    title('Ishikawa Solution');

    subplot(2,3,3);
    imshow(displayableSARImage(U));
    title(strcat('Grad (beta = ', num2str(Beta), ')'));

    subplot(2,3,4);
    imshow(uint8(abs(Clean - BV)));
    colorbar;
    title('Abs diff avec l''entrée et Ishikawa');

    subplot(2,3,5);
    imshow(uint8(abs(Clean - U)));
    colorbar;
    title('Abs diff avec l''entrée et Grad');

    subplot(2,3,6);
    plot(energy);
    title('Énergie');
end