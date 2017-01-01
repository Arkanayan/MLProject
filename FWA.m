function [ best, costHist ] = FWA(X, y, initialFw, maxIter )
%FWA Summary of this function goes here
%   Detailed explanation goes here
%% Initialize parameters
initialFw = 5;
best = 0;
count = 0;
maxIter = 500;
Xmax = 1;
Xmin = 0;
a = 0.04;
b = 0.8;
m = 50;
maxAmp = 40;
mGauss = 5;
dimen = size(X, 2);
costHist = [];
%% Generate Initial population

initialPopulation = rand(initialFw, size(X, 2)); 

cost = zeros(size(initialPopulation, 1), 1);

for i = 1:size(cost, 1)
    cost(i) = computeCostMulti(X, y, initialPopulation(i, :)');
end
%%

numSparks = zeros(initialFw, 1);
amps = zeros(initialFw, 1);

while count < maxIter
    
    for i = 1:size(initialPopulation, 1)
        cost(i) = computeCostMulti(X, y, initialPopulation(i, :)');
    end
    
    for j = 1:initialFw
        % Calculate no. of sparks
        numSparks(j) = ( max(cost) - computeCostMulti(X, y, initialPopulation(j, :)') + eps);
        
        denom = 0;
%         for k = 1:initialFw
%             denom = denom + ( max(cost) - computeCostMulti(X, y, initialPopulation(k, :)'));
%         end
        denom = denom + ((initialFw * max(cost)) - sum(cost));
        denom = denom + eps;
        
        numSparks(j) =  m * (numSparks(j) / denom);
        
        if numSparks(j) < a * m
            numSparks(j) = round( a * m);
        elseif numSparks(j) > b*m
            numSparks(j) = round(b * m);
        else
            numSparks(j) = round(numSparks(j));
        end
        
        % Calculate the amplitudes
        amps(j) = ( computeCostMulti(X, y, initialPopulation(j, :)') - min(cost) + eps);
        
        denom = 0;
%         for k = 1:initialFw
%             denom = denom + (computeCostMulti(X, y, initialPopulation(k, :)') - min(cost));
%         end
        denom = denom + (sum(cost) - (min(cost) * initialFw) );
        denom = denom + eps;
        
        amps(j) =  maxAmp * (amps(j) / denom);
        
        % Generate Sparks
        %sparks = zeros(sum(numSparks) + mGauss, size(X, 2));
        for k = 0:numSparks(j) - 1
            rowIndex = 1;
           if j ~= 1
              rowIndex = size(sparks, 1) + 1;
           end
           sparks(rowIndex, :) = initialPopulation(j, :);
           z = randi(dimen);
            g = rand();
            dimens = randperm(dimen, z);
            
            for d = 1:z
            % generate amplitude between -A and A
                amplitude = (amps(j)+amps(j)).*rand(1) - amps(j);
                sparks(rowIndex, dimens(d)) = sparks(rowIndex, d) +  amplitude;
                spark = sparks(rowIndex, dimens(d));
                sparks(rowIndex, dimens(d)) = clamp(spark, 1, 0);
                
            end
           
        end
        
    end
    
    % sparks = zeros(mGauss, size(X, 2));
    rowIndex = size(sparks, 1);
    for j = 1:mGauss
        rowIndex = rowIndex + 1;
        fireworkIndex = randi(initialFw);
        z = randi(dimen);
        g = rand();
        dimens = randperm(dimen, z);
        sparks(rowIndex, :) = initialPopulation(fireworkIndex, :);
        
        for d = 1:z
           % generate amplitude between -A and A
           sparks(rowIndex, dimens(d)) = clamp(sparks(rowIndex, d) * g, 1, 0);
        end
        
    end
    
    % select best location
    % Generate costs
    newCosts = zeros(size(sparks, 1), 1);
    for costIter = 1:size(sparks, 1)
       newCosts(costIter) = computeCostMulti(X, y, sparks(costIter, :)');
    end
    
   [bestSparkCost, bestSparkIndex] =  min(newCosts);
   bestSpark = sparks(bestSparkIndex, :);
   
   allSparks = [initialPopulation ; sparks];
   allCosts = [cost; newCosts];
   
   % select best N values
   [sortedCosts, sortedCostIndices] = sort(allCosts, 'ascend');
   
   for n = 1 : initialFw
      initialPopulation(n, :) = allSparks(sortedCostIndices(n), :); 
   end
    count = count + 1;
    
    % reset all variables
    costHist = [costHist; sortedCosts(initialFw)];
    allSparks = [];
    allCosts = [];
    newCosts = [];
    sparks = [];
end
        cost = [];
        for i = 1:size(initialPopulation, 1)
            cost(i) = computeCostMulti(X, y, initialPopulation(i, :)');
        end
        [bestScore, bestIndex] = min(cost);
        best = initialPopulation(bestIndex, :);
end

function [ result ] = clamp(value, maxVal, minVal)
    result = value;
    if value < minVal || value > maxVal
        
       result =  minVal + mod(value, maxVal - minVal);
    end

end



