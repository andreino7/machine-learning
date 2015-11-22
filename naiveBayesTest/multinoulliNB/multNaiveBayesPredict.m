function y = multNaiveBayesPredict(X, model, m)
%%  This function predicts with Naive Bayes classifier for multi-valued features
% m is the number of classes
% x(i, j) is the feature j on sample i
% model is the NB model fitted previously
% y(i) is the class label for the i-th sample
%
    S = size(X);
    N = S(1); % Number of samples
    D = S(2); % Dimension of each sample
    L = zeros(N, m); % log(p(x_i|c)*p(c))
    classPrior = model{1};
    featureParams = model{2};
    y = zeros(1, N);
    
    for i = 1:N
        argmax_c = 1;
        for c = 1:m
            L(i, c) = log(classPrior(c));
            for j = 1:D
                att = X(i, j) + 1; % because the enumeration starts at 1
                L(i, c) = L(i, c) + log(featureParams(j, c, att));
            end
            
            if L(i, c) > L(i, argmax_c)
                argmax_c = c;
            end
        end
        y(i) = argmax_c;
    end
end
