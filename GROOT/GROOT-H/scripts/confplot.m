function varargout = confplot(a,b)
sigx = 1:size(a,2);                              % Create Independent Variable
sigy = a-b;                                % Create Dependent Variable ‘Experiments’ Data
sigN = size(sigy,1);                                      % Number of ‘Experiments’ In Data Set
sigySEM = std(sigy,'omitnan')/sqrt(sigN);                    % Compute ‘Standard Error Of The Mean’ Of All Experiments At Each Value Of ‘x’
sigCI95 = tinv([0.025 0.975], sigN-1);                    % Calculate 95% Probability Intervals Of t-Distribution
sigyCI95 = bsxfun(@times, sigySEM, sigCI95(:));              % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ‘x’
varargout{1} = sigyCI95;