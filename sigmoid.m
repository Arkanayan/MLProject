function [result] = sigmoid(input)

result = 1 ./ ( 1 + exp(input));
end