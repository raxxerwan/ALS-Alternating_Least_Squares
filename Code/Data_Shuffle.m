clear all;
close all;
clc;
%---------------------------Load & initialize the data---------------------------
load './data_train.mat';
Testing_Data = [];
Training_Data = [];
%-------------------------得到80000个样本点的训练集-------------------------
train_num = 35;
m = 943;
n = 1682;

data_train = [data_train,zeros(size(data_train,1),1)];
data_train = sortrows(data_train,2);

Flag_of_Column = zeros(n,1);
j = 1;
for i = 1:size(data_train,1)
    if(data_train(i,2) == j)
        Flag_of_Column(j,1) = i;
        j = j + 1;
    end
end

Num_of_Column = zeros(n,1);
for i = 1:n
    if(i<n)
        Num_of_Column(i,1) = Flag_of_Column(i+1,1) - Flag_of_Column(i,1);
    else
        Num_of_Column(i,1) = size(data_train,1) - Flag_of_Column(i,1) + 1;
    end        
end

for i = 1:n
    if(i < n)
        Temp_Data = data_train(Flag_of_Column(i):Flag_of_Column(i+1)-1,:);
        if(Num_of_Column(i,1) <= train_num)
            Training_Data = [Training_Data;Temp_Data(:,1:3)];
            data_train(Flag_of_Column(i):Flag_of_Column(i+1)-1,4) = ones(Num_of_Column(i,1),1);
        else
            Row_Shuffle = randperm(size(Temp_Data,1));
            Training_Data = [Training_Data;Temp_Data(Row_Shuffle(1:train_num),1:3)];
            for j = 1:train_num
                data_train(Flag_of_Column(i)+Row_Shuffle(j)-1,4) = 1;
            end
        end
    else
        Temp_Data = data_train(Flag_of_Column(n):length(data_train),:);
        if(Num_of_Column(i,1) <= train_num)
            Training_Data = [Training_Data;Temp_Data(:,1:3)];
            data_train(Flag_of_Column(i):length(data_train),4) = ones(Num_of_Column(i,1),1);
        else
            Row_Shuffle = randperm(size(Temp_Data,1));
            Training_Data = [Training_Data;Temp_Data(Row_Shuffle(1:train_num),1:3)];
            for j = 1:train_num
                data_train(Flag_of_Column(i)+Row_Shuffle(j)-1,4) = 1;
            end
        end
    end
end

Flag_MisRow = zeros(m,1);
for i = 1:size(Training_Data,1)
    Flag_MisRow(Training_Data(i,1)) = Flag_MisRow(Training_Data(i,1)) + 1;
end

Row_Shuffle = randperm(size(data_train,1));
data_train = data_train(Row_Shuffle,:);

for i = 1:length(data_train)
    if(Flag_MisRow(data_train(i,1)) < train_num && data_train(i,4) == 0)
        Training_Data = [Training_Data;data_train(i,1:3)];
        Flag_MisRow(data_train(i,1)) = Flag_MisRow(data_train(i,1)) + 1;
        data_train(i,4) = 1;
    end
end

Row_Shuffle = randperm(size(data_train,1));
data_train = data_train(Row_Shuffle,:);

flag = 0;
for i = 1:length(data_train)
    if(data_train(i,4) == 0)
        if(length(Testing_Data) < 10000)
            Testing_Data = [Testing_Data;data_train(i,1:3)];
        else
            Training_Data = [Training_Data;data_train(i,1:3)];
        end
    end
end

Training_Data = sortrows(Training_Data,1);
Testing_Data = sortrows(Testing_Data,1);
%保存
%save('../Result/data_set.mat','Testing_Data','Training_Data');