function [ best ] = de( X, y, noOfPopulation, maxIter, crossoverRate, scaleFactor )
%DE Summary of this function goes here
%   Detailed explanation goes here

crossoverRate = 0.8;
scaleFactor = 0.9;

dimen = size(X, 2);
population = rand(noOfPopulation, dimen);

count = 1;

cost = zeros(noOfPopulation, 1);

for i=1:noOfPopulation
%     cost(i) = costFunction(X,y, 1, population(i,:));
    cost(i) = computeCostMulti(X, y, population(i, :)');
end


while count < maxIter
    for i=1:noOfPopulation
       a = i; b = i; c = i;
       while a == i
           a = ceil(rand() * noOfPopulation);
       end
       while b == i || b == a
           b = ceil(rand() * noOfPopulation);
       end
       while c == i || c == a || c == b
           c = ceil(rand() * noOfPopulation);
       end
%        j = 0;
%        while j == 0
%         j = ceil(rand() * dimen);
%        end
       
       for k = 1:dimen
           if rand() < crossoverRate || k == dimen
               trial(k) = population(c, k) + scaleFactor * (population(a, k) - population(b, k));
           else
               trial(k) = population(i, k);
           end
%            j = mod(j + 1, dimen+1);
%            if j == 0
%                j = 1;
%            end
           
       end
       
      % score(i,1) = costFunction(X, y, 1, trial);
      score(i, 1) = computeCostMulti(X, y, trial');
       
       if score(i,1) <= cost(i)
           for j=1:dimen
               target(i, j) = trial(j);
           end
           cost(i) = score(i,1);
       else
           for j=1:dimen
               target(i,j) = population(i, j);
           end
       end
       
    end % End of population loop

   population = target;
    
   count = count + 1;
    
%    best(count) = min(score);
   
%    fprintf('best= %f\n', min(cost));
    
end

[~, idx] = min(cost);

best = population(idx, :);

% for i = 1:dimen
% %    fprintf('%f \n', population(idx, :));
%     population(idx, :)
%    fprintf('cost = %f \n', computeCostMulti(X, y, population(idx, :)')); 
% end


end

