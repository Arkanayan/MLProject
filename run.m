clc;
clear all;
close all;
data = load('ex1data2.txt');

X = data(:, 1:2);

y = data(:, 3);

Xnorm = normalze(X);
ynorm = normalze(y);

TEST_RUN=10;

N=size(X,1);
P=0.2;

for i=1:1:TEST_RUN

[Train, Test] = crossvalind('HoldOut', N, P);

[theta,XgBest, cost_hist] = pso(Xnorm(Train,:), ynorm(Train), 20);

% figure
% title('Costs');
 num_particles = size(cost_hist, 1);

% for i = 1:num_particles
%    subplot(num_particles, 1, i);
%    plot(cost_hist(i, :));
%    title(sprintf('Particle %d', i));
% end



%--Training error
data_size=size(Xnorm(Train,:),1);

Y=ones(data_size,1)+sum(Xnorm(Train,:).*repmat(XgBest,data_size,1),2);

Error=sum(abs(ynorm(Train)-Y));

run_training_error(i,1)=Error;

%--Training error
data_size=size(Xnorm(Test,:),1);

Y=ones(data_size,1)+sum(Xnorm(Test,:).*repmat(XgBest,data_size,1),2);

Error=sum(abs(ynorm(Test)-Y));

run_testing_error(i,1)=Error;


fprintf('Error=%f\n',Error);


end

% figure;
% 
% plot(ynorm, 'DisplayName','Target');
% hold;
% plot(Y,'DisplayName','Predicted');
% hold off

% mean_testing_error=mean(run_testing_error)
% std_testing_error=std(run_testing_error)

% write to csv file
dlmwrite('housing_data_testing.csv', run_testing_error, '-append');
