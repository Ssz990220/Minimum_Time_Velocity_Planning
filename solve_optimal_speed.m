function b = solve_optimal_speed(ds, cs, gs, qs, qds, qdds, s, phi, alpha, mu)
%SOLVE_OPTIMAL_SPEED Summary of this function goes here
%   Detailed explanation goes here
    
[u_i,u_i1] = forward_algorithm2(ds, cs, gs, qs, qds, qdds, s, phi, alpha, mu);
b = backward_algorithm(ds, cs, gs, qs, qds, qdds, s, phi, alpha, mu, u_i, u_i1);


end

