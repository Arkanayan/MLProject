function [time] = calculateTime(func)

timeStart = tic;

[~] = func();

time = toc(timeStart);
% fprintf('\nTime: %f\n', time);

end