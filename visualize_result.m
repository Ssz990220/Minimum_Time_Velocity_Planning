function visualize_result(n_dof, t, tau, qs, qd_t, qdd_t, s, phi, alpha, mu, b)
%VISUALIZE_RESULT Summary of this function goes here
%   Detailed explanation goes here
figure
plot(s, b)
title('s-sdot')

figure
title('Torque of joints');
hold on
ylim([-1.1*max(mu), 1.1*max(mu)]);
legends = strings(n_dof*3,1);
for i = 1:n_dof
    plot(t, tau(:,i));
    plot(t, repmat(mu(i),size(t,1),1));
    plot(t, repmat(-mu(i),size(t,1),1));
    legends((i-1)*3+1) = sprintf('joint %d',i);
    legends((i-1)*3+2) = sprintf('torque upper limit %d',i);
    legends((i-1)*3+3) = sprintf('torque lower limit %d',i);
    
end
legend(legends);


figure
hold on
ylim([-1.1*max(phi), 1.1*max(phi)]);
legends = strings(n_dof*3,1);
title('Speed of joints');
for i = 1:n_dof
    plot(t, qd_t(:,i));
    plot(t, repmat(phi(i),size(t,1),1));
    plot(t, repmat(-phi(i),size(t,1),1));
    legends((i-1)*3+1) = sprintf('joint %d',i);
    legends((i-1)*3+2) = sprintf('V upper limit %d',i);
    legends((i-1)*3+3) = sprintf('V lower limit %d',i);
end
legend(legends);

figure
hold on
ylim([-1.1*max(alpha), 1.1*max(alpha)]);
legends = strings(n_dof*3,1);
title('Acceleration of joints');
for i = 1:n_dof
    plot(t, qdd_t(:,i));
    plot(t, repmat(alpha(i),size(t,1),1));
    plot(t, repmat(-alpha(i),size(t,1),1));
    legends((i-1)*3+1) = sprintf('joint %d',i);
    legends((i-1)*3+2) = sprintf('Acc upper limit %d',i);
    legends((i-1)*3+3) = sprintf('Acc lower limit %d',i);
end
legend(legends);