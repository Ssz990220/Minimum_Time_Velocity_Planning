function [t,tau, qd_t, qdd_t] = postprocess(ds, cs, gs, b, qs, qds, qdds, s)
%POSTPROCESS Summary of this function goes here
%   Detailed explanation goes here
h = s(2) - s(1);
[xyz, xyz_] = quadratic_interp(b, h);
% a = (b(2:end)-b(1:end-1))/(2*h);
a = get_a(xyz, xyz_, s,h);
% ds = ds(1:end-1,:);
% cs = cs(1:end-1,:);
% gs = gs(1:end-1,:);
% qs = qs(1:end-1,:);
tau = ds.*a + cs.*b+gs;
qd_t = qds.*sqrt(b);
qdd_t = qds.*a + qdds.*b;

t = cumsum(2*h./(sqrt(b(2:end))+sqrt(b(1:end-1))));
t = [0;t];
end

