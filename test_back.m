clear;
clc;
load('test_backalgo.mat');
b = backward_algorithm(ds, cs, gs, qs, qds, qdds, s, phi, alpha, mu, u_i, u_i1);

