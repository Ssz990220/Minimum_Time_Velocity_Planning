clear;
clc;
load('test_postprocess.mat');
h = s(2)-s(1);
figure
plot(s,b);
hold on
[xyz, xyz_] = quadratic_interp(b, h);
bs = get_b(xyz, xyz_, (0:500)*1/500,h);linspace(1,max(s),200);
figure
plot((0:500)*1/500,bs);