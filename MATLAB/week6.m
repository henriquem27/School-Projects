u1 = [1;2;0;0;0];
u2 = [-2;1;0;0;3];
wh1 = u1/norm(u1);
wh2 = u2/norm(u2);
u=[wh1 wh2];

x = [1;2;3;4;5];

test = u'*u



p=u*u'*x

P = u*u'


q=p-x

qnov = norm(q)


y=[-1;3;0;0;3];

py = u*u'*y

qy = py-y
qynov = norm(qy)

mI = eye(5)
q
z = (mI-P)*x






