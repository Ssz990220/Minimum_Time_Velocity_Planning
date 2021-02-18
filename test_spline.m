[s, qs,qds,qdds] = spline_joint_function(199);

q_discrete = [0,      0.25,           0.5,                0.75,               1;
                            0,      1.288,          2.59,              4.374,           5.334;
                            0,      -0.2864,      -0.03045,     -0.04647,   -0.1657;
                            0,      -0.2982,        -0.5995,        -0.582,     -0.4504];
for i = 1:3
    figure
    plot(q_discrete(1,:),q_discrete(i+1,:),'o',s,qs(:,i));
    hold on
    plot(s,qds(:,i))
    plot(s,qdds(:,i))
    hold off
    title(sprintf('joint %d',i))
    legend('sample point','q','qd','qdd')
end
