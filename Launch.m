InputNoisy = 'Rayon30Contrast2Sample22.imw';
InputBV = 'Rayon30Contrast2Sample22.0.6.BV.imw';
InputClean = 'Rayon30Contrast2Clean.imw';%For display purposes.

InputNoisy = 'Images/CNESNoisy.imw';
InputBV = 'Images/CNESBV0.4.imw';
InputClean = 'Images/CNESClean.imw';

Beta = 0.05;
Thresh = 42;
StopCriterion = 0.2;
Epsilon = 1E-15;
stepInit = 1;
NbIterMax = 1000;

Noisy = double(imw2mat9(InputNoisy));
BV = double(imw2mat9(InputBV));
Clean = double(imw2mat9(InputClean));

[U , energy, normgrad, steps] = Main(BV, Beta, Thresh, StopCriterion, Epsilon, stepInit, NbIterMax, Noisy);

subplot(2,3,1);
imshow(uint8(Noisy));
title('Noisy Input');

subplot(2,3,2);
imshow(uint8(BV));
title('Ishikawa Solution');

subplot(2,3,3);
imshow(uint8(U));
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