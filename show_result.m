%% FDR plots 
% For each of the rows in the low_fdr_all_gender, plot a scatter plot using the age-sex-adjusted values to a subfolder.

% Last updated: 6/16/2020
% By: Zulfar Ghulam-Jelani 

%% Clear and add path 
clear; clc; close all;
addpath(pwd)

%% Load Variables 

% Load Low FDR file
low_p = readtable('Low_P_value.xlsx','ReadVariableNames',true,'PreserveVariableNames',true);     

% Load basic file
basic = readtable('demo_basic.xlsx','ReadVariableNames',true,'PreserveVariableNames',true);            %contains gender information

% Load diffusion left and right files 
diffusion_L = readtable('data_diffusion.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Left');
basic_L = basic(ismember(basic.Subject,diffusion_L.Files),1:size(basic,2));   
diffusion_R = readtable('data_diffusion.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Right');
basic_R = basic(ismember(basic.Subject,diffusion_R.Files),1:size(basic,2)); 

% Load shape left and right files 
shape_L = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Left');
shape_R = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Right');

% Load demo_categorized file
sheets = sheetnames('demo_categorized.xlsx');
for i = 1:length(sheets)
    demographic{i} = readtable('demo_categorized.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet',sheets(i));
end

for i = 2:length(sheets)
    for j = 2:size(demographic{i},2)
        y = demographic{i}{:,j};
        x1 = basic.Age_in_Yrs;
        x2 = basic.Gender;
        x3 = basic.FS_IntraCranial_Vol;
        X = [ones(size(x1)) x1 x2 x3];
        [b{i}{j-1},~,~,~,~] = regress(y,X); 
        yNew = y-b{i}{j-1}(2)*x1-b{i}{j-1}(3)*x2-b{i}{j-1}(4)*x3;                         
        
        % Check if the age, sex, and handedness effect is eliminate using regress with y=y'. The results should now b=0
        [bNew{i}{j-1},~,~,~,~] = regress(yNew,X); 
        demographic{i}{:,j} = yNew; 
    end
end    

% %% Use regress to eliminate age, sex, handedness, and FS_IntraCranial_Vol effects on values in data_shape.xls and data_diffusion.xls
y_all = {shape_L;shape_R};

for i = 1:length(y_all)
    for j = 2:size(y_all{i},2)
        y = y_all{i}{:,j};
        x1 = basic.FS_IntraCranial_Vol;
        X = [ones(size(x1)) x1];
        [b{i}{j-1},~,~,~,~] = regress(y,X); 
        yNew = y-b{i}{j-1}(2)*x1;                          %eliminate age effect from y by y'=y-b*x
        
        % Check if the age, sex, and handedness effect is eliminate using regress with y=y'. The results should now b=0
        [bNew{i}{j-1},~,~,~,~] = regress(yNew,X); 
        y_all{i}{:,j} = yNew; 
    end
end  

% update variables 
shape_L = y_all{1};
shape_R = y_all{2};
% diffusion_L = y_all{3};
% diffusion_R = y_all{4};

%% Scatter Plot
sheets = low_p.Demographic_category;    % asr, dsm, cognition, emotion, personality
ycol   = low_p.Demographic_name;        % columns of demographics
file   = low_p.Variable_category;
xcol   = low_p.Variable_name;           % columns of diffusion/shape 
LR     = low_p.Laterality;              % left or right 
cc     = low_p.Correlation_coefficient;

close all
ff = figure;
set(gcf, 'PaperSize', [13 2]);
set(gcf, 'PaperPosition', [0 0 13 2]);    
f_dif_count = 1;
f_shape_count = 1;
for i = 1:size(low_p,1)
    left_right_text = [LR{i} ' AF'];
    % Choose correct x 
    if isequal(file{i},'data_shape.xls')
        subplot(1,5,f_shape_count);
        f_shape_count = f_shape_count + 1;
        if isequal(LR{i},'Left')
            x = shape_L.(xcol{i});
        else
            x = shape_R.(xcol{i});
        end
    else
        subplot(1,5,f_dif_count+8);
        f_dif_count = f_dif_count + 1;
        if isequal(LR{i},'Left')
            x = diffusion_L.(xcol{i});
        else
            x = diffusion_R.(xcol{i});
        end
    end
     
    % Choose correct y 
    if isequal(sheets{i},'ASR') 
        y = demographic{1}.(ycol{i}); 
    elseif isequal(sheets{i},'DSM')
        y = demographic{2}.(ycol{i}); 
    elseif isequal(sheets{i},'Cognition')
        y = demographic{3}.(ycol{i}); 
    end
        
    % When correlation calculated using 'Spearman' ('rank'-based correlation) convert x and y to their ranks 
    %[~,~,x] = unique(x);
    %[~,~,y] = unique(y);
    [y,yf] = rmoutliers(y);
    x(yf) = [];
    [x,xf] = rmoutliers(x);
    y(xf) = [];

    % Plot 
    scatter_with_trend(y,x);
    xlim([min(y) max(y)]);
    box on
    title(' ');
    legend off
    yl = ylim;
    if yl(1) < 0
        ylim([0 yl(2)]);
    end
    xlabel((ycol{i}))
    ylabel({left_right_text,xcol{i}})
    j = j+1;
end
print(gcf,'-dtiff','-r300','fig3.tif'); 
close all;