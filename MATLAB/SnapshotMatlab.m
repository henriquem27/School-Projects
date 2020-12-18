%this example compares the direct and snapshot methods for computing the
%left singular vectors of a tall matrix.  (Cats and Dogs data set.)

load datamatrix.mat 

C = Y(:,1:99);%C has size 4096 x 99
D = Y(:,100:end);

figure
imagesc(reshape(C(:,1),64,64))

pause

figure
imagesc(reshape(D(:,1),64,64))
n = size(C,2);

tic; [Uc Dc] = eig(C*C'/n); toc; 
[Ud Dd] = eig(D*D'/n);


Ucf = fliplr(Uc);
Udf = fliplr(Ud);

dc = diag(Dc);
dd = diag(Dd);

%first eigen cats.
figure
imagesc(reshape(Ucf(:,1),64,64))
title('direct method')
figure
imagesc(reshape(Ucf(:,2),64,64))
title('direct method')

%figure
%imagesc(reshape(Udf(:,1),64,64))


%%%%%%%%%USING SNAPSHOT METHOD%%%%%%%%%%%%
tic; 
[V L] = eig(C'*C);%THIS IS A SMALL MATRIX!!
toc;
Vf = fliplr(V);%book-keeping
l = (fliplr(diag(L)'));

Usnap = C*Vf*inv(sqrt(diag(l)));
%snapshot eigencats.
figure; imagesc(reshape(Usnap(:,1),64,64))
title('snapshot method')
figure; imagesc(reshape(-1*Usnap(:,2),64,64))
title('snapshot method')
