clear;
clc;
close all
n_points = 500;
phi = [2.0,2.0,2.0];          % velocity limit
alpha = [1.5,1.5,1.5];     % acceleration limit
mu = [9, 9, 9];        % torque limit
q_discrete = [0,      0.25,           0.5,                0.75,               1;
            0,      1.288,          2.59,              4.374,           5.334;
            0,      -0.2864,      -0.03045,     -0.04647,   -0.1657;
            0,      -0.2982,        -0.5995,        -0.582,     -0.4504];
robot = three_link_robot;
[s, qs, qds, qdds] = spline_joint_function(q_discrete, n_points);
[ds, cs, gs] = robot.get_dcg(qs, qds, qdds);
tic;
b = solve_optimal_speed(ds, cs, gs, qs, qds, qdds, s, phi, alpha ,mu);
toc;
[t,tau, qd_t, qdd_t] = postprocess(ds, cs, gs, b, qs, qds, qdds, s);
visualize_result(robot.n_dof, t, tau, qs(1:end-1,:), qd_t, qdd_t, s, phi, alpha, mu, b)