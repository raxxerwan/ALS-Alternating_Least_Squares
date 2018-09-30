clear all;
close all;
clc;
%-------------------------���塢��������--------------------------
m=943;
n=1682;
k=2;
lambda=5.4;
eps=1e-4;
load '../Result/data_set.mat';

%----------------------��80000�����ݵ�����M��W---------------------
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


%-----------------------------�Ż�U��V-------------------------------
%MSE_TrainSet=zeros(8,50);
%MSE_TestSet=zeros(8,50);
%for k=2:2
%for lambda=1:0.2:10
U=abs(average+randn(m,k));
V=rand(n,k);
MaxIter=1000;
Cost=zeros(MaxIter,1);

for iter=1:MaxIter
    %�̶�V����U���Ż�
    for i=1:m
        Wi=repmat((W(i,:))', 1, k);
        U(i,:)=(((Wi.*V)'*(Wi.*V)+lambda*eye(k,k))^-1 *(Wi.*V)'* (M(i,:))')';
    end
    %�̶�U����V���Ż�
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
