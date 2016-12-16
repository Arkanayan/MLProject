result_filename = 'results.xlsx';
no_of_iter = 3;
% slump dataset
data = load('datasets/slump_test.data');

X = [ data(:, 2:7) data(:, 9:11)   ];

y = data(:, 8);

Xnorm = normalze(X);
ynorm = normalze(y);

% Add intercept term
Xnorm = [ ones(size(Xnorm, 1), 1) Xnorm];

noOfPopulation = 20;
maxIter = 1000;


[target] = de( Xnorm, ynorm, noOfPopulation, maxIter, 0.8, 0.9 );

target

fprintf('Cost = %f \n', computeCostMulti(Xnorm, ynorm, target'));
% Show difference
% fprintf('\n\t Difference \n');

% for i=1:size(target, 1)
%     disp((Xnorm(1, :) * target(i, :)') - ynorm(1));
% end
  