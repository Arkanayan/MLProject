
result_filename = 'results.xlsx';
no_of_iter = 3;
learning_rate = 0.6;

% slump dataset
data = load('datasets/slump_test.data');

X = [ data(:, 2:7) data(:, 9:11)   ];

y = data(:, 8);

Xnorm = normalze(X);
ynorm = normalze(y);


[status] = runAndReportGD(Xnorm, ynorm, learning_rate, no_of_iter, result_filename, 'B5');
%[theta, Jhist] = gradientDescentMulti(Xnorm, ynorm, theta, 0.6, 1000);

if status == 1
    disp('Slump dataset saved successfully');
end


%Housing dataset
data = load('datasets/housing.data.txt');

X = data(:, 1:13);

y = data(:, 14);

Xnorm = normalze(X);
ynorm = normalze(y);

% learning rate needs to be 0.1 for this dataset
[status] = runAndReportGD(Xnorm, ynorm, 0.1, no_of_iter, result_filename, 'H5');

if status == 1
    disp('Housing dataset saved successfully');
end

% O-ring dataset
data = load('datasets/o-ring-erosion-or-blowby.data');

X = data(:, 2:5);

y = data(:, 1);

Xnorm =  normalze(X);
ynorm =  y;

[status] = runAndReportGD(Xnorm, ynorm, learning_rate, no_of_iter, result_filename, 'N5');

if status == 1
    disp('O ring dataset saved successfully');
end


% Concrete Compressive strength

data = load('datasets/Concrete_Data.csv');

X = data(:, 1:8);

y = data(:, 9);

Xnorm = normalze(X);
ynorm = normalze(y);

[status] = runAndReportGD(Xnorm, ynorm, learning_rate, no_of_iter, result_filename, 'T5');

if status == 1
    disp('Concrete Compressive strength dataset saved successfully');
end

% Red Wine quality

data = load('datasets/winequality-red.csv');

X = data(:, 1:11);

y = data(:, 12);

Xnorm = normalze(X);
ynorm = normalze(y);

[status] = runAndReportGD(Xnorm, ynorm, learning_rate, no_of_iter, result_filename, 'Z5');

if status == 1
    disp('Red wine quality dataset saved successfully');
end


% Red Wine quality

data = load('datasets/winequality-white.csv');

X = data(:, 1:11);

y = data(:, 12);

Xnorm = normalze(X);
ynorm = normalze(y);

[status] = runAndReportGD(Xnorm, ynorm, learning_rate, no_of_iter, result_filename, 'AF5');

if status == 1
    disp('White wine quality dataset saved successfully');
end
