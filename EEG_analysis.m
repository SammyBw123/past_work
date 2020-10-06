clear; clc; close all;
addpath D:\fieldtrip-20190217
ft_defaults

%% Load 
cfg                     = [];
cfg.dataset             = 'D:\data\RawEEG\Spire02_R_BL2.eeg';
cfg.trialdef.eventtype  = 'Stimulus'; 
%cfg.trialdef.eventvalue = {'S  32'};
cfg.trialdef.eventvalue = {'S  31','S  32'};  % movement onset: left home target; S  31: north target; S  32: south target
cfg.trialdef.prestim    = 3;                   % in seconds
cfg.trialdef.poststim   = 3;                   % in seconds
cfg.trialfun            = 'ft_trialfun_general';

%All channels, Spire02, Spire04, Spire05, Spire_11, Spire14, Spire_17, Spire19, Spire23, Spire24
%cfg.channel = {'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire01_L_BL1
%cfg.channel  = {'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire02_L_BL1
%cfg.channel = {'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire02_R_BL1
%cfg.channel = {'Fp1' 'Fp2' 'F7' 'F3' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire03_L_BL1
%cfg.channel = {'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire04_L_BL1
%cfg.channel = {'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O2' 'FCz' 'AF7' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P6' 'PO7' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire05_L_BL1
%cfg.channel = {'F8' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'F6' 'FT9' 'FT7' 'FC4' 'FT8' 'FT10' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire06_L_BL1
%cfg.channel = {'F3' 'Fz' 'F4' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F1' 'F2' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire07_L_BL1
%cfg.channel = {'Fp1' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF3' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire08_L_BL1
%cfg.channel = {'Fp1' 'Fp2' 'F3' 'Fz' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF3' 'AF8' 'F5' 'F1' 'F2' 'FT9' 'FT7' 'FC3' 'FC4' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire09_R_BL1
%cfg.channel = {'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'C3' 'Cz' 'C4' 'T8' 'CP1' 'CP2' 'CP6' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'CP3' 'CPz' 'CP4' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire10_R_BL1
%cfg.channel = {'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'F5' 'F1' 'F2' 'F6' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire11_L_BL1
%cfg.channel = {'Fp2' 'F7' 'F3' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF3' 'AF4' 'F5' 'F1' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'P5' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire13_R_BL1
%cfg.channel = {'Fp1' 'F7' 'F3' 'F4' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'AF3' 'AF4' 'F5' 'F1' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire15_L_BL1
%cfg.channel = {'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire_17_L_BL1
%cfg.channel = {'Fp1'  'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF3' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire_18_L_BL1
%cfg.channel = {'Fp1' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'AF7' 'AF3' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%Channels used for spire01_L_BL1
%cfg.channel  = {'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%Channels used for spire07_L_BL1
%cfg.channel = {'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%Channels used for spire21_L_BL1
%cfg.channel  = {'F3' 'Fz' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F2' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%Channels used for spire26_L_BL1
%cfg.channel = {'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%channels removed from variance plots Spire01_L_BL2
%cfg.channel = {'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'PO7' 'PO3' 'POz' 'PO4' 'PO8'};

%channels removed from variance plots Spire02_R_BL2
%cfg.channel = {'F3' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F5' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire03_L_BL2
%cfg.channel = {'Fp1' 'Fp2' 'F7' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF4' 'AF8' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire04_L_BL2
%cfg.channel = {'Fp1' 'Fp2' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O2' 'FCz' 'AF7' 'AF3' 'AF4' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P2' 'P6' 'PO7' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire05_L_BL2
%cfg.channel = {'F7' 'F3' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'O2' 'FCz' 'AF8' 'F5' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CPz' 'CP4' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire06_L_BL2
%cfg.channel = {'F7' 'F3' 'Fz' 'F4' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F5' 'F1' 'F2' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire07_L_BL2
%cfg.channel = {'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF3' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire08_L_BL2
%cfg.channel = {'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'CP5' 'CP1' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT7' 'FC3' 'FC4' 'FT8' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire_11_L_BL2
%cfg.channel = {'Fp2' 'F7' 'F3' 'Fz' 'F8' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire15_L_BL2
%cfg.channel = {'F8' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire17_L_BL2
%cfg.channel = {'Fp1' 'Fp2' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire18_L_BL2
%cfg.channel = {'Fp1' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'P4' 'P8' 'A1' 'AF7' 'AF3' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire09_R_BL2
%cfg.channel = {'Fp2' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'CP1' 'CP2' 'CP6' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'CP3' 'CPz' 'CP4' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire10_R_BL2
%cfg.channel = {'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'O2' 'FCz' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

%channels removed from variance plots Spire13_R_BL2
%cfg.channel = {'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'C4' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O2' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };

cfg  = ft_definetrial(cfg); 
data = ft_preprocessing(cfg);

%% Visualize the data
cfg.viewmode   = 'vertical';    % butterfly or vertical 
cfg.continuous = 'no';
cfg            = ft_databrowser(cfg,data);

%% Reject artifact
cfg2             = [];
cfg2.metric      = 'var';     % var, min, max, maxabs, range, kurtosis, zvalue  
cfg2.method      = 'summary'; % summary, trial, channel
cfg2.channel     = {'F3' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F5' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };
data2 = ft_rejectvisual(cfg2,data);

%% Visualize data 
cfg2 = [];
cfg2.viewmode   = 'vertical';    % butterfly or vertical 
cfg2.continuous = 'no';
cfg2            = ft_databrowser(cfg2,data2);

%% Preprocess
cfg.preproc.reref       = 'yes';               
cfg.preproc.refchannel  = {'F3' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F5' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };
cfg.refmethod           = 'avg';               % 'avg', 'median', or 'bipolar' for bipolar derivation of sequential channels (default = 'avg')
cfg.preproc.implicitref = 'REF';               % if you have recorded relative to a ref electrode that is not in the data file (which is our case), then we can add this implicit reference channel.
%cfg.demean     = 'yes';                       % whether to apply baseline correction     	  
data3 = ft_preprocessing(cfg,data2);

%% Visualize data 
cfg.viewmode   = 'vertical';    % butterfly or vertical 
cfg.continuous = 'no';
cfg            = ft_databrowser(cfg,data3);

%% Filter
clear data4
cfg.preproc.bpfilter = 'yes';
cfg.preproc.bpfreq   = [1 30]; % Hz  % Removing DC components and drifts 
data4         = ft_preprocessing(cfg,data3);

%% Visualize data 
cfg.viewmode   = 'vertical';    % butterfly or vertical 
cfg.continuous = 'no';
cfg            = ft_databrowser(cfg,data4);

%% Continue to ICA or skip to frequency analysis 

%% ICA
clear comp
cfg2 = [];
cfg2.method       = 'runica';
cfg2.channel      = {'F3' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'F5' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };
cfg2.trials       = 'all';
cfg2.numcomponent = 'all';
cfg2.demean       = 'yes';  % (default = 'yes')
cfg2.updatesens   = 'yes';  % (default = 'yes')
cfg2.feedback     = 'text'; % (default = 'text')
comp = ft_componentanalysis(cfg2, data4);

%% Identify the artifacts
figure
cfg3 = [];
cfg3.component = 1:30;                              %specify the component(s) that should be plotted
cfg3.layout    = 'easycapM1.mat';
cfg3.comment   = 'no';
ft_topoplotIC(cfg3, comp)

%% Identify the artifacts 
cfg4 = [];
cfg4.layout   = 'easycapM1.mat'; % specify the layout file that should be used for plotting
cfg4.viewmode = 'component';
ft_databrowser(cfg4, comp)

%% Remove components
clear data5
cfg5 = [];
cfg5.component = [5,9,11,13,15,21,22,27,28,29,30]; %to be removed component(s)
data5 = ft_rejectcomponent(cfg5, comp, data4);

%% Visualize data 
cfg6.viewmode   = 'vertical';    % butterfly or vertical 
cfg6.continuous = 'no';
cfg7            = ft_databrowser(cfg6,data5);

%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Frequency Analysis %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Power Spectral Density (PSD) with Single Taper for entire time length 
% https://natmeg.se/MEEG_course2018/freqanalysis.html
clear psd_hann
cfg8            = [];
cfg8.channel    = {'Fp2' 'F3' 'Fz' 'F4' 'F8' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'CP1' 'CP2' 'CP6' 'P3' 'Pz' 'P4' 'P8' 'A1' 'O1' 'Oz' 'O2' 'FCz' 'AF7' 'AF3' 'AF4' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'CP3' 'CPz' 'CP4' 'P5' 'P1' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };
cfg8.method     = 'mtmfft';
cfg8.taper      = 'hanning';
cfg8.foilim     = [1,30];
%cfg8.keeptrials = 'yes'; 
psd_hann        = ft_freqanalysis(cfg8,data4);          %data4 without ICA or data5 with ICA 

cfg8            = [];
cfg8.parameter  = 'powspctrm';
cfg8.layout     = 'easycapM1.mat';
cfg8.showlabels = 'yes';
cfg8.xlim       = [1 30];         %frequency to plot 

figure;
ft_multiplotER(cfg8,psd_hann);

%% Time Frequency Response (TFR) with Single Taper 
%load D:\data\Processed\Waldert20\boxPlot\matlab.mat
clear tfr_hann 
cfg9           = [];
cfg9.output    = 'pow';
cfg9.channel   = {'Fp1' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'P4' 'P8' 'A1' 'AF7' 'AF3' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };
cfg9.method    = 'mtmconvol';
cfg9.taper     = 'hanning';
cfg9.foi       = 1:1:30;                          %frequencies to estimate 
cfg9.t_ftimwin = ones(length(cfg9.foi),1).*0.5;   %length of time window = 0.5 secs
cfg9.toi       = -2:0.1:2;                        %timepoints to center on (length of time window = 0.5 secs)
cfg9.pad       = 'nextpow2';                      %default slow considered for efficiency 
%cfg9.keeptrials = 'yes';                          %comment out if doing the average 

tfr_hann       = ft_freqanalysis(cfg9,data5);     %data4 without ICA or data5 with ICA 

%%
cfg10              = [];
cfg10.baseline     = [-2 2];         %[time time] normalizing to rest trial or entire trial
cfg10.baselinetype = 'zscore';
cfg10.trials       = 'all';         %specify trial or 'all'/comment out for average
cfg10.zlim         = [-3 3];
cfg10.showlabels   = 'yes';
cfg10.layout       = 'easycapM1.mat';
cfg10.channel      = {'Fp1' 'F7' 'F3' 'Fz' 'F4' 'F8' 'FC5' 'FC1' 'FC2' 'FC6' 'T7' 'C3' 'Cz' 'C4' 'T8' 'TP9' 'CP5' 'CP1' 'CP2' 'CP6' 'TP10' 'P7' 'P3' 'P4' 'P8' 'A1' 'AF7' 'AF3' 'AF8' 'F5' 'F1' 'F2' 'F6' 'FT9' 'FT7' 'FC3' 'FC4' 'FT8' 'FT10' 'C5' 'C1' 'C2' 'C6' 'TP7' 'CP3' 'CPz' 'CP4' 'TP8' 'P5' 'P2' 'P6' 'PO7' 'PO3' 'POz' 'PO4' 'PO8' };
cfg10.colorbar     = 'yes';
cfg10.showscale    = 'yes';
mapp = [5,48,97;33,102,172;67,147,195;146,197,222;209,229,240;247,247,247;253,219,199;244,165,130;214,96,77;178,24,43;103,0,31]./256;
cfg10.colormap = colormap(mapp);

ft_multiplotTFR2(cfg10,tfr_hann);     %powspctrm: trials, channels, freq, time (trials included if keeptrials = 'yes'

%% LDA
clear chan ind ch fr mov1 mov2 rest sample1 sample2 sample3 s1 s2 label indices1 indices2 test1 test2 train1 train2 class1 class2 err1 err2

%tfr_hann.powspctrm (trial,channel,frequency,time) 
chan = {'FC2','FC6','C4','FC4','C2','C6'};
ch   = zeros(length(chan),1);

for i = 1:length(chan)
    ind = find(strcmp(tfr_hann.label,chan{i}));
    ch(i) = ind;
end

%fr   = 1:3:15;              %Frequency 1-15 Hz with 3 Hz bins 
fr = 5:1:10;
mov1 = 31:36;               %Move 1:1.5 seconds (time window 500ms)   
mov2 = 36:41;               %Move 1.5:2 seconds (time window 500ms)
rest = 1:6;                 %Rest -2:-1.5 seconds (time window 500ms)
%mov1 = 26:31;               %Move 0.5:1 seconds (time window 500ms) 

%Features 
sample1 = mean(tfr_hann.powspctrm(:,ch,fr,mov1),4);     %1:1.5 seconds movement
sample2 = mean(tfr_hann.powspctrm(:,ch,fr,mov2),4);     %1.5:2 seconds movement
sample3 = mean(tfr_hann.powspctrm(:,ch,fr,rest),4);     %-2:-1.5 seconds rest 

s1 = [sample1;sample3]; 
[l,w,h] = size(sample1);
s1=reshape(s1,l*2,w*h);       %all features independent 

s2 = [sample2;sample3]; 
s2=reshape(s2,l*2,w*h);       %all features independent 

label  = [ones(l,1);zeros(l,1)];    %ones:move zeros:rest 

indices1 = crossvalind('Kfold',s1(:,1),10);      %10-fold cross validation indices 
indices2 = crossvalind('Kfold',s2(:,1),10);

for i = 1:10
    test1 = (indices1 == i); 
    test2 = (indices2 == i);
    train1 = ~test1;
    train2 = ~test2;
    
    [class1,err1] = classify(s1(test1),s1(train1),label(train1),'Linear');
    [class2,err2] = classify(s2(test2),s2(train2),label(train2),'Linear');

end

fprintf('Error 1: %f\n',err1)
fprintf('Error 2: %f\n',err2)

%% LDA 2: best accuracy results     
clear chan ch ind fr move rest sampleM sampleR s label cvp cva lda cvlda ldaCVErr

%tfr_hann.powspctrm (trial,channel,frequency,time) 
%chan = {'FC2','FC6','C4','FC4','C2','C6'};          % Left arm movement 
chan = {'FC1','FC3','FC5','C5','C3','C1'};         % Right arm movement

ch   = zeros(length(chan),1);
for i = 1:length(chan)
    ind = find(strcmp(tfr_hann.label,chan{i}));
    ch(i) = ind;
end

fr   = 1:3:15;              %Frequency 1-15 Hz with 3 Hz bins   

%move = 11:21;               %-1 to 0 seconds
move = 16:21;               %-0.5 to 0 seconds 
%rest = 1:11;                %-2 to -1 seconds 
rest = 11:16;               %-1 to -0.5 seconds 

%Features 
sampleM = mean(tfr_hann.powspctrm(:,ch,fr,move),4);     %move 
sampleR = mean(tfr_hann.powspctrm(:,ch,fr,rest),4);     %rest

[l,w,h] = size(sampleM);

s = [sampleM;sampleR]; 
s = reshape(s,l*2,w*h);             %all features independent 

label  = [ones(l,1);zeros(l,1)];    %ones:move zeros:rest 

cva = []; 
for i = 1:20
    N = size(s,1);
    cvp = cvpartition(N,'KFold',10);
    lda = fitcdiscr(s,label);         
    cvlda = crossval(lda,'CVPartition',cvp);
    ldaCVErr = kfoldLoss(cvlda);
    %disp(fprintf('Cross-validation accuracy: %.1f%%',100*(1-ldaCVErr)));
    cva = [cva; 100*(1-ldaCVErr)];
end
mean(cva)

%% LDA 3: bands of frequencies     
clear chan ind ch fr mov1 mov2 rest sample1 sample2 sample3 s1 s2 label cvp lda cvlda ldaCVErr

%tfr_hann.powspctrm (trial,channel,frequency,time) 
chan = {'FC2','FC6','C4','FC4','C2','C6'};

ch   = zeros(length(chan),1);

for i = 1:length(chan)
    ind = find(strcmp(tfr_hann.label,chan{i}));
    ch(i) = ind;
end

fr1 = 8:1:10;
fr2 = 10:1:12;

mov1 = 23:28;               %move 0.2:0.7 seconds 
mov2 = 36:41;               %Move 1.5:2 seconds (time window 500ms)
rest = 11:16;                %Rest -1:-0.5

%Features 
sample1f1 = mean(tfr_hann.powspctrm(:,ch,fr1,mov1),4);     %mov1 
sample1f1 = mean(tfr_hann.powspctrm(:,ch,fr1),3);
sample1f2 = mean(tfr_hann.powspctrm(:,ch,fr2,mov1),4);     %mov1 
sample1f2 = mean(tfr_hann.powspctrm(:,ch,fr2),3);

sample2f1 = mean(tfr_hann.powspctrm(:,ch,fr1,mov2),4);     %mov2 
sample2f1 = mean(tfr_hann.powspctrm(:,ch,fr1),3);
sample2f2 = mean(tfr_hann.powspctrm(:,ch,fr2,mov2),4);     %mov2 
sample2f2 = mean(tfr_hann.powspctrm(:,ch,fr2),3);

sample3f1 = mean(tfr_hann.powspctrm(:,ch,fr1,rest),4);     %rest
sample3f1 = mean(tfr_hann.powspctrm(:,ch,fr1),3);
sample3f2 = mean(tfr_hann.powspctrm(:,ch,fr2,rest),4);     %rest
sample3f2 = mean(tfr_hann.powspctrm(:,ch,fr2),3);

[l,w,h] = size(sample1f1);

s1 = [sample1f1 sample1f2;sample3f1 sample3f2]; 
%s1 = reshape(s1,l*2,w*h);            %all features independent 

s2 = [sample2f1 sample2f2;sample3f1 sample3f2]; 
%s2 = reshape(s1,l*4,w*h);            %all features independent 

label  = [ones(l,1);zeros(l,1)];    %ones:move zeros:rest 

N = size(s1,1);
cvp = cvpartition(N,'KFold',10);
lda = fitcdiscr(s1,label);          %change s1 to whichever sample want to find for
cvlda = crossval(lda,'CVPartition',cvp);
ldaCVErr = kfoldLoss(cvlda);
disp(fprintf('Cross-validation accuracy: %.1f%%',100*(1-ldaCVErr)));

%% LDA moving average individual channels 
clear chan ch ind fr move rest mmove mrest samp_move_fr samp_rest_fr samp_move_ch samp_rest_ch

% Channel selection 
chan = {'FC2','FC6','C4','FC4','C2','C6'};
ch   = zeros(length(chan),1);
for i = 1:length(chan)
    ind = find(strcmp(tfr_hann.label,chan{i}));
    ch(i) = ind;
end

% Frequencies, pre-movement window, rest window
fr = 1:3:15;         
move = 11:21;        %-1 to 0 seconds 
rest = 1:11;         %-2 to -1 seconds

% Features
%tfr_hann.powspctrm (trial,channel,frequency,time) 

%averaging the frequencies
samp_move_fr = mean(tfr_hann.powspctrm(:,ch,fr,move),3);    
samp_rest_fr = mean(tfr_hann.powspctrm(:,ch,fr,rest),3);     

%averaging the channels 
samp_move_ch = mean(samp_move_fr(:,:,:,:),2);  
samp_rest_ch = mean(samp_rest_fr(:,:,:,:),2);     


%% LDA: best accuracy results with average channels    
clear chan ch ind fr move rest sampleM sampleR s label cvp cva lda cvlda ldaCVErr

%tfr_hann.powspctrm (trial,channel,frequency,time) 
%chan = {'FC2','FC6','C4','FC4','C2','C6'};          % Left arm movement 
chan = {'FC1','FC3','FC5','C5','C3','C1'};         % Right arm movement

ch   = zeros(length(chan),1);
for i = 1:length(chan)
    ind = find(strcmp(tfr_hann.label,chan{i}));
    ch(i) = ind;
end

fr   = 1:3:15;              %Frequency 1-15 Hz with 3 Hz bins   

move = 11:21;               %-1 to 0 seconds
%move = 16:21;               %-0.5 to 0 seconds 
rest = 1:11;                %-2 to -1 seconds 
%rest = 11:16;               %-1 to -0.5 seconds 

%Features 
sampleM = mean(tfr_hann.powspctrm(:,ch,fr,move),4);     %move 
sampleM = mean(sampleM,2); sampleM = reshape(sampleM,size(sampleM,1),size(sampleM,3));
sampleR = mean(tfr_hann.powspctrm(:,ch,fr,rest),4);     %rest
sampleR = mean(sampleR,2); sampleR = reshape(sampleR,size(sampleR,1),size(sampleR,3));
[l,w] = size(sampleM);

s = [sampleM;sampleR]; 

label  = [ones(l,1);zeros(l,1)];    %ones:move zeros:rest 

cva = []; 
for i = 1:20
    N = size(s,1);
    cvp = cvpartition(N,'KFold',10);
    lda = fitcdiscr(s,label);         
    cvlda = crossval(lda,'CVPartition',cvp);
    ldaCVErr = kfoldLoss(cvlda);
    %disp(fprintf('Cross-validation accuracy: %.1f%%',100*(1-ldaCVErr)));
    cva = [cva; 100*(1-ldaCVErr)];
end
mean(cva)

