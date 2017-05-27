function [ best, costHist ] = IFWA(X, y, initialNumFw, maxIter )
%FWA Summary of this function goes here
%   Detailed explanation goes here
%% Initialize parameters
initialNumFw = 10;
best = 0;
count = 1;
maxIter = 200;
Xmax = 1;
Xmin = 0;
a = 0.04;
b = 0.8;
m = 50;
maxAmp = 40;
mGauss = 10;
dimen = size(X, 2);
costHist = zeros(maxIter, 1);
maxSparks = 32;
minSparks = 2;
max_ctrl_param = 20;
min_ctrl_param = 1;
max_eval = maxIter * initialNumFw;
%% Generate Initial population

initialPopulation = rand(initialNumFw, size(X, 2)); 

cost = zeros(size(initialPopulation, 1), 1);

% for i = 1:size(cost, 1)
%     cost(i) = computeCostMulti(X, y, initialPopulation(i, :)');
% end
%%

numSparks = zeros(initialNumFw, 1);
amps = zeros(initialNumFw, 1);

while count < (maxIter + 1)
    
    for i = 1:size(initialPopulation, 1)
        cost(i) = computeCostMulti(X, y, initialPopulation(i, :)');
    end
    %% Sorting sparks according to costs
    [sortedCosts, sortedIndex] = sort(cost, 'ascend');
    tempPopulation = initialPopulation;
    
    for sortIter = 1 : size(tempPopulation, 1)
       tempPopulation(1, :) = initialPopulation(sortedIndex(sortIter), :);       
    end
    initialPopulation = tempPopulation;
    
    %% Normalize costs
    normalizedCosts = normalze(sortedCosts);
    
    fitnessDiff = zeros(initialNumFw, 1);
    for diffIter = 1 : initialNumFw - 1
        fitnessDiff(diffIter + 1) = ( normalizedCosts(diffIter) - normalizedCosts(diffIter + 1) ) ;
    end
    
    %% Calculate Score
    score = zeros(initialNumFw, 1);
    for scoreIter = 1 : initialNumFw
       score(scoreIter) = scoreIter + sum(fitnessDiff); 
    end
    
    %% Calculate Adaptive Transfer Function
    atf = sigmoid(score); 
    
    %% Calculate no. of sparks
    for j = 1:initialNumFw
        
        numSparks(j) = m * (atf(j) / sum(atf));
        
        if numSparks(j) < minSparks
            numSparks(j) = minSparks;
        elseif numSparks(j) > maxSparks
            numSparks(j) = maxSparks;
        else
            numSparks(j) = round(numSparks(j));
        end
        
        %% Calculate Amplitude using ATF
        amps(j) = maxAmp * ( atf(initialNumFw - j + 1) / sum(atf));
        
        %% Generate Sparks
        for k = 0:numSparks(j) - 1
            rowIndex = 1;
           if j ~= 1
              rowIndex = size(sparks, 1) + 1;
           end
           sparks(rowIndex, :) = initialPopulation(j, :);
           z = randi(dimen);
            g = rand();
            dimens = randperm(dimen, z);
            
            %% Generate Sparks by randomly changing dimensions
            for d = 1:z
                maxRange = 1;
                minRange = -1;
                randomNum = minRange + (maxRange - minRange) * rand(1); 
                displacement = amps(j) * randomNum;
                sparks(rowIndex, dimens(d)) = sparks(rowIndex, d) +  displacement;
                spark = sparks(rowIndex, dimens(d));
                sparks(rowIndex, dimens(d)) = clamp(spark, 1, 0);
                
            end
           
        end
        
    end
    
    %% Gaussian Mutation
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
    

   %% Selection for sparks for next iteration
   allSparks = [initialPopulation ; sparks];
    newCosts = zeros(size(allSparks, 1), 1);
    for costIter = 1:size(allSparks, 1)
       newCosts(costIter) = computeCostMulti(X, y, allSparks(costIter, :)');
    end
    
   allCosts = newCosts;
   
%    % select best N values
   [~, sortedCostIndices] = sort(allCosts, 'ascend');
   
   % Select best sparks for next iteration
   initialPopulation(:, :) = allSparks(sortedCostIndices(1:initialNumFw), :);

    
   %% reset all variables
    costHist(count) = allCosts(sortedCostIndices(1));
    allSparks = [];
    allCosts = [];
    newCosts = [];
    sparks = [];
    
    %% Increment Counter
    count = count + 1;
end
        %% Find best spark and Return
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



