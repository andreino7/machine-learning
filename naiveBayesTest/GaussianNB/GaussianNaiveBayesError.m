function err = GaussianNaiveBayesError(X, y, m)
%%  This function calculates the Naive Bayes classifier error
% m is the number of classes
% x(i, j) is the feature j on sample i
% y(i) is the class label for the i-th sample
%
    X(:,[4]) = [];
    S = size(X);
    N = S(1);
    model = GaussianNaiveBayesFit(X,y,m);
    lb = GaussianNaiveBayesPredict(X,model,m);
    
    % Calculating the error rate
    err = 0.0;
    for i = 1:N
        if ~(lb(i) == y(i))
            diff = (y(i)-lb(c,i))/(m-1);
            if diff < 0
                diff = -diff;
            end
            err = err + diff;
        end
    end
    
    err = err / N;
end
