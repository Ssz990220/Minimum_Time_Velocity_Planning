function [xx, qs, qds, qdds] = spline_joint_function(q_discrete, n)
%SPLINE_JOINT_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
    xx = (0:n)*1/n;
    pp = spline(q_discrete(1,:),q_discrete(2:end,:));
    qs = ppval(pp,xx)';
    [breaks,coefs,l,k,d] = unmkpp(pp);
    pp2 = mkpp(breaks,repmat(k-1:-1:1,d*l,1).*coefs(:,1:k-1),d);
    qds = ppval(pp2, xx)';
    [breaks,coefs,l,k,d] = unmkpp(pp2);
    pp3 = mkpp(breaks,repmat(k-1:-1:1,d*l,1).*coefs(:,1:k-1),d);
    qdds = ppval(pp3, xx)';
    
            
            
end

