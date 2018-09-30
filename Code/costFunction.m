function Cost = costFunction(M,U,V,W,lambda)
Cost=(norm(W.*(U*V'-M), 'fro'))^2+lambda*((norm(U,'fro'))^2+(norm(V,'fro'))^2);
end