
result_filename = 'results.xlsx';
no_of_iter = 3;
% slump dataset
data = load('datasets/slump_test.data');

X = [ data(:, 2:7) data(:, 9:11)   ];

y = data(:, 8);

Xnorm = normalze(X);
ynorm = normalze(y);

[status] = runAndReportPSO(Xnorm, ynorm, no_of_iter, result_filename, 'C5');

if status == 1
    disp('Slump dataset saved successfully');
end


%Housing dataset
data = load('datasets/housing.data.txt');

X = data(:, 1:13);

y = data(:, 14);

Xnorm = normalze(X);
ynorm = normalze(y);

[status] = runAndReportPSO(Xnorm, ynorm, no_of_iter, result_filename, 'D5');

if status == 1
    disp('Housing dataset saved successfully');
end
%