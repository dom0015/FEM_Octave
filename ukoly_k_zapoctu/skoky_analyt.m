%% predefine:
% M ... pocet podoblasti
% MATERIALS ... vektor materialovych konstant na podoblastech (delka M)

k=MATERIALS;
h=1/M; % delka podoblasti

A = zeros(M+1); % matice soustavy
b = zeros(M+1,1); % vektor prave strany
% prvni rovnice soustavy (Dirichletova podminka u(0)=0):
A(1,1)=1;
for m=1:M-1 % M-1 rovnic pro podm. prechodu (ze spojitosti stavove funkce):
    A(m+1,m)=1;
    A(m+1,m+1)=-1;
    A(m+1,end)=m*h/k(m)-m*h/k(m+1);
    b(m+1)=-m*m*h*h/2/k(m+1) + m*m*h*h/2/k(m);
end
% posledni rovnice soustavy (Dirichletova podminka u(1)=0)
A(end,M)=1; A(end,end)=M*h/k(M); b(end)=M*M*h*h/2/k(M);

% reseni soustavy a extrakce konstant d1,...,dM,c:
const = A\b;
d = const(1:M);
c = const(end);

% vykresleni na jemne siti:
u = @(x,k,c,d)-x.^2/2/k + c*x/k + d;
steps=100;
xx = linspace(0,1,M*steps);
yy = zeros(M*steps,1);
for m=1:M
    idx = (m-1)*steps+1 : m*steps;
    yy(idx) = u(xx(idx),k(m),c,d(m));
end
plot(xx,yy)
disp(c);
disp(d);