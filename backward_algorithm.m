function b = backward_algorithm(ds, cs, gs, qs, qds, qdds, s, phi, alpha, mu, u)
%BACKWARD_ALGORITHM Summary of this function goes here
%   Detailed explanation goes here
    h = s(2)-s(1);
    for i = size(s,2)-1:-1:1
        f_slope=zeros(size(ds,2)*2,1);
        f_intercept=zeros(size(ds,2)*2,1);
        for j = 1:size(ds,2)
            if (ds(i,j)*cs(i,j) == 0)
                if ((ds(i,j)==0) && (cs(i,j)==0))
                    f_slope((j-1)*2+1) = inf;
                end
                if ((ds(i,j)==0) && (cs(i,j)~=0))
                    f_slope((j-1)*2+1) = inf;
                end
            end
            if ((ds(i,j)~=0 && cs(i,j)==0) | (ds(i,j)*cs(i,j)>0))
                f_slope((j-1)*2+1) = (ds(i,j)+2*h*cs(i,j))/ds(i,j);
                f_intercept((j-1)*2+1) = abs((2*h*(mu(j)+gs(i,j)))/ds(i,j));
            end
            if (ds(i,j)*cs(i,j)<0)
                f_slope((j-1)*2+1)=ds(i,j)/(ds(i,j)-2*h*cs(i,j)); 
                f_intercept((j-1)*2+1) = abs((2*h*(mu(j)+gs(i,j)))/(ds(i,j)-2*h*cs(i,j)));
            end
            if (qds(i,j)*qdds(i,j)==0)
                if ((qds(i,j) ==0) && (qdds(i,j)==0)) 
                    f_slope((j-1)*2+2) = inf;
                end
                if ((qds(i,j)==0)&&(qdds~=0))
                    f_slope((j-1)*2+2) = inf;
                end
            end
            if (((qds(i,j)~=0) && qdds(i,j)==0) | (qds(i,j)*qdds(i,j)>0))
                f_slope((j-1)*2+2) = ((qds(i,j)+2*h*qdds(i,j)))/qds(i,j);
                f_intercept((j-1)*2+2) = abs((2*h*alpha(j))/qds(i,j));
            end
            if (qds(i,j)*qdds(i,j)<0)
                f_slope((j-1)*2+2) = qds(i,j)/(qds(i,j)-2*h*qdds(i,j));
                f_intercept((j-1)*2+2) = abs(2*h*alpha(j)/(qds(i,j)-2*h*qdds(i,j)));
            end
        end
        f = f_slope * u(i+1) + f_intercept;
        u(i) = min(min(f), u(i));
    end
    b = u;
end

