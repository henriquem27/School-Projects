A=sym([1 2; 2 -1])

[V,D] = eig(A)

z=V'*A*V

