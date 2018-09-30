clear all;
close all;
clc;
%-------------------------定义、载入数据--------------------------
m=943;
n=1682;
k=2;
lambda=5.4;
eps=1e-4;
load '../Result/data_set.mat';

%----------------------由80000个数据点生成M和W---------------------
M=zeros(m,n);
W=zeros(m,n);
average=0;
for i=1:80000
    data=training_data(i,:);
    M(data(1),data(2))=data(3);
    average=average+data(3);
end
average=average/80000;
W(M~=0)=1;


%-----------------------------优化U和V-------------------------------
%MSE_TrainSet=zeros(8,50);
%MSE_TestSet=zeros(8,50);
%for k=2:2
%for lambda=1:0.2:10
U=abs(average+randn(m,k));
V=rand(n,k);
MaxIter=1000;
Cost=zeros(MaxIter,1);

for iter=1:MaxIter
    %固定V，对U作优化
    for i=1:m
        Wi=repmat((W(i,:))', 1, k);
        U(i,:)=(((Wi.*V)'*(Wi.*V)+lambda*eye(k,k))^-1 *(Wi.*V)'* (M(i,:))')';
    end
    %固定U，对V作优化
    for j=1:n
        Wj=repmat(W(:,j), 1, k);
        V(j,:)= (M(:,j))'*(Wj.*U)*((Wj.*U)'*(Wj.*U)+lambda*eye(k,k))^-1;
    end
    Cost(iter,1)=costFunction(M,U,V,W,lambda)/80000;
    if iter>1 && abs(Cost(iter)-Cost(iter-1))<eps
        break;
    end
end
X=U*V';
%save('../Result/X.mat','X');
%MSE_TestSet(k,round(lambda/0.2))=MSE(X,random_data(80001:90000,:));
%MSE_TrainSet(k,round(lambda/0.2))=MSE(X,random_data(1:80000,:));

%end
%end
