function a= get_a(xyz, xyz_,a_coor_s,h)
% get a from the interpolated b
% params:
%   xyz, interploation data for curve b
%   xyz_, interpolation data for derivative of curve b
%   a_coor_s, s coordinate for a
    a_idx = round(a_coor_s/h)+1;
    delta = a_coor_s - (a_idx-1)*h;
    a = xyz_(a_idx)+xyz_(a_idx+size(xyz_,1)).*delta;
    a = a';
end

