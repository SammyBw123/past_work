%%  LDA Classifier 
% Use LDA to find a representative male subject and female subject. 
% The steps are the following:
% Please train an LDA (https://www.mathworks.com/help/stats/discriminant-analysis.html) by
% using the shape data. The shape data includes all columns in data_shape.xlsx
% Once you train the classifier, apply it to predict male/female using the training data. 
% The subject with the highest male score will be used as a representative subject for male. 
% Same for female.

% Last updated: 6/16/2020
% By: Zulfar Ghulam-Jelani 

%% Clear and add path 
clear; clc; close all;
addpath(pwd)

%% Load Variables 

% Load basic file
basic = readtable('demo_basic.xlsx','ReadVariableNames',true,'PreserveVariableNames',true);            %contains gender information

% Load shape left and right files 
shape_L = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Left');
shape_R = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Right');
data = [table2array(shape_L(:,2:end)) table2array(shape_R(:,2:end))];

% Assign NaN by 0
data(isnan(data)) = 0; 

% Label
labels = basic.Gender;

%% LDA

Mdl = fitcdiscr(data,labels);        
[label,score,cost] = predict(Mdl,data);        
%score - Predicted class posterior probabilities
%Predicted class posterior probabilities, returned as a numeric matrix of size N-by-K. 
%N is the number of observations (rows) in X, and K is the number of classes (in Mdl.ClassNames). 
%score(i,j) is the posterior probability that observation i in X is of class j in Mdl.ClassNames.
                                                        
% Find max score for each gender (male, female)
[maxM,IM] = max(score(:,2));
[maxF,IF] = max(score(:,1));

maleSubject   = basic.Subject(IM);
femaleSubject = basic.Subject(IF);
