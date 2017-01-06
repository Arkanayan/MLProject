function [ status ] = runAndReportDE(X, y, de_iter, no_of_iter, fileName, start_cell)
%RUNANDREPORT Run PSO and write it to excel
%   Detailed explanation goes here

% xlswrite(filename, run_testing_error, 'Testing', 'C5');

TEST_RUN=10;

N=size(X,1);
P=0.2;

Xnorm = X;
ynorm = y;

num_of_iter = 3;

result_testing_error = [];
result_training_error = [];

if ~exist('de_iter', 'var')
    de_iter = 200;
end

for j = 1:1:num_of_iter

for i = 1:1:TEST_RUN

[Train, Test] = crossvalind('HoldOut', N, P);

[theta] = de(Xnorm, ynorm, 10, de_iter, 0.8, 0.9 );



%--Training error
data_size = size( Xnorm(Train,:), 1 );

Y = Xnorm(Train,:) * theta';

Error=sum( abs( ynorm(Train) - Y ) );

run_training_error(i,1) = Error;

%--Training error
data_size = size(Xnorm(Test,:), 1);

Y = Xnorm(Test, :) * theta'; 

Error = sum( abs( ynorm(Test) - Y ) );

run_testing_error(i,1) = Error;


fprintf('Error = %f\n', Error);


end

result_testing_error = [ result_testing_error ; run_testing_error];
result_training_error = [ result_training_error ; run_training_error];
end

[status_test] = xlswrite(fileName, result_testing_error, 'Testing', start_cell);
[status_train] = xlswrite(fileName, result_training_error, 'Training', start_cell);

status = status_test && status_train;
% End of function
end

