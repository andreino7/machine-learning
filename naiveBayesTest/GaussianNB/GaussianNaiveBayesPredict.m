function y = GaussianNaiveBayesPredict(X, model, m)
%%  This function predicts with Naive Bayes classifier for continuous and multi-valued features
% m is the number of classes
% x(i, j) is the feature j on sample i
% model is the NB model fitted previously
% y(i) is the class label for the i-th sample
%
    % X(:,[4]) = [];
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
                att = X(i, j);
                mean_jc = featureParams(j, c, 1);
                sqDev_jc = featureParams(j, c, 2);
                if j > 4 % Binary features
                    if att == 1
                        logLik = log(mean_jc);
                    else
                        logLik = log(1.0 - mean_jc);
                    end
                else % Continuous or multi-valued features
                    diff2 = (att - mean_jc).^2;
                    logLik = (-0.5*diff2/sqDev_jc) - log(sqrt(sqDev_jc*6.2832));
                end
                L(i, c) = L(i, c) + logLik;
            end
            
            % a = L(i, c);
            % b = L(i, argmax_c);
            if L(i, c) > L(i, argmax_c)
                argmax_c = c;
            end
        end
        y(i) = argmax_c;
    end
end
