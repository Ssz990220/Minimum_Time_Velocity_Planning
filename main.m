clear;
clc;
n_points = 200;
phi = [2.0,2.0,2.0];          % velocity limit
alpha = [1.5,1.5,1.5];     % acceleration limit
mu = [9, 9, 9];        % torque limit

robot = three_link_robot;
[s, qs, qds, qdds] = spline_joint_function(n_points);
[ds, cs, gs] = robot.get_dcg(qs, qds, qdds);
tic;
b = solve_optimal_speed(ds, cs, gs, qs, qds, qdds, s, phi, alpha ,mu);
toc;
b = [b;0];
[t,tau, qd_t, qdd_t] = postprocess(ds, cs, gs, b, qs, qds, qdds, s);
visualize_result(robot.n_dof, t, tau, qs(1:end-1,:), qd_t, qdd_t, s, phi, alpha, mu, b)