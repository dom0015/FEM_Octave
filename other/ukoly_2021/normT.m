function [L2normT,L2normT_dx,L2normT_dy]=normT(x1,x2,x3,y1,y2,y3,uh1,uh2,uh3,u,u_dx,u_dy)
%% vypocet L2 normy uh-u na obecnem trojuhelniku T
% souradnice vrcholu trojuhelniku T: (x1,y1), (x2,y2), (x3,y3)
% poradi vrcholu: proti smeru hodinovych rucicek
% u(x,y) ... zadana hladka funkce
% uh(x,y) = a*x + b*y + c ... linearni funkce zadana hodnotami
% ve vrcholech: uh1=uh(x1,y1), uh2=uh(x2,y2), uh3=uh(x3,y3)

% vypocet konstant a,b,c a vytvoreni funkce uh:
M = [x1 y1 1; x2 y2 1; x3 y3 1];
rhs = [uh1; uh2; uh3];
abc = M\rhs; a=abc(1); b=abc(2); c=abc(3);
uh = @(x,y) a*x + b*y + c;
% L2 norma - integrovana funkce:
fun = @(x,y) (uh(x,y) - u(x,y)).^2;
% integrace pres zadany trojuhelnik:
I = integralT(fun,x1,x2,x3,y1,y2,y3);
% L2 norma:
L2normT=sqrt(I);

% derivace funkce uh: uh_dx=a; uh_dy=b;
% L2 norma dx - integrovana funkce:
fun = @(x,y) (a - u_dx(x,y)).^2;
I = integralT(fun,x1,x2,x3,y1,y2,y3);
L2normT_dx=sqrt(I);
% L2 norma dy - integrovana funkce:
fun = @(x,y) (b - u_dy(x,y)).^2;
I = integralT(fun,x1,x2,x3,y1,y2,y3);
L2normT_dy=sqrt(I);
end

function I=integralT(f,x1,x2,x3,y1,y2,y3)
%% integrace funkce f(x,y) pres obecny trojuhelnik Txy
% souradnice vrcholu trojuhelniku Txy: (x1,y1), (x2,y2), (x3,y3)
% poradi vrcholu: proti smeru hodinovych rucicek
% substituce na trojuhelnik Tuv s vrcholy (0,0), (1,0), (0,1)

% zobrazeni (u,v) -> (x,y):
g1 = @(u,v) x1 + u*(x2-x1) + v*(x3-x1);
g2 = @(u,v) y1 + u*(y2-y1) + v*(y3-y1);
% Jakobian zobrazeni:
J = (x2-x1)*(y3-y1) - (x3-x1)*(y2-y1);
% integrovana funkce po substituci:
f_subs = @(u,v) f(g1(u,v),g2(u,v)) * J;
% hodnota integralu funkce f(x,y) pres Txy:
I = integral2(f_subs,0,1,0,@(u)1-u);
end