x = ([ 1 3 4; 1 2 1])
xxt= x*x'
e=ones(3,1)
xm = x*(eye(3)-((e*e')/3))

[u v] = eig(xm*xm')
A1 = u(:,1:2)'*xm
plot(A1(1,:),A1(2,:),'+')