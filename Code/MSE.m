function cost = MSE(X,S)
    cost=0;
    max=0;
    for i=1:size(S,1)
        cost=cost+(X(S(i,1), S(i,2))-S(i,3))^2;
    end
    cost=cost/i;
end