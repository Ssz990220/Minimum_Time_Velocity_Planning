function [u_i,u_i1] = forward_algorithm(ds, cs, gs, qs, qds, qdds, s, phi, alpha, mu)
%FORWARD_ALGORITHM Summary of this function goes here
%   Detailed explanation goes here
    u_i = zeros(size(ds,1)-1,1);
    u_i1 = zeros(size(ds,1)-1,1);
    h = s(2)-s(1);
    for i = 2:size(s,2)-1
        z_bar = inf;
        y_bar = -inf;
        b_slope=zeros(size(ds,2)*2+1,1);
        f_slope = zeros(size(ds,2)*2,1);
        b_intercept=zeros(size(ds,2)*2+1,1);
        f_intercept = zeros(size(ds,2)*2,1);
        u_i1_upper = min(phi.^2/qds(i+1,:).^2);
%         b_func = cell(size(ds,2)*2 + 1);
%         f_func = cell(size(ds,2)*2);
        
        for j = 1:size(ds,2)
            if (ds(i,j)*cs(i,j) == 0)
                if ((ds(i,j)==0) && (cs(i,j)==0))
                    b_slope((j-1)*2+1) = inf;
                    f_slope((j-1)*2+1) = -inf;
    %                 b_func((j-1)*2+1) = {inf};
    %                 f_func((j-1)*2+1) = {-inf};

                end
                if ((ds(i,j)==0) && (cs(i,j)~=0))
                    b_slope((j-1)*2+1) = inf;
                    f_slope((j-1)*2+1) = -inf;
    %                 b_func((j-1)*2+1) ={ inf};
    %                 f_func((j-1)*2+1) = {-inf};
                    u_i1_upper = min(u_upper, (mu(j)-gs(i,j))/abs(c(i,j)));
                end
            end
            if ((ds(i,j)~=0 && cs(i,j)==0) | (ds(i,j)*cs(i,j)>0))
                b_slope((j-1)*2+1) = ds(i,j)/(ds(i,j)+2*h*cs(i,j));
                f_slope((j-1)*2+1) = b_slope((j-1)*2+1);
                b_intercept((j-1)*2+1) = abs((2*h*(mu(j)-gs(i,j)))/(ds(i,j)+2*h*cs(i,j)));
                f_intercept((j-1)*2+1) = -b_intercept((j-1)*2+1);
%                 b_func((j-1)*2+1) = {@(x) b_slope(j)*x + abs((2*h*(mu(j)-gs(i,j)))/(ds(i,j)+2*h*cs(i,j)))};
%                 f_func((j-1)*2+1) = {@(x)  f_slope(j) *x-abs((2*h*(mu(j)-gs(i,j)))/(ds(i,j)+2*h*cs(i,j)))};
            end
            if (ds(i,j)*cs(i,j)<0)
                b_slope((j-1)*2+1)=(ds(i,j)-2*h*cs(i,j))/ds(i,j);
                f_slope((j-1)*2+1) = b_slope((j-1)*2+1);
                b_intercept((j-1)*2+1) = abs((2*h*(mu(j)+gs(i,j)))/ds(i,j));
                f_intercept((j-1)*2+1) = -b_intercept((j-1)*2+1);
%                 b_func((j-1)*2+1) = {@(x) b_slope(j)*x + abs((2*h*(mu(j)+gs(i,j)))/ds(i,j))};
%                 f_func((j-1)*2+1) = {@(x)  f_slope(j) *x-abs((2*h*(mu(j)+gs(i,j)))/ds(i,j))};
            end
            if (qds(i,j)*qdds(i,j)==0)
                if ((qds(i,j) ==0) && (qdds(i,j)==0)) 
                    b_slope((j-1)*2+2) = inf;
                    f_slope((j-1)*2+2) = -inf;
    %                 b_func((j-1)*2+2) = {inf};
    %                 f_func((j-1)*2+2) = {-inf};
                end
                if ((qds(i,j)==0)&&(qdds~=0))
                    b_slope((j-1)*2+2) = inf;
                    f_slope((j-1)*2+2) = -inf;
    %                 b_func((j-1)*2+2) = {inf};
    %                 f_func((j-1)*2+2) = {-inf};
                    u_i1_upper = {min(u_i1_upper,alpha(j)/abs(qdds(i,j)))};
                end
            end
            if (((qds(i,j)~=0) && qdds(i,j)==0) | (qds(i,j)*qdds(i,j)>0))
                b_slope((j-1)*2+2) = qds(i,j)/((qds(i,j)+2*h*qdds(i,j)));
                f_slope((j-1)*2+2)=b_slope((j-1)*2+2);
                b_intercept((j-1)*2+2) = abs((2*h*alpha(j))/(qds(i,j)+2*h*qdds(i,j)));
                f_intercept((j-1)*2+2) = - b_intercept((j-1)*2+2);
%                 b_func((j-1)*2+2) = {@(x) b_slope(j + size(ds,2))*x + abs((2*h*alpha(j))/(qds(i,j)+2*h*qdds(i,j)))};
%                 f_func((j-1)*2+2) = {@(x) f_slope(j+size(ds,2))*x -abs((2*h*alpha(j))/(qds(i,j)+2*h*qdds(i,j)))};
            end
            if (qds(i,j)*qdds(i,j)<0)
                b_slope((j-1)*2+2) = (qds(i,j)-2*h*qdds(i,j))/qds(i,j);
                f_slope((j-1)*2+2) = b_slope((j-1)*2+2);
                b_intercept((j-1)*2+2) = abs(2*h*alpha(j)/qds(i,j));
                f_intercept((j-1)*2+2) = -b_intercept((j-1)*2+2);
%                 b_func((j-1)*2+2) = {@(x) b_slope(j + size(ds,2))*x + abs(2*h*alpha(j)/qds(i,j))};
%                 f_func((j-1)*2+2) = {@(x) f_slope(j+size(ds,2))*x -abs(2*h*alpha(j)/qds(i,j))};
            end      
        end
        b_slope(end) = 0;
        b_intercept(end) = u_i1_upper;
%         b_func(end) = {@(x) u_i1_upper};
        [~, b_order] = sort(b_slope, 'descend');
        [~, f_order] = sort(f_slope);
        x = min(phi.^2/qds(i,:).^2);
        while y_bar < z_bar
            m = size(b_slope,1);
            j = size(f_slope,1);
            while ((m>1) && (b_slope(b_order(m))*x+b_intercept(b_order(m)))>b_slope(b_order(m-1))*x+b_intercept(b_order(m-1)))
                m = m-1;
            end
            y_bar =b_slope(b_order(m))*x+b_intercept(b_order(m));
            while ((j>1) && (f_slope(f_order(j))*x+f_intercept(f_order(j)))<f_slope(f_order(j-1))*x+f_intercept(f_order(j-1)))
                j = j-1;
            end
            z_bar = f_slope(f_order(j))*x+f_intercept(f_order(j));
            x = (f_slope(f_order(j))*b_intercept(b_order(m)) + f_intercept(f_order(j)))/(1-f_slope(f_order(j))*b_slope(b_order(m)));
            disp((f_slope(f_order(j))*(b_slope(b_order(m))*x + b_intercept(b_order(m)))+f_intercept(f_order(j)))==x);
        end
%         display_forward(b_slope, b_intercept,f_slope,f_intercept,x);
        u_i(i) = x;
        u_i1(i) = y_bar;
    end
        
end

