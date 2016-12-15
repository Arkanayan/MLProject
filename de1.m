function [ best xbest  it_best] = de1( X, y, noOfPopulation, maxIter, crossoverRate, scaleFactor )
%DE Summary of this function goes here
%   Detailed explanation goes here

crossoverRate = 0.8;
scaleFactor = 0.9;

dimen = size(X, 2);
population = rand(noOfPopulation, dimen);

count = 1;

cost = zeros(noOfPopulation, 1) + 10;

score= zeros(noOfPopulation, 1);

it_best=zeros(maxIter,1);

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
      
        j = ceil(rand() * dimen);
      
       
       for k = 1:dimen
           if rand() < crossoverRate || k == j
               trial(k) = population(c, k) + scaleFactor * (population(a, k) - population(b, k));
           else
               trial(k) = population(i, k);
           end
          
           
       end
       
       score(i,1) = costFunction(X, y, 1, trial);
       
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
       
    end

     population=target;
    
    count = count + 1;
    
   [best idx]=min(score);
   xbest=population(idx,:);
   fprintf('best=%f\n', best);
    
   it_best(count,1)=best;
   
end
