function [xyz,xyz_dot] = quadratic_interp(b, h)
xyz = zeros(size(b,1),3);
xyz(1,:) = [b(1),(b(2)-b(1))/(2*h),0];
for i = 2:size(b,1)-1
    xyz(i,:) = [(6*b(i)+b(i-1)+b(i+1))/8, (b(i+1)-b(i-1))/(2*h), (b(i+1)+b(i-1)-2*b(i))/(2*h^2)];
end
xyz(end,:)=[b(end), (b(end)-b(end-1))/h,0];
xyz_dot = [xyz(:,2), 2*xyz(:,3)];
end

