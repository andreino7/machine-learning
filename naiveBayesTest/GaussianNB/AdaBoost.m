function labels = AdaBoost(X, y, m)
%% Boosting algorithm
%  X is the training set
%  y are the labels
%  m is the number of classes
%
    X(:,[4]) = [];
    S = size(X);
    N = S(1);
    D = S(2);
    labels = zeros(1,N);
    num_classifiers = 50; % floor(2*log(N));
    alpha = zeros(1,num_classifiers);
    
    % Assigning the initial weights
    for i = 1:N
        w(i) = 1.0/N;
    end
    
    Z(1,1) = 0;
    y_z(1,1) = 0;
    
    % For each classifier
    for c = 1:num_classifiers
        sum_w = 0.0;
        for i = 1:N
            sum_w = sum_w + w(i);
        end
        
        % Emphasizing the examples accordingly to their weights
        k = 0;
        for i = 1:N
            n_i = floor(N*w(i));
%             if n_i == 0
%                 n_i = 1;
%             end
            
            for j = 1:(n_i)
                for l = 1:D
                    Z(k+j,l) = X(i,l);
                end
                y_z(c,k+j) = y(i);
            end
            k = k + n_i;
        end
        
        % Fitting a new model and generating the new labels
        model = GaussianNaiveBayesFit(X,y,m);
        lb0 = GaussianNaiveBayesPredict(X,model,m);
        
        k = 0;
        for i = 1:N
            n_i = floor(N*w(i));
%             if n_i == 0
%                 n_i = 1;
%             end
            k = k + n_i;
            lb(c,i) = lb0(k);
        end
        
        % Calculating the error rate        
        err = 0.0;
        for i = 1:N
            if lb(c,i) ~= y(i)
                diff = (y(i)-lb(c,i))/(m-1);
                if diff < 0
                    diff = -diff;
                end
                err = err + w(i)*diff;
            end
        end
        
        err = err / sum_w;
        err
        alpha(c) = log((1-err)/err) + log(m-1); % Multiclass AdaBoost [Ji Zhu, 2006]
        
        % Updating w
        for i = 1:N
            if ~(lb(c,i) == y(i))
                w(i) = w(i)*exp(alpha(c));
            else
                w(i) = w(i)*exp(-alpha(c));
            end
        end
        
        % Normalizing w
        sum_w = 0.0;
        for i = 1:N
            sum_w = sum_w + w(i);
        end
        
        w = w/sum_w;
    end
    
    % Choosing the best class
    for i = 1:N
        argmax_c = 1;
        for j = 1:m
            sum_(j) = 0.0;
            for c = 1:num_classifiers
                sum_(j) = sum_(j) + alpha(c)*( lb(c,i) == j );
            end
            
            if sum_(j) > sum_(argmax_c)
                argmax_c = j;
            end
        end
        
        labels(i) = argmax_c;
    end
end
