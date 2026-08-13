%% Open and Plot All Data for a Single Crystal Type
%
%

clear all
close all

r = 118;
a = 390;
n = 25;
copy = 0;

% Calculate wg length
Lwg = wgLength(a, n); %mm

% Obtain waveguide and insertion losses for chip
[TE_wg,TE_in,TM_wg,TM_in] = LossesTETM(Lwg);

folder = 'Jul_03_2026';

latticeParams = strcat('a=',string(a),'nm, r=',string(r),'nm, n_x=',string(n));

% Import pure PhC data
PhC_TE = strcat(folder,'/PhC/a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PHC_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TE_',string(copy),'.dat');
PhC_TM = strcat(folder,'/PhC/a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PHC_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TM_',string(copy),'.dat');

% Import W1 data
W1_TE = strcat(folder,'/PBG/a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/W1_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TE_',string(copy),'.dat');
W1_TM = strcat(folder,'/PBG/a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/W1_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TM_',string(copy),'.dat');

% Import PBS data
TEdir = strcat(folder,'/PBS/PBS_a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PBS_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TE_DIR_',string(copy),'.dat');
TEadj = strcat(folder,'/PBS/PBS_a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PBS_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TE_ADJ_',string(copy),'.dat');
TMdir = strcat(folder,'/PBS/PBS_a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PBS_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TM_DIR_',string(copy),'.dat');
TMadj = strcat(folder,'/PBS/PBS_a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PBS_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TM_ADJ_',string(copy),'.dat');

% plotData(TE_wg,TE_in,TM_wg,TM_in, PhC_TE, PhC_TM, W1_TE, W1_TM, latticeParams)
plotPBSData(TE_wg,TE_in,TM_wg,TM_in, TEdir, TEadj, TMdir, TMadj, latticeParams)