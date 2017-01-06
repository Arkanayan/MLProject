function [theta,XgBest, cost_hist] = pso(X, y, noOfParticles)

%% Variables
%noOfParticles = 3;
iterations = 200;



dimen = size(X, 2);
theta = zeros(dimen, 1);
inertia_weight = 0.729;
c1 = 1.44945;
c2 = c1;
r1 = rand();
r2 = rand();
%% Normalize variables/features
% X - mean(X) / std(X)

%Xnorm = zeros(size(X));
% 
% for i = 1:dimen
%     Xnorm(:,i) = ( X(:,i) - mean(X(:,i)) ) / std(X(:,i));
% end
%Xnorm = normalze(X);
% Add intercept term
%Xnorm = [ ones(size(Xnorm,1),1) Xnorm];
Xnorm = X;

dimen = size(Xnorm, 2);
% Xnorm = normalze(X);
 %  ynorm = (y - mean(y)) / std(y);
 ynorm = y;
 %ynorm = normalze(y);
%% Set limits
%             Xmax D1, Xmax D2
%             Xmin D1, Xmin D2
% Position limits
% Xmax1 = max of X1[]
% Xmin1 = min of X1[]
Xlimits = zeros(2, dimen);

num_cols = size(Xnorm, 2);

for i = 1:num_cols
    Xlimits(1, i) =1;
    Xlimits(2, i) = 0;

end

% Velocity limits
% [ Vmax D1, Vmax D2
%   Vmin D1, Vmin D2 ]
% Vmin = -Vmax
Vlimits = zeros(2, dimen);

for i = 1:num_cols
    % Vmax         = 0.1 * ( Xmax - Xmin )
    Vlimits(1, i) = 0.1 * ( Xlimits(1,i) - Xlimits(2, i) );
    Vlimits(2, i) = - Vlimits(1, i);
end

%% Generate initial positions
Xinit = zeros(noOfParticles, dimen);
Vinit = zeros(size(Xinit));

num_rows = size(Xinit, 1);

%fprintf('r=%d c=%d\n',num_rows,num_cols );

for i = 1:num_rows
    for j = 1:num_cols
        %               Xmin              (  Xmax     -   Xmin) * rand
        Xinit(i, j) = Xlimits(2, j) + ( ( Xlimits(1, j) - Xlimits(2, j) ) * rand() );
        
        Vinit(i, j) = Vlimits(2, j) + ( ( Vlimits(1, j) - Vlimits(2, j) ) * rand() );
    end
end

%size(Xinit)

%% Pso
%fitnes = zeros(noOfParticles, 1);
m = size(y, 1);

fitness = costFunction(Xnorm, ynorm, noOfParticles, Xinit);
cost_hist = fitness;
pBest = zeros(size(fitness));
pBest = fitness;

XpBest = zeros(noOfParticles, dimen);
XpBest = Xinit;

[gBest, index] = min(fitness);
XgBest = Xinit(index, :);

% disp(fitness);
for i = 1:iterations
    for j = 1:noOfParticles
        for k = 1:dimen
            r1 = rand(); r2 = rand();
            % update velocity
            Vinit(j, k) = inertia_weight * Vinit(j, k) + c1 * r1 * (XpBest(j, k) - Xinit(j, k)) ...
                            + c2 * r2 * (XgBest(1, k) - Xinit(j, k));
            % velocity clamping            
            Vinit(j, k) = clamp(Vinit(j, k), Vlimits(1, k), Vlimits(2, k));
            % update position
            Xinit(j, k) = Xinit(j , k) + Vinit(j, k);
            % clamping position
            %Xinit(j, k) = clamp(Xinit(j, k), Xlimits(1, k), Xlimits(2,k));
        end
    end
    
    fitness = costFunction(Xnorm, ynorm, noOfParticles, Xinit);
    
    cost_hist = [cost_hist fitness];
    for j = 1:noOfParticles
        if fitness(j) < pBest(j)
            pBest(j) = fitness(j);
            XpBest(j, :) = Xinit(j, :);
        end
        if fitness(j) < gBest
            gBest = fitness(j);
            XgBest = Xinit(j, :);
        end
    end
end
theta = XgBest';
fprintf('GBest = %f\n', gBest);
XgBest
%pBest
%fprintf('Best position: %f %f\n', XgBest);
end



function val = clamp(value, max, min)
val = value;
if value > max
    val = max;
elseif value < min
     val = min;
end
end
