w = [2;1]
p = [1;1]
wh = w/norm(w)

norm(wh)

plot(2,1,"ro")

x = -2:.1:2
y = 3*x

hold on
plot(x,y,'g')

P=wh*wh'

T = P*p

plot(0.6,1.2,"bx")

hold off

