function Xnorm = normalze(X)
Xnorm = zeros(size(X));
dimen = size(X, 2);
for i = 1:dimen
%     Xnorm(:,i) = ( X(:,i) - mean(X(:,i)) ) / std(X(:,i));
      Xnorm(:, i) = (X(:, i) - min(X(:, i)) ) / ( max(X(:,i)) - min(X(:, i)));
end

end