function y = getLabels(X,m)
%% This function returns the class labels of the training examples in X
%  If x_i_sales <= Q1, y = 1 (Bad sales)
%  If Q1 < x_i_sales <= Q2, y = 2 (Slightly low)
%  If Q2 < x_i_sales <= Q3, y = 3 (Slightly high)
%  If Q3 < x_i_sales, y = 4 (High sales)
%
    S = size(X);
    
    % count = zeros(1115, 1) + 1;
    for i = 1:S(1)
        % store_id = X(i,1);
        num_sales = X(i, 4);
        % x_sales(store_id, count(store_id)) = num_sales;
        % count(store_id) = count(store_id) + 1;
        x_sales(i) = num_sales;
    end
    
    if m == 2
        q = median(x_sales);
    else
        q = quantile(x_sales, m-1);
    end
    
    % for i = 1:1115
    %     q(i, :) = quantile(x_sales(i, :), 3);
    % end
    
    for i = 1:S(1)
        % store_id = X(i, 1);
        num_sales = x_sales(i);
        if num_sales <= q(1)
           y(i) = 1;
           continue;
        end
        for j = 2:m-1
            if num_sales <= q(j) && num_sales > q(j-1)
                y(i) = j;
                break;
            end
        end
        if num_sales > q(m-1)
           y(i) = m;
        end
    end
end
