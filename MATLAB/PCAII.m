load datamatrix

%1)
C = Y(:,1:99); 
D = Y(:,100:end);
e99= ones(99,1);
Cm = C*(eye(99)-(e99*e99')/99);
Dm = D*(eye(99)-e99*e99'/99);

max(mean(Cm'))


%2
[Uc Lc] = eig(Cm*Cm');
[Ud Ld] = eig(Dm*Dm');
%to reorder from largest to smallest
Ucf = fliplr(Uc);
Udf = fliplr(Ud);
lc = fliplr(diag(Lc)');
ld = fliplr(diag(Ld)');

%3
subplot(2,2,1)
z = 1:size(lc,2);
semilogy(z, lc)
hold on
plot(z, ld)
legend('Cats', 'Dogs')
xlabel('eigenvalue index')
ylabel('eigenvalue')


%4
subplot(2,2,2)
Ac = Ucf(:,1:2)'*Cm
Ad = Ucf(:,1:2)'*Dm
plot(Ac(1,:),Ac(2,:),'+')
hold on
plot(Ad(1,:),Ad(2,:),'o')
xlabel('Principal compoment 1')
ylabel('Principal compoment 2')


%6
subplot(2,2,3)
Ac = Ucf(:,1:3)'*Cm;
Ad = Ucf(:,1:3)'*Dm;
plot3(Ac(1,:),Ac(2,:),Ac(3,:),'+')
hold on
plot3(Ad(1,:),Ad(2,:),Ad(3,:),'o')
xlabel('Principal compoment 1')
ylabel('Principal compoment 2')
zlabel('Principal compoment 3')

%test
figure 

plot(Ucf(2,:),Ucf(2,:),'+')
hold on
plot(Udf(2,:),Udf(2,:),'o')



