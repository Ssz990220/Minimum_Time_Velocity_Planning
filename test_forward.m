clc;
clear;
load('test_forward.mat');
tic;
[u_i,u_i1] =forward_algorithm(ds, cs, gs, qs, qd, qdd, s, phi, alpha, mu);
toc;