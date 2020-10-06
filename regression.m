%% 
% For the next task, only use data from '2020_04_27_data_curation2_(frank)'
% The data are categorized into data_anisotropy, data_shape, and data_diffusion. Each of them has left and right.
% The demographics are categorized inside the file 'demo_categorized.xlsx', which has 9 sheets (e.g., social, health, ...etc.)

% The next task is the following: (please create a new folder named FDR_categorized to store them)
% (1) remove age effect of the demographics. The age and sex are recorded in 'demo_basic.xlsx'
% (2) run regression analysis to get p-values and stores p values in the following files:
%     p_shape_left_male.xlsx
%     p_shape_left_female.xlsx
%     p_diffusion_left_male.xlsx
%     p_diffusion_left_female.xlsx
%     p_shape_right_male.xlsx
%     p_shape_right_female.xlsx
%     p_diffusion_right_male.xlsx
%     p_diffusion_right_female.xlsx
% 
% In each xlsx file, there should be 9 sheets arranged just like the arrangement of the demo_categorized.xlsx
% 
% (3) Apply mafdr for each sheet of each xlsx and generate 12 fdr_* files

% Last edited: 06/06/2020
% By: Zulfar Ghulam-Jelani

%% Clear and add path 
clear; clc; close all;
addpath(pwd)

%% Load variables and separate by male and female subjects 

% Load basic file
basic = readtable('demo_basic.xlsx','ReadVariableNames',true,'PreserveVariableNames',true);            %contains gender information
basic_M = basic(ismember(basic.Gender,1),1:size(basic,2));                                             %contains only male data
basic_F = basic(ismember(basic.Gender,0),1:size(basic,2));                                             %contains only female data

% Load diffusion left and right file separated by gender 
diffusion_L = readtable('data_diffusion.xls','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Left');
basic_L = basic(ismember(basic.Subject,diffusion_L.name),1:size(basic,2));                            %contains only left data
diffusion_LM = diffusion_L(ismember(basic_L.Gender,1),1:size(diffusion_L,2));                          %contains only male data
diffusion_LF = diffusion_L(ismember(basic_L.Gender,0),1:size(diffusion_L,2));                          %contains only female data

diffusion_R = readtable('data_diffusion.xls','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Right');
basic_R = basic(ismember(basic.Subject,diffusion_R.name),1:size(basic,2)); 
diffusion_RM = diffusion_R(ismember(basic_R.Gender,1),1:size(diffusion_R,2));                          %contains only male data
diffusion_RF = diffusion_R(ismember(basic_R.Gender,0),1:size(diffusion_R,2));                          %contains only female data

% Load shape left and right file 
shape_L = readtable('data_shape.xls','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Left');
shape_LM = shape_L(ismember(basic_L.Gender,1),1:size(shape_L,2));                                      %contains only male data
shape_LF = shape_L(ismember(basic_L.Gender,0),1:size(shape_L,2));                                      %contains only female data

shape_R = readtable('data_shape.xls','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Right');
shape_RM = shape_R(ismember(basic_R.Gender,1),1:size(shape_R,2));                                      %contains only male data
shape_RF = shape_R(ismember(basic_R.Gender,0),1:size(shape_R,2));                                      %contains only female data

% Load demo_categorized file
sheets = sheetnames('demo_categorized.xlsx');
for i = 1:length(sheets)
    demographic{i} = readtable('demo_categorized.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet',sheets(i));
    demographic_M{i} = demographic{i}(ismember(basic.Gender,1),1:size(demographic{i},2));                  %contains only male data
    demographic_F{i} = demographic{i}(ismember(basic.Gender,0),1:size(demographic{i},2));                  %contains only female data
end

%% Remove age effect of the demographics. The age and sex are recorded in 'demo_basic.xlsx'
%     (a) run regress with y=demographics and x=age
%     (b) eliminate age effect from y by y'=y-b*x
%     (c) please check if the age effect is eliminate using regress with y=y'. The results should now be b=0

%[b,bint,r,rint,stats] = regress(y,X);  
    %b=coeff estimates
    %bint=95% confidence intervals for the coefficient estimates
    %r=residuals
    %rint=intervals that can be used to diagnose outliers 
    %stats=R2 statistic, the F-statistic and its p-value, and an estimate of the error variance
        
% Male Regression
demo_MF = {demographic_M;demographic_F};
demo_age = {basic_M;basic_F};
for mf = 1:2
    for i = 1:size(sheets)
        for j = 2:size(demo_MF{mf}{i},2)
            y = demo_MF{mf}{i}{:,j};
            x = demo_age{mf}.Age_in_Yrs;
            X = [ones(size(x)) x];
            [b{i}{j},~,~,~,~] = regress(y,X); 
            yNew = y-b{i}{j}(2)*x;                                        %eliminate age effect from y by y'=y-b*x
            % Check if the age effect is eliminate using regress with y=y'. The results should now b=0
            %[bNew{i}{j},~,~,~,~] = regress(yNew,X); 
            demo_MF{mf}{i}{:,j} = yNew; 
        end
    end
end

%% Run regression analysis to get p-values
 
% Directory 
dir = [pwd '\p_values'];
dir2 = [pwd '\corr_coeff'];

% Regression
clear yval yexl 
yval = {shape_LM;diffusion_LM;shape_RM;diffusion_RM;shape_LF;diffusion_LF;shape_RF;diffusion_RF};
y2x = [1 1 1 1 2 2 2 2];
yexl = {'p_shape_left_male.xlsx','p_diffusion_left_male.xlsx','p_shape_right_male.xlsx','p_diffusion_right_male.xlsx',...
        'p_shape_left_female.xlsx','p_diffusion_left_female.xlsx','p_shape_right_female.xlsx','p_diffusion_right_female.xlsx'};

yexl2 = {'c_shape_left_male.xlsx','c_diffusion_left_male.xlsx','c_shape_right_male.xlsx','c_diffusion_right_male.xlsx',...
        'c_shape_left_female.xlsx','c_diffusion_left_female.xlsx','c_shape_right_female.xlsx','c_diffusion_right_female.xlsx'};

pvalNaN = 0;

for i = 1:length(yval)
    for j = 1:length(sheets)  
        clear stats rho
        demo_new = demo_MF{y2x(i)}{j}(ismember(demo_MF{y2x(i)}{j}.Subject,yval{i}.name),:);
        x = [demo_new{:,2:end}];  %matrix
        yval_new = yval{i}(ismember(yval{i}.name,demo_MF{y2x(i)}{j}.Subject),:);
        
        for k = 2:size(yval_new,2)
            y = yval_new{:,k};                                     %vector
            for t = 1:size(x,2)
                [rho(k-1,t),stats(k-1,t)] = corr(y,x(:,t),'rows','complete','Type','Spearman'); 
                
                % Check whether p-value has NaN. If there is a NaN in p-value, then it means the data have a problem. 
                % We should stop the analysis and prompt an error message (All field should have p-value).
                if isnan(stats(k-1,t))
                    fprintf("\np-value has NaN value. Check the data\n")
                    exit();
                end
            end
        end
        
        col = demo_new.Properties.VariableNames;
        col = col(2:end);
        row = yval{i}.Properties.VariableNames(2:end);

        stats = cell2table(num2cell(stats),'VariableNames',col,'RowNames',row);
        file = [dir filesep yexl{i}];
        writetable(stats,file,'Sheet',sheets{j},'WriteRowNames',true)

        rho = cell2table(num2cell(rho),'VariableNames',col,'RowNames',row);
        file2 = [dir2 filesep yexl2{i}];          
        writetable(rho,file2,'Sheet',sheets{j},'WriteRowNames',true)      
    end
end

%% Apply mafdr for each sheet of each xlsx and generate fdr_* files
clearvars -except diffusion_LF diffusion_LM diffusion_RF diffusion_RM shape_LF shape_LM shape_RF shape_RM sheets demographic pvalNaN pfdr 

addpath([pwd,'\p_values'])
info = dir('p_values');

for i = 1:length(info)
    myFiles{i} = info(i).name;
end

myFiles = myFiles(startsWith(myFiles,'p'));

for i = 1:length(myFiles)
    file = myFiles{i};

    for j = 1:length(sheets)
        p{i} = table2cell(readtable(file,'Sheet',sheets(j))); 
        p{i} = p{i}(:,2:end);
        pvals{i}{1,j} = p{i};
    end

    for t = 1:length(sheets)
        pvec = cell2mat(pvals{i}{1,t});
        pfdr{i}{1,t} = reshape(mafdr(reshape(pvec,1,[]),'BHFDR',true),size(pvec));  

        if isnan(pfdr{i}{1,t}) == 1
            fprintf("\nFDR has NaN value. Check the data\n")
            exit();  
        end
    end
end

%% Save files 
dir = [pwd '\fdr_values'];
yexl = {'fdr_diffusion_left_female.xlsx','fdr_diffusion_left_male.xlsx',...
        'fdr_diffusion_right_female.xlsx','fdr_diffusion_right_male.xlsx',...
        'fdr_shape_left_female.xlsx','fdr_shape_left_male.xlsx',...
        'fdr_shape_right_female.xlsx','fdr_shape_right_male.xlsx'};   
yval = {diffusion_LF;diffusion_LM;diffusion_RF;diffusion_RM;shape_LF;shape_LM;shape_RF;shape_RM};

for i = 1:length(pfdr)
    for j = 1:length(sheets)
        clear col2 row2 fdr file 
        col2 = demographic{j}.Properties.VariableNames;
        col2 = col2(2:end);
        row2 = yval{i}.Properties.VariableNames(2:end);
        fdr = cell2table(num2cell(pfdr{i}{j}),'VariableNames',col2,'RowNames',row2);
        file = [dir filesep yexl{i}];
        writetable(fdr,file,'Sheet',sheets{j},'WriteRowNames',true)
    end
end

%% Find which field in the fdr files has FDR < 0.05 and output all result into one excel file with the following information
% 1st column is either left or right
% 2nd column is either male or female
% 3rd column is the demographic category (e.g. social)
% 4th column is the demographic name
% 5th column is the variable category (e.g. anisotropy)
% 6th column is the variable name (e.g. dti_fa)
% 7th column is the FDR value
% 8th column is the correlation coefficient of the regression

clearvars -except diffusion_LF diffusion_LM diffusion_RF diffusion_RM shape_LF shape_LM shape_RF shape_RM sheets demographic pfdr pfdr_cNaN pvalNaN
addpath([pwd,'\corr_coeff'])
info = dir('corr_coeff');

for i = 1:length(info)
    myFiles{i} = info(i).name;
end

myFiles = myFiles(startsWith(myFiles,'c'));

for i = 1:length(myFiles)
    file = myFiles{i};
    for j = 1:length(sheets)
        c1{i} = readtable(file,'Sheet',sheets(j)); 
        c{i} = table2cell(c1{i});
        c{i} = c{i}(:,2:end);
        cvals{i}{1,j} = c{i};
    end
end

LoR = {'Left','Left','Right','Right','Left','Left','Right','Right'};
VC = {'Diffusion','Diffusion','Diffusion','Diffusion','Shape','Shape','Shape','Shape'};
count = 1; 
for i = 1:length(pfdr)                                                    %Number of excel files 
    for j = 1:length(pfdr{i})                                             %Number of sheets in file 
            [r c] = find(pfdr{i}{j} <= 0.05);
            if isempty(r)
                
            else
                for k = 1:length(r)                                                 %Number of found values 
                    pfdr_stats(count,1) = LoR(i);

                    if mod(i,2) == 0                                                %Even
                        pfdr_stats(count,2) = {'Male'};
                    elseif mod(i,2) == 1
                        pfdr_stats(count,2) = {'Female'};                           %Odd 
                    end

                    pfdr_stats(count,3) = {sheets(j)}; 
                    col = demographic{j}.Properties.VariableNames; col = col(2:end);
                    pfdr_stats(count,4)=  col(c(k));
                    pfdr_stats(count,5) = VC(i); 
                    pfdr_stats(count,6) = table2cell(c1{1,i}(r(k),1));
                    pfdr_stats(count,7) = num2cell(pfdr{i}{j}(r(k),c(k)));
                    pfdr_stats(count,8) = cvals{i}{j}(r(k),c(k)); 
                    count = count+1; 
                end  
            end
    end 
end

if exist('pfdr_stats','var') == 1 
    col = {'Laterality','Gender','Demographic category','Demographic name','Variable category','Variable name','FDR value','Correlation coefficient'};
    fileName = {'Low_FDR.xlsx'};
    dir = pwd; 
    pfdr_stats = cell2table(pfdr_stats,'VariableNames',col);
    file = [dir filesep fileName{1}];
    writetable(pfdr_stats,file,'WriteRowNames',false)
end

