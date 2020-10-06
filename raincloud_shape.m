%% raincloud plot of shape 

% Last updated: 6/15/2020
% By: Zulfar Ghulam-Jelani 


%% Load variables 


%% Clear and add path 
clear; clc; close all;
addpath(pwd)

for handedness = 0:1

% Load basic file
basic = readtable('demo_basic.xlsx','ReadVariableNames',true,'PreserveVariableNames',true);            %contains gender information
% Exclude left-handed people (handedness score < 0)
if handedness == 0
    I = find(basic.Handedness >= 0);
else
    I = find(basic.Handedness < 0);
end

basic = basic(I,:);

basic_M = basic(ismember(basic.Gender,1),1:size(basic,2));                                             %contains only male data
basic_F = basic(ismember(basic.Gender,0),1:size(basic,2));                                             %contains only female data

% Load shape left and right files 
shape_L = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Left');
shape_R = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Right');
shape_L = shape_L(I,:);
shape_R = shape_R(I,:);

basic_L = basic(ismember(basic.Subject,shape_L.Files),1:size(basic,2));                            %contains only left data
basic_R = basic(ismember(basic.Subject,shape_R.Files),1:size(basic,2));                            %contains only left data

%% Use regress to eliminate age, gender, handedness, and intracranial volume effects on values in data_shape.xls 
 y_all = {shape_L;shape_R};
 
 for i = 1:length(y_all)
     for j = 2:size(y_all{i},2)
         y = y_all{i}{:,j};
         x1 = basic.FS_IntraCranial_Vol;
         X = [ones(size(x1)) x1];
         [b{i}{j-1},~,~,~,~] = regress(y,X); 
         yNew = y-b{i}{j-1}(2)*x1;    %eliminate effects from y by y'=y-b*x
         
         % Check if the age effect is eliminate using regress with y=y'. The results should now b=0
         [bNew{i}{j-1},~,~,~,~] = regress(yNew,X); 
         y_all{i}{:,j} = yNew; 
     end
 end  
 
% update variables 
% shape_L = y_all{1};
% shape_R = y_all{2};
% 

shape_LM = shape_L(ismember(shape_L.Files,basic_M.Subject),:);
shape_LF = shape_L(ismember(shape_L.Files,basic_F.Subject),:);
shape_RM = shape_R(ismember(shape_R.Files,basic_M.Subject),:);
shape_RF = shape_R(ismember(shape_R.Files,basic_F.Subject),:);


%% raincloud  
close all

% Remove outliers from data 
shape_LF = rmoutliers(shape_LF,'median');
shape_LM = rmoutliers(shape_LM,'median');
shape_RF = rmoutliers(shape_RF,'median');
shape_RM = rmoutliers(shape_RM,'median');

ff = figure('units','normalized','outerposition',[0 0 1 1]);
hold on;

for i = 2:size(shape_LF,2)
    left = [1 2 3 7 8 9 13 14 15 19 20 21 25 26 27 31 32 33];
    spL = subplot(6,6,left(i-1));
    %spL.Position = spL.Position + [-0.1 0 0 0];         % position: [x y width height]
    [h1,h2] = func_plot_shape(shape_L,i,shape_LF(:,i),shape_LM(:,i));
    x = xlim;
    xlim([0 x(2)]);
    % Title 
    if i == 3
        txt = {'Left'};
        text(0.5,2,txt,'Units','normalized','HorizontalAlignment','center','VerticalAlignment','top','FontSize',15);
    end
    
    % Legend (bottom)
    if i == size(shape_LF,2)
        l = legend([h1{1},h2{1}],{'Female','Male'},'box','off','Position',[0.51 0.01 0.01 0.1026],'LineWidth',0.01,'FontSize',10,'NumColumns',2,'Orientation','horizontal');
    end
    
    right = [4 5 6 10 11 12 16 17 18 22 23 24 28 29 30 34 35 36];
    spR = subplot(6,6,right(i-1));
    %spR.Position = spR.Position + [0.0001 0 0 0];
    func_plot_shape(shape_R,i,shape_RF(:,i),shape_RM(:,i));
    x = xlim;
    xlim([0 x(2)]);
    % Title 
    if i == 3
        txt = {'Right'};
        text(0.5,2,txt,'Units','normalized','HorizontalAlignment','center','VerticalAlignment','top','FontSize',15);
    end
    
    % Legend (right side)
%     if i == 10
%         legend([h1{1},h2{1}],{'Female','Male'},'box','off','Position',[0.95 0.44 0.01 0.1026],'LineWidth',0.01,'FontSize',10);
%     end
    
end

%% Save figure  
set(gcf, 'PaperSize', [15 15]);
set(gcf, 'PaperPosition', [0 0 15 15]);
if handedness == 0
print(gcf,'-dtiff','-r300','fig1.tif'); 
else
print(gcf,'-dtiff','-r300','fig2.tif'); 
end

end
