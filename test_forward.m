clc;
clear;
load('test_forward.mat');
tic;
u_i =forward_algorithm2(ds, cs, gs, qs, qd, qdd, s, phi, alpha, mu);
toc;


% h = s(2)-s(1);
% figure
% plot(s(1:200),u_i);
% hold on
% plot(s(1:200),u_i1);
% limit = min((phi.^2./qd.^2)');
% plot(s,limit);
% plot(s,-limit);