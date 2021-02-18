function [xx, qs, qds, qdds] = spline_joint_function(n)
%SPLINE_JOINT_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
    q_discrete = [0,      0.25,           0.5,                0.75,               1;
                0,      1.288,          2.59,              4.374,           5.334;
                0,      -0.2864,      -0.03045,     -0.04647,   -0.1657;
                0,      -0.2982,        -0.5995,        -0.582,     -0.4504];
    xx = (0:n)*1/n;
    pp = spline(q_discrete(1,:),q_discrete(2:4,:));
    qs = ppval(pp,xx)';
    [breaks,coefs,l,k,d] = unmkpp(pp);
    pp2 = mkpp(breaks,repmat(k-1:-1:1,d*l,1).*coefs(:,1:k-1),d);
    qds = ppval(pp2, xx)';
    [breaks,coefs,l,k,d] = unmkpp(pp2);
    pp3 = mkpp(breaks,repmat(k-1:-1:1,d*l,1).*coefs(:,1:k-1),d);
    qdds = ppval(pp3, xx)';
    
            
            
end

