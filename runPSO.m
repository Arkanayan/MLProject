
result_filename = 'results.xlsx';

% slump dataset
data = load('datasets/slump_test.data');

X = [ data(:, 2:7) data(:, 9:11)   ];

y = data(:, 8);

Xnorm = normalze(X);
ynorm = normalze(y);

[status] = runAndReportPSO(Xnorm, ynorm, 3, result_filename, 'C5');