%% Cross Validation
% run a 10-fold cross validation to get the classification error

% Last updated: 6/17/2020
% By: Zulfar Ghulam-Jelani 

%% Clear and add path 
clear; clc; close all;
addpath(pwd)

%% Load Variables 

% Load basic file
basic = readtable('demo_basic.xlsx','ReadVariableNames',true,'PreserveVariableNames',true);            %contains gender information
basic_M = basic(ismember(basic.Gender,1),1:size(basic,2)); 
basic_F = basic(ismember(basic.Gender,0),1:size(basic,2)); 

% Load shape left and right files 
shape_L = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Left');
shape_R = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Right');
data = [table2array(shape_L(:,2:end)) table2array(shape_R(:,2:end))];

% Assign NaN by 0
data(isnan(data)) = 0; 

% Label
labels = basic.Gender;

%% Cross Validation Method 1 (using fitcdiscr) 

indices = crossvalind('Kfold',labels,10);
cp = classperf(labels);
for i = 1:10
    test = (indices == i); train = ~test;
    Mdl = fitcdiscr(data(train,:), labels(train,:));
    class = Mdl.predict(data(test,:));
    classperf(cp,class,test);
end
error1 = 1- cp.CorrectRate;

%% Cross Validation Method 2 (using classify)

indices = crossvalind('Kfold',labels,10);
cp = classperf(labels); 
for i = 1:10
    test = (indices == i); train = ~test;
    class = classify(data(test,:),data(train,:),labels(train));
    classperf(cp,class,test);  
end
error2 = 1- cp.CorrectRate;
