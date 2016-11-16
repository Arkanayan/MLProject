
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

[status] = runAndReportPSO(Xnorm, ynorm, no_of_iter, result_filename, 'I5');

if status == 1
    disp('Housing dataset saved successfully');
end

% O-ring dataset
data = load('datasets/o-ring-erosion-or-blowby.data');

X = data(:, 2:5);

y = data(:, 1);

Xnorm =  normalze(X);
ynorm =  y;

[status] = runAndReportPSO(Xnorm, ynorm, no_of_iter, result_filename, 'O5');

if status == 1
    disp('O ring dataset saved successfully');
end


% Concrete Compressive strength

data = load('datasets/Concrete_Data.csv');

X = data(:, 1:8);

y = data(:, 9);

Xnorm = normalze(X);
ynorm = normalze(y);

[status] = runAndReportPSO(Xnorm, ynorm, no_of_iter, result_filename, 'U5');

if status == 1
    disp('Concrete Compressive strength dataset saved successfully');
end
