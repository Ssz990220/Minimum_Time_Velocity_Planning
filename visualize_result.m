function visualize_result(n_dof, t, tau, qs, qd_t, qdd_t, s, phi, alpha, mu, b)
%VISUALIZE_RESULT Summary of this function goes here
%   Detailed explanation goes here
figure
plot(s, b)
title('s-s_dot')

figure
hold on
legends = []
for i = 1:n_dof
    plot(t, tau(:,i));
    legends = [legends, sprintf('joint %d',i)];
end
legend(legends);
