function model = multNaiveBayesFit(X, y, m)
%%  This function fits a multinoulli Naive Bayes model
% m is the number of classes
% X(i, j) is the feature j value on the sample i.
%  The values are enumerated from 1;
% y(i) is the class label of the i-th sample
% model is the model to be fitted
%
    S = size(X);
    N = S(1); % Number of samples
    D = S(2); % Dimension of each sample
    classSizes = zeros(1, m);
    classPrior = zeros(1, m);
    MNVALUES = 20; % The maximum number of possible values for
                   % each feature is 20
    featureParams = zeros(D, m, MNVALUES);
    
    for i = 1:N
        c = y(i);
        classSizes(c) = classSizes(c) + 1;
        classPrior(c) = classPrior(c) + 1;
        for j = 1:D
            att = X(i, j);
            featureParams(j, c, att) = featureParams(j, c, att) + 1;
        end
    end
    
    classPrior = classPrior / N;
    
    for i = 1:m
        for j = 1:D
            for k = 1:MNVALUES
                featureParams(j, i, k) = featureParams(j, i, k) / classSizes(i);
            end
        end
    end
    
    model = { classPrior, featureParams };
end
