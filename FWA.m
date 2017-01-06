function [ best, costHist ] = FWA(X, y, initialNumFw, maxIter )
%FWA Summary of this function goes here
%   Detailed explanation goes here
%% Initialize parameters
initialNumFw = 10;
best = 0;
count = 0;
maxIter = 200;
Xmax = 1;
Xmin = 0;
a = 0.04;
b = 0.8;
m = 50;
maxAmp = 40;
mGauss = 10;
dimen = size(X, 2);
costHist = [];
%% Generate Initial population

initialPopulation = rand(initialNumFw, size(X, 2)); 

cost = zeros(size(initialPopulation, 1), 1);

for i = 1:size(cost, 1)
    cost(i) = computeCostMulti(X, y, initialPopulation(i, :)');
end
%%

numSparks = zeros(initialNumFw, 1);
amps = zeros(initialNumFw, 1);

while count < maxIter
    
    for i = 1:size(initialPopulation, 1)
        cost(i) = computeCostMulti(X, y, initialPopulation(i, :)');
    end
    
    for j = 1:initialNumFw
        % Calculate no. of sparks
        numSparks(j) = ( max(cost) - computeCostMulti(X, y, initialPopulation(j, :)') + eps);
        
        denom = 0;
%         for k = 1:initialFw
%             denom = denom + ( max(cost) - computeCostMulti(X, y, initialPopulation(k, :)'));
%         end
        denom = denom + ((initialNumFw * max(cost)) - sum(cost));
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
        denom = denom + (sum(cost) - (min(cost) * initialNumFw) );
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
        fireworkIndex = randi(initialNumFw);
        z = randi(dimen);
        g = rand();
        dimens = randperm(dimen, z);
        sparks(rowIndex, :) = initialPopulation(fireworkIndex, :);
        
        for d = 1:z
           % generate amplitude between -A and A
           sparks(rowIndex, dimens(d)) = clamp(sparks(rowIndex, d) * g, 1, 0);
        end
        
    end
    

   
   allSparks = [initialPopulation ; sparks];
%   allCosts = [cost; newCosts];
%    
%    % select best N values
%    [sortedCosts, sortedCostIndices] = sort(allCosts, 'ascend');
%    
%    for n = 1 : initialFw
%       initialPopulation(n, :) = allSparks(sortedCostIndices(n), :); 
%    end

    % Selection of locations
    % calculate distance
    distance = zeros(size(allSparks, 1), 1);
    for disIter = 1:size(allSparks , 1)
        distance(disIter) = 0;
       for sparkIter= 1:size(allSparks, 1)
           if sparkIter == disIter
               continue
           else
               tempDistance = abs(sum(allSparks(disIter, :) - allSparks(sparkIter, :)));
               distance(disIter) = distance(disIter) + tempDistance;
           end
       end
    end
   
    % Calculate Probablity
    probability = zeros(size(allSparks, 1), 1);
    sumDistance = sum(distance);
    for probIter = 1:size(allSparks, 1)
       probability(probIter) = distance(probIter) / sumDistance; 
    end
    
    % Select Sparks for next generation
    selectedSparks = zeros(initialNumFw - 1, size(X, 2)); 
    for selectionIter = 1 : initialNumFw - 1
        
        sumProbability = 0;
        randomProb = rand();
        for sparksIter = 1 : size(allSparks, 1)
            sumProbability = sumProbability + probability(sparksIter);
           if randomProb < sumProbability
               selectedSparks(selectionIter, :) = allSparks(sparksIter, :);
               break
           end
        end
    end
    % Find best spark
        % select best location
    % Generate costs
    newCosts = zeros(size(allSparks, 1), 1);
    for costIter = 1:size(allSparks, 1)
       newCosts(costIter) = computeCostMulti(X, y, allSparks(costIter, :)');
    end
    [bestSparkCost, bestSparkIndex] =  min(newCosts);
    bestSpark = allSparks(bestSparkIndex, :);
    
    selectedSparks = [selectedSparks; bestSpark];
    
    initialPopulation = selectedSparks;
    
    
    count = count + 1;
    
    % reset all variables
   % costHist = [costHist; sortedCosts(initialFw)];
    allSparks = [];
    allCosts = [];
    newCosts = [];
    sparks = [];
end
        % Find best spark and Return
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



