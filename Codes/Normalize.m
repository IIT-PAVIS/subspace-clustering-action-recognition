function x = Normalize(y)
% y = [features, samples]
    for i=1:size(y,2)
        x(:,i) = y(:,i)/sqrt(y(:,i)'*y(:,i));
    end
end