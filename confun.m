%x(1)= lambda, x(2)= k
%c<=ceq ?
function [c, ceq] = confun(x)
% Nonlinear inequality constraints
c = [-x(1); -x(2)];
% Nonlinear equality constraints
ceq = [];