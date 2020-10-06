%% correlation_analysis.m
% 1. include both male and female together (current code separate male and female, but here we will not separate them) 
% 2. use regress to eliminate age, sex, and handedness effect on demographics (the current code only eliminates age effect. Here we will eliminate age effect and then eliminate sex effect).
% 3. use regress to eliminate age, sex, and handedness effect on values in data_shape.xls and data_diffusion.xls
% 4. calculate the p-value, correlation, and fdr, as what we have done in code.m

% Last updated: 6/8/2020
% By: Zulfar Ghulam-Jelani 

%% Clear and add path 
clear; clc; close all;
addpath(pwd)

%% Load Variables 

% Load basic file
basic = readtable('demo_basic.xlsx','ReadVariableNames',true,'PreserveVariableNames',true);            %contains gender information

% Load diffusion left and right files 
diffusion_L = readtable('data_diffusion.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Left');  
diffusion_R = readtable('data_diffusion.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Right');

% Load shape left and right files 
shape_L = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Left');
shape_R = readtable('data_shape.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet','Right');

% Load demo_categorized file
sheets = sheetnames('demo_categorized.xlsx');
for i = 1:length(sheets)
    demographic{i} = readtable('demo_categorized.xlsx','ReadVariableNames',true,'PreserveVariableNames',true,'Sheet',sheets(i));
end

%% Use regress to eliminate age, sex, and handedness effect on demographics 
%     (a) run regress with y=demographics and x=age, sex, and handedness (This step can be done in one regress) 
%     (b) eliminate age, sex, and handedness effect from y by y'=y-b*x
%     (c) please check if the age, sex, and handedness effect is eliminate using regress with y=y'. The results should now be b=0

%[b,bint,r,rint,stats] = regress(y,X);  
    %b=coeff estimates
    %bint=95% confidence intervals for the coefficient estimates
    %r=residuals
    %rint=intervals that can be used to diagnose outliers 
    %stats=R2 statistic, the F-statistic and its p-value, and an estimate of the error variance
    
for i = 1:length(sheets)
    for j = 2:size(demographic{i},2)
        y = demographic{i}{:,j};
        [~,y_out] = rmoutliers(y);
        x1 = basic.Age_in_Yrs;
        x1 = x1 - median(x1);
        x2 = basic.Gender;
        x2 = x2 - median(x2);
        x3 = basic.FS_IntraCranial_Vol; % intracranial volume
        x3 = x3 - median(x3);
        X = [ones(size(x1)) x1 x2 x3];
        [b{i}{j-1},~,~,~,~] = regress(y(~y_out),X(~y_out,:)); 
        yNew = y-b{i}{j-1}(2)*x1-b{i}{j-1}(3)*x2-b{i}{j-1}(4)*x3;                         
        
        % Check if the age, sex, and handedness effect is eliminate using regress with y=y'. The results should now b=0
        [bNew{i}{j-1},~,~,~,~] = regress(yNew,X); 
        demographic{i}{:,j} = yNew; 
    end
end    

%% Use regress to eliminate age, sex, and handedness effect on values in data_shape.xls and data_diffusion.xls
%     (a) run regress with y=shape and diffusion and x=age, sex, and handedness (This step can be done in one regress) 
%     (b) eliminate age, sex, and handedness effect from y by y'=y-b*x
%     (c) please check if the age, sex, and handedness effect is eliminate using regress with y=y'. The results should now be b=0

%[b,bint,r,rint,stats] = regress(y,X);  
    %b=coeff estimates
    %bint=95% confidence intervals for the coefficient estimates
    %r=residuals
    %rint=intervals that can be used to diagnose outliers 
    %stats=R2 statistic, the F-statistic and its p-value, and an estimate of the error variance
clear i j y x1 x2 X b yNew bNew y_all 
y_all = {shape_L;shape_R}; % macroscopic metrics

for i = 1:length(y_all)
    for j = 2:size(y_all{i},2)
        y = y_all{i}{:,j};
        [~,y_out] = rmoutliers(y);
        x1 = basic.FS_IntraCranial_Vol;
        x1 = x1-median(x1);
        X = [ones(size(x1)) x1];
        [b{i}{j-1},~,~,~,~] = regress(y(~y_out),X(~y_out,:)); 
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

%% p-values and correlation 
y_all = {shape_L;shape_R;diffusion_L;diffusion_R};
% Directory 
dir1 = [pwd '\p_values'];
dir2 = [pwd '\corr_coeff'];
dir3 = [pwd '\f_p_values']; % familywise p-value

yexl1 = {'p_shape_left.xlsx','p_shape_right.xlsx','p_diffusion_left.xlsx','p_diffusion_right.xlsx'};
yexl2 = {'c_shape_left.xlsx','c_shape_right.xlsx','c_diffusion_left.xlsx','c_diffusion_right.xlsx'};

for i = 1:length(y_all)
    for j = 1:length(demographic)  
        clear stats statsf rho zscore
        demo = demographic{j}(ismember(demographic{j}.Subject,y_all{i}.Files),:);
        x = [demo{:,2:end}];  %matrix
        yval = y_all{i}(ismember(y_all{i}.Files,demographic{j}.Subject),:);
        
        for k = 2:size(yval,2)
            y = yval{:,k};                                             %vector
            for t = 1:size(x,2)
                % remove outliers
                xx = x(:,t);
                yy = y;
                [xx,xxf] = rmoutliers(xx);
                yy(xxf) = [];
                [yy,yyf] = rmoutliers(yy);
                xx(yyf) = [];
               
                [rho(k-1,t),stats(k-1,t)] = corr(yy,xx,'rows','complete','Type','Spearman'); 
                zscore(k-1,t) = 0.5*log((1+rho(k-1,t))./(1-rho(k-1,t)));
                A = stats(k-1,t).*(size(demo,2)-1); % familywise p-value correction using number of demographics
                A(A>1) = 1;
                statsf(k-1,t) = A;
            end
        end
        
        col = demo.Properties.VariableNames(2:end);
        row = yval.Properties.VariableNames(2:end);

        stats = cell2table(num2cell(stats),'VariableNames',col,'RowNames',row);
        file1 = [dir1 filesep yexl1{i}];
        writetable(stats,file1,'Sheet',sheets{j},'WriteRowNames',true)

        rho = cell2table(num2cell(rho),'VariableNames',col,'RowNames',row);
        file2 = [dir2 filesep yexl2{i}];          
        writetable(rho,file2,'Sheet',sheets{j},'WriteRowNames',true)    
        
        zscore = cell2table(num2cell(zscore),'VariableNames',col,'RowNames',row);
        file2 = [dir2 filesep 'z' yexl2{i}];          
        writetable(zscore,file2,'Sheet',sheets{j},'WriteRowNames',true)    
        
        statsf = cell2table(num2cell(statsf),'VariableNames',col,'RowNames',row);
        file3 = [dir3 filesep yexl1{i}];
        writetable(statsf,file3,'Sheet',sheets{j},'WriteRowNames',true)
    end
end

%% FDR values 
clearvars -except diffusion_L diffusion_R shape_L shape_R sheets demographic

addpath([pwd,'\f_p_values'])
info = dir('f_p_values');

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

% Save files 
% dir = [pwd '\fdr_values'];
% yexl = {'fdr_diffusion_left.xlsx','fdr_diffusion_right.xlsx','fdr_shape_left.xlsx','fdr_shape_right.xlsx'};   
% yval = {diffusion_L;diffusion_R;shape_L;shape_R};
% 
% for i = 1:length(pfdr)
%     for j = 1:length(sheets)
%         clear col2 row2 fdr file 
%         col2 = demographic{j}.Properties.VariableNames;
%         col2 = col2(2:end);
%         row2 = yval{i}.Properties.VariableNames(2:end);
%         fdr = cell2table(num2cell(pfdr{i}{j}),'VariableNames',col2,'RowNames',row2);
%         file = [dir filesep yexl{i}];
%         writetable(fdr,file,'Sheet',sheets{j},'WriteRowNames',true)
%     end
% end

%% Find which field in the fdr files has FDR < 0.05 and output all result into one excel file with the following information
% 1st column is either left or right
% 2nd column is the demographic category (e.g. social)
% 3rd column is the demographic name
% 4th column is the variable category (e.g. anisotropy)
% 5th column is the variable name (e.g. dti_fa)
% 6th column is the FDR value
% 7th column is the correlation coefficient of the regression

clearvars -except diffusion_L diffusion_R shape_L shape_R sheets demographic pvals 
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

% find familywise p-value < 0.05
LoR = {'Left','Right','Left','Right'};
VC = {'data_diffusion.xls','data_diffusion.xls','data_shape.xls','data_shape.xls'};
count = 1;
for i = 1:length(pvals)                                                    %Number of excel files 
    for j = 1:length(pvals{i})                                             %Number of sheets in file 
        [r,c] = find(cell2mat(pvals{i}{j}) <= 0.05);
        if isempty(r)
            continue;
        end
        for k = 1:length(r)                                                 %Number of found values 
            pvals_stats(count,1) = {sheets(j)}; 
            col = demographic{j}.Properties.VariableNames; col = col(2:end);
            pvals_stats(count,2) =  col(c(k));
            pvals_stats(count,3) = VC(i);
            pvals_stats(count,4) = LoR(i);
            pvals_stats(count,5) = table2cell(c1{1,i}(r(k),1));
            pvals_stats(count,6) = num2cell(pvals{i}{j}(r(k),c(k)));
            pvals_stats(count,7) = cvals{i}{j}(r(k),c(k)); 
            count = count+1; 
        end  
    end 
end

col = {'Demographic_category','Demographic_name','Variable_category','Laterality','Variable_name','p-value','Correlation_coefficient'};
fileName = {'Low_P_value.xlsx'};
dir = pwd; 
pvals_stats = cell2table(pvals_stats,'VariableNames',col);
file = [dir filesep fileName{1}];
writetable(pvals_stats,file,'WriteRowNames',false)

