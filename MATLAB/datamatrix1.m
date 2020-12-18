    load datamatrix
V=reshape(Y(:,1),64,64);
imagesc(V)

W=reshape(Y(:,2),64,64);
imagesc(W)

Z=reshape(Y(:,100),64,64);
imagesc(Z)

%% 1)
v=Y(:,1)
w=Y(:,2);



%%
z=Y(:,100)


vh=v/norm(v)

p=vh*vh';
pw=vh*vh'*w;
compw= (eye(4096)-pw)*w
subplot(2,3,1)
imagesc(reshape(pw,64,64))
title('Pw')
subplot(2,3,2)
imagesc(reshape(compw,64,64))
title('compw')
pz=vh*vh'*z;
subplot(2,3,3)
imagesc(reshape(pz,64,64))
title('PZ')




compz= (eye(4096)-p)*z;

subplot(2,3,4)
imagesc(reshape(compz,64,64))
title('compz')


span=[v w];

spanh=span/norm(span);

pspan=spanh*spanh';
pzs=pspan*z;
subplot(2,3,5)
imagesc(reshape(pzs,64,64))
title('Pz on span')










