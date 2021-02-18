n_points = 200;
phi = [2.0,2.0,2.0];          % velocity limit
alpha = [1.5,1.5,1.5];     % acceleration limit
mu = [9, 9, 9];        % torque limit

robot = three_link_robot;
[s, qs, qd, qdd] = spline_joint_function(n_points);
[ds, cs, gs] = robot.get_dcg(qs, qd, qdd);
b = solve_optimal_speed(ds, cs, gs, qs, qds, qdds, s, phi, alpha ,mu);
