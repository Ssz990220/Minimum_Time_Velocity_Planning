clear;
clc;
load('test_all.mat');
tic;
b = solve_optimal_speed(ds, cs, gs, qs, qds, qdds, s, phi, alpha ,mu);
toc;
[t,tau, qd_t, qdd_t] = postprocess(ds, cs, gs, b, qs, qds, qdds, s);
visualize_result(robot.n_dof, t, tau, qs(1:end-1,:), qd_t, qdd_t, s, phi, alpha, mu, b)