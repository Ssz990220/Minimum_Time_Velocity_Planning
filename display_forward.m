function  display_forward(b_slope, b_intercept, f_slope, f_intercept, u_hat)
%DISPLAY_FORWARD Summary of this function goes here
%   Detailed explanation goes here
% xx = u_hat * 2;
xx =u_hat * 2;

xx = linspace(0,xx,500);

figure
hold on
ys = zeros(size(b_slope,1),size(xx,2));
ys_ = zeros(size(f_slope,1),size(xx,2));
for i = 1:size(b_slope,1)
    y = xx*b_slope(i) + b_intercept(i);
    ys(i,:) = y;
    plot(xx, y,'c--')
end
for i = 1:size(f_slope,1)
    y_ =  xx*f_slope(i) + f_intercept(i);
    ys_(i,:) = y_;
    plot(xx,y_,'g--')
end
y_min = min(ys);
y_max = max(ys_);
b_min = plot(xx,y_min,'b');
f_max = plot(xx,y_max,'r');
% legend('b-min', 'f-max');
legend([b_min, f_max],{'b-min','f-max'});

x_line = linspace(0,max(max(y_max), max(max(ys))),500);
plot(ones(1,500)*u_hat, x_line,'y');
crosspoint = [u_hat * b_slope + b_intercept;u_hat * f_slope + f_intercept];
plot(ones(1,size(crosspoint,1))*u_hat, crosspoint,'o');

end

