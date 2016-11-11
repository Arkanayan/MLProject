function fitness = costFunction(X, y, num_particles, curr_pos) 
%% FITNESS Calculates fitness
fitness = zeros(num_particles, 1);
m = size(y,1);

for j = 1:num_particles
   fitness(j,1) =  sum( (y - (1 + X * curr_pos(j, :)')) .^ 2 ) / (2*m);
  
end


end