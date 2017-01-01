
noOfPopulation = 20;

deMaxIter = 1000;

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

%[best, costHist] = FWA(Xnorm, ynorm, noOfPopulation);

%best
% for j = 1:size(best, 1)
%     
%    computeCostMulti(Xnorm, ynorm, best(j, :)') 
% end

%costHist
%[status] = runAndReportDE(Xnorm, ynorm, deMaxIter, no_of_iter, result_filename, 'H5');
[status] = runAndReportFWA(Xnorm, ynorm, deMaxIter, no_of_iter, result_filename, 'E5');

%status
% if status == 1
%     disp('Slump dataset saved successfully');
% end
% 
% 
% % %Housing dataset
data = load('datasets/housing.data.txt');

X = data(:, 1:13);

y = data(:, 14);

Xnorm = normalze(X);
ynorm = normalze(y);

Xnorm = [ ones(size(Xnorm, 1), 1) Xnorm];

% [best] = FWA(Xnorm, ynorm, noOfPopulation);
[status] = runAndReportFWA(Xnorm, ynorm, deMaxIter, no_of_iter, result_filename, 'K5');
status

if status == 1
    disp('Housing dataset saved successfully');
end
% 
% % O-ring dataset
data = load('datasets/o-ring-erosion-or-blowby.data');

X = data(:, 2:5);

y = data(:, 1);

Xnorm =  normalze(X);
ynorm =  y;

Xnorm = [ ones(size(Xnorm, 1), 1) Xnorm];

% for O-ring the # of iterations need to be set to 200
[status] = runAndReportFWA(Xnorm, ynorm, deMaxIter, no_of_iter, result_filename, 'Q5');

if status == 1
    disp('O ring dataset saved successfully');
end
% 
% 
% % Concrete Compressive strength
% 
data = load('datasets/Concrete_Data.csv');

X = data(:, 1:8);

y = data(:, 9);

Xnorm = normalze(X);
ynorm = normalze(y);

Xnorm = [ ones(size(Xnorm, 1), 1) Xnorm];

[status] = runAndReportFWA(Xnorm, ynorm, deMaxIter, no_of_iter, result_filename, 'W5');

if status == 1
    disp('Concrete Compressive strength dataset saved successfully');
end

% % Red Wine quality
% 
data = load('datasets/winequality-red.csv');

X = data(:, 1:11);

y = data(:, 12);

Xnorm = normalze(X);
ynorm = normalze(y);

Xnorm = [ ones(size(Xnorm, 1), 1) Xnorm];

[status] = runAndReportFWA(Xnorm, ynorm, deMaxIter, no_of_iter, result_filename, 'AC5');

if status == 1
    disp('Red wine quality dataset saved successfully');
end
% 
% 
% % White Wine quality
% 
data = load('datasets/winequality-white.csv');

X = data(:, 1:11);

y = data(:, 12);

Xnorm = normalze(X);
ynorm = normalze(y);

Xnorm = [ ones(size(Xnorm, 1), 1) Xnorm];

[status] = runAndReportFWA(Xnorm, ynorm, deMaxIter, no_of_iter, result_filename, 'AI5');

if status == 1
    disp('White wine quality dataset saved successfully');
end
