function b= get_b(xyz, xyz_,b_coor_s,h)
% get b from the interpolated b
% params:
%   xyz, interploation data for curve b
%   xyz_, interpolation data for derivative of curve b
%   b_coor_s, s coordinate for b
    b_idx = round (b_coor_s/h)+1;
    b = xyz(b_idx)+xyz(b_idx+size(xyz,1)) * b_coor_s+xyz(b_idx+2*size(xyz,1)).*b_coor_s.^2;
    b = b';
end

