function [u_i,u_i1] = forward_algorithm2(ds, cs, gs, qs, qds, qdds, s, phi, alpha, mu)
%FORWARD_ALGORITHM Summary of this function goes here
%   Detailed explanation goes here
    u_i = zeros(size(ds,1)-1,1);
    u_i1 = zeros(size(ds,1)-1,1);
    
%     y_z = zeros(size(ds, 1)-1,1);
    h = s(2)-s(1);
    for i = 1:size(s,2)-1
        z_bar = inf;
        y_bar = -inf;
        b_slope=zeros(size(ds,2)*2+1,1);
        f_inv_slope = zeros(size(ds,2)*2,1);
        b_intercept=zeros(size(ds,2)*2+1,1);
        f_inv_intercept = zeros(size(ds,2)*2,1);
        u_i1_upper = min(phi.^2./qds(i+1,:).^2);
        if i == size(s,2)-1
            u_i1_upper = 0;
        end
        
        for j = 1:size(ds,2)
            if (ds(i,j)*cs(i,j) == 0)
                if ((ds(i,j)==0) && (cs(i,j)==0))
                    b_slope((j-1)*2+1) = inf;
                    f_inv_slope((j-1)*2+1) = -inf;

                end
                if ((ds(i,j)==0) && (cs(i,j)~=0))
                    b_slope((j-1)*2+1) = inf;
                    f_inv_slope((j-1)*2+1) = -inf;
                    u_i1_upper = min(u_upper, (mu(j)-gs(i,j))/abs(c(i,j)));
                end
            end
            if ((ds(i,j)~=0 && cs(i,j)==0) | (ds(i,j)*cs(i,j)>0))
                b_slope((j-1)*2+1) = ds(i,j)/(ds(i,j)+2*h*cs(i,j));
                f_inv_slope((j-1)*2+1) = b_slope((j-1)*2+1);
                b_intercept((j-1)*2+1) = abs((2*h*(mu(j)-gs(i,j)))/(ds(i,j)+2*h*cs(i,j)));
                f_inv_intercept((j-1)*2+1) = -abs((2*h*(mu(j)+gs(i,j)))/(ds(i,j)+2*h*cs(i,j)));
%                 b_intercept((j-1)*2+1) = (2*h*(mu(j)-gs(i,j)))/(ds(i,j)+2*h*cs(i,j));
%                 f_inv_intercept((j-1)*2+1) = -(2*h*(mu(j)+gs(i,j)))/(ds(i,j)+2*h*cs(i,j));
            end
            if (ds(i,j)*cs(i,j)<0)
                b_slope((j-1)*2+1)=(ds(i,j)-2*h*cs(i,j))/ds(i,j);
                f_inv_slope((j-1)*2+1) = b_slope((j-1)*2+1);
                b_intercept((j-1)*2+1) = abs((2*h*(mu(j)-gs(i,j)))/ds(i,j));
                f_inv_intercept((j-1)*2+1) = -abs((2*h*(mu(j)+gs(i,j)))/ds(i,j));
%                 b_intercept((j-1)*2+1) = (2*h*(mu(j)-gs(i,j)))/ds(i,j);
%                 f_inv_intercept((j-1)*2+1) = -(2*h*(mu(j)+gs(i,j)))/ds(i,j);
            end
            if (qds(i,j)*qdds(i,j)==0)
                if ((qds(i,j) ==0) && (qdds(i,j)==0)) 
                    b_slope((j-1)*2+2) = inf;
                    f_inv_slope((j-1)*2+2) = -inf;
                end
                if ((qds(i,j)==0)&&(qdds~=0))
                    b_slope((j-1)*2+2) = inf;
                    f_inv_slope((j-1)*2+2) = -inf;
                    u_i1_upper = {min(u_i1_upper,alpha(j)/abs(qdds(i,j)))};
                end
            end
            if (((qds(i,j)~=0) && qdds(i,j)==0) | (qds(i,j)*qdds(i,j)>0))
                b_slope((j-1)*2+2) = qds(i,j)/((qds(i,j)+2*h*qdds(i,j)));
                f_inv_slope((j-1)*2+2)=b_slope((j-1)*2+2);
                b_intercept((j-1)*2+2) = abs((2*h*alpha(j))/(qds(i,j)+2*h*qdds(i,j)));
                f_inv_intercept((j-1)*2+2) = - b_intercept((j-1)*2+2);
%                 b_intercept((j-1)*2+2) = 2*h*alpha(j)/(qds(i,j)+2*h*qdds(i,j));
%                 f_inv_intercept((j-1)*2+2) = -b_intercept((j-1)*2+2);
            end
            if (qds(i,j)*qdds(i,j)<0)
                b_slope((j-1)*2+2) = (qds(i,j)-2*h*qdds(i,j))/qds(i,j);
                f_inv_slope((j-1)*2+2) = b_slope((j-1)*2+2);
                b_intercept((j-1)*2+2) = abs(2*h*alpha(j)/qds(i,j));
                f_inv_intercept((j-1)*2+2) = -b_intercept((j-1)*2+2);
%                 b_intercept((j-1)*2+2) = 2*h*alpha(j)/qds(i,j);
%                 f_inv_intercept((j-1)*2+2) = -b_intercept((j-1)*2+2);
            end      
        end
        b_slope(end) = 0;
        b_intercept(end) = u_i1_upper;
        x = min(phi.^2./qds(i,:).^2);
        if i == 1
            x = 0;
        end
        
        while y_bar < z_bar
            b = b_slope*x+b_intercept;
            f = f_inv_slope * x + f_inv_intercept;
            [y_bar, idx_b] = min(b);
            [z_bar, idx_f] = max(f);
            
%             y_z(i) = y_bar - z_bar;
            x_pre = x;
            x = (1/f_inv_slope(idx_f))*b_intercept(idx_b) + (-f_inv_intercept(idx_f)/f_inv_slope(idx_f))/(1-1/f_inv_slope(idx_f)*b_slope(idx_b));
%             display_forward(b_slope, b_intercept, f_inv_slope, f_inv_intercept, x);
        end
        u_i(i) = x_pre;
        u_i1(i) = y_bar;
        if i == size(s,2)-1
            u_i1(i) = 0;
        end
    end
        
end