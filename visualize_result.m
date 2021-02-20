function visualize_result(n_dof, t, tau, qs, qd_t, qdd_t, s, phi, alpha, mu, b)
%VISUALIZE_RESULT Summary of this function goes here
%   Detailed explanation goes here
figure
plot(s, b)
title('s-sdot')

figure
title('Torque of joints');
hold on
legends = strings(n_dof*2,1);
for i = 1:n_dof
    plot(t, tau(:,i));
    plot(t, repmat(mu(i),size(t,1),1));
    legends((i-1)*2+1) = sprintf('joint %d',i);
    legends((i-1)*2+2) = sprintf('torque limit %d',i);
end
legend(legends);


figure
hold on
legends = strings(n_dof*2,1);
title('Speed of joints');
for i = 1:n_dof
    plot(t, qd_t(:,i));
    plot(t, repmat(phi(i),size(t,1),1));
    legends((i-1)*2+1) = sprintf('joint %d',i);
    legends((i-1)*2+2) = sprintf('V limit %d',i);
end
legend(legends);

figure
hold on
legends = strings(n_dof*2,1);
title('Acceleration of joints');
for i = 1:n_dof
    plot(t, qdd_t(:,i));
    plot(t, repmat(alpha(i),size(t,1),1));
    legends((i-1)*2+1) = sprintf('joint %d',i);
    legends((i-1)*2+2) = sprintf('Acc limit %d',i);
end
legend(legends);