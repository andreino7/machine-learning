
function model = GaussianNaiveBayesFit(X, y, m)
%%  This function fits a Gaussian Naive Bayes model
% m is the number of classes
% X(i, j) is the feature j value on the sample i
% y(i) is the class label of the i-th sample
% model is the model to be fitted
%
    S = size(X);
    N = S(1); % Number of samples
    D = S(2); % Dimension of each sample
    classSizes = zeros(1, m);
    classPrior = zeros(1, m);
    featureParams = zeros(D, m, 2); % mean and squared deviation of each
                                    % feature in each class
    
    % Calculating the means of the features
    for i = 1:N
        c = y(i);
        classSizes(c) = classSizes(c) + 1;
        classPrior(c) = classPrior(c) + 1;
        for j = 1:D
            att = X(i, j);
            featureParams(j, c, 1) = featureParams(j, c, 1) + att;
        end
    end
    
    classPrior = classPrior / N;
    
    for i = 1:m
        featureParams(:, i, 1) = featureParams(:, i, 1) / classSizes(i);
    end
    
    % Calculating the squared deviation of the features
    for i = 1:N
        c = y(i);
        for j = 1:D
            att = X(i, j);
            squaredDifference = ( att - featureParams(j, c, 1) ).^2;
            featureParams(j, c, 2) = featureParams(j, c, 2) + squaredDifference;
        end
    end
    
    for i = 1:m
        featureParams(:, i, 2) = featureParams(:, i, 2) / classSizes(i);
    end
    
    model = { classPrior, featureParams };
end
