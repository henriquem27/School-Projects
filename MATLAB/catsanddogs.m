load datamatrix
%%
%1
C = Y(:,1:99); D = Y(:,100:end);
V=reshape(Y(:,1),64,64);
%%
%2

[Uc Lc] = eig(C*C');
[Ud Ld] = eig(D*D');
Ucf = fliplr(Uc);
Udf = fliplr(Ud);
lc = fliplr(diag(Lc)');
ld = fliplr(diag(Ld)');


%%
%3
figure

z = 1:size(lc,2);
semilogy(z, lc)
hold on
plot(z, ld)
legend('Cats', 'Dogs')
xlabel('eigenvalue index')
ylabel('eigenvalue')
%%


%4
figure
Ac = Ucf(:,1:2)'*C;
Ad = Ucf(:,1:2)'*D;
plot(Ac(1,:),Ac(2,:),'+')
hold on
plot(Ad(1,:),Ad(2,:),'o')
xlabel('Principal compoment 1')
ylabel('Principal compoment 2')
%%
%5
figure
Ac = Udf(:,1:2)'*C;
Ad = Udf(:,1:2)'*D
plot(Ac(1,:),Ac(2,:),'+')
hold on
plot(Ad(1,:),Ad(2,:),'o')
xlabel('Principal compoment 1')
ylabel('Principal compoment 2')
%%
%6
figure
Ac = Ucf(:,1:3)'*C;
Ad = Ucf(:,1:3)'*D;
plot3(Ac(1,:),Ac(2,:),Ac(3,:),'+')
hold on
plot3(Ad(1,:),Ad(2,:),Ad(3,:),'o')
xlabel('Principal compoment 1')
ylabel('Principal compoment 2')
zlabel('Principal compoment 3')
%%



