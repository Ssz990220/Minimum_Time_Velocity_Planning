clear;
clc;
load('test_visualization.mat');
 visualize_result(robot.n_dof, t, tau, qs(1:end-1,:), qd_t, qdd_t, s, phi, alpha, mu, b)