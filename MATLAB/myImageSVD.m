%this code goes with Module 13 Lecture 2
%it concerns the application of the SVD to an image.
% problem 275)
%1)Plot an image loaded into matlab from your phone.

X = imread('IMG_3623.jpg');
Y = rgb2gray(X);
figure; subplot(1,2,1),imagesc(X);
subplot(1,2,2),imagesc(Y); colormap(gray)
%2)Compute the SVD of this image.

[U S V] = svd(double(Y));

%3)Plot the singular values of this image.
figure
z = 1:size(S,2);

semilogy(diag(S))

%4)Plot the rank one outer-products uu', associated with first for left and
%right vectors
Y1 = U(:,1)*S(1,1)*V(:,1)';
Y2 = U(:,2)*S(2,2)*V(:,2)';
Y3 = U(:,3)*S(3,3)*V(:,3)';
Y4 = U(:,4)*S(4,4)*V(:,4)';
figure
subplot(2,2,1),imagesc(Y1)
colormap(gray)

title('rank 1: term 1')
subplot(2,2,2),imagesc(Y2)
colormap(gray)

title('rank 1: term 2')

subplot(2,2,3),imagesc(Y3)
title('rank 1: term 3')
colormap(gray)

subplot(2,2,4),imagesc(Y4)
title('rank 1: term 4')
colormap(gray)
%5)Plot the approximations, for the sum of sigma*ui*vi'
R1 = Y1;
R2 = Y1+Y2;
R3 = R2+Y3;
R4 = R3 + Y4;
figure
subplot(2,2,1),imagesc(R1)
title('rank 1 approx')
colormap(gray)
subplot(2,2,2),imagesc(R2)
title('rank 2 approx')
colormap(gray)
subplot(2,2,3),imagesc(R3)
title('rank 3 approx')
colormap(gray)
subplot(2,2,4),imagesc(R4)
title('rank 4 approx')
colormap(gray)

%6)Plot the approximations for k=10,20,30,40.
R10 = U(:,1:10)*S(1:10,1:10)*(V(:,1:10))';
R20 = U(:,1:20)*S(1:20,1:20)*(V(:,1:20))';
R30 = U(:,1:30)*S(1:30,1:30)*(V(:,1:30))';
R40 = U(:,1:40)*S(1:40,1:40)*(V(:,1:40))';

figure
subplot(2,2,1),imagesc(R10)
title('rank 10 sum')
colormap(gray)

subplot(2,2,2),imagesc(R20)
title('rank 20 sum')
colormap(gray)

subplot(2,2,3),imagesc(R30)
title('rank 30 sum')
colormap(gray)

subplot(2,2,4),imagesc(R40)
title('rank 40 sum')
colormap(gray)
%7)Plot i) the original image Y , ii) A100 and iii) the log of the
%absolute value image Y ? A100.
R100 = U(:,1:100)*S(1:100,1:100)*(V(:,1:100))';

figure
subplot(1,3,1),imagesc(Y)
title('original')
subplot(1,3,2),imagesc(R100)
title('rank 100 sum')
subplot(1,3,3),imagesc(double(Y)-R100)
colormap(gray)
title('error')

figure
imagesc(log(abs(double(Y)-R100)))
title('Log of absolute value of error')
colormap(gray)


figure
mesh((double(Y)-R100))
title('error')