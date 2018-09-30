# A Matlab inplement of ALS(Alternating Least Squares)

## Intro
This is the projcet of course *Statistical Signal Processing* (2017-2018,Fall) in Tsinghua University.


This algorithm can be used to fit a sparse matrix. It's useful to make prediction. Say, a user has never scored the movie *The Godfather*, but we can roughly predict what his attitude to this movie will be, according to his history score on other similar movies like *Once Upon a Time in America*. After that, some personal recommond can be made.

See `./Report.pdf` for more details, including mathematical derivation.

---

## Training Set
Training set is located in `./Code/data_train.mat`, which contains 90000 lines of score records. It's a 90000\*3 matrix named `data_train`, we use it to generate a 943\*1682 (943 users' score records on 1682 objects, most of the records are empty) matrix `M`. Every row of `data_train` is a piece of record with format `[row, col, score]`. 

For example, ```dara_train(1,:)=[1, 370, 15.1310]``` means the 1st user scores 15.1310 points on the 370th object, so ```M(1,370) = 15.1310```

---

## Data Striping
In the project, we are required to segment the data set into 2 part. The first part contains 80000 records in order to train, and the second part contains 10000 records used to test the preformence of our prediction. `./Code/Data_Shuffle.m` is used to do the segmentation. It makes sure no empty row occurring in the matrix `M`.

Run `./Code/Data_Shuffle.m` with Matlab and the segment result will be generated in `./Result/data_set.mat`, which contains a 80000\*3 matrix and a 10000\*3 matrix.

---


## Train!
Run `./Code/ALS.m` with Matlab. In the experiment, I found k=2, lambda=5.4 are the best parameters.

The prediction matrix X will be generated in `./Result/X.mat`, and the MSE (Mean Squared Error) between the prediction and the test set will be generated simultaneously in `./Result/MSE.mat`.

