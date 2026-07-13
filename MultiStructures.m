%% Open and Plot All Data for a Single Crystal Type
%
%

clear all
close all

r = 118;
a = 390;
n = 25;
copy = 0;

folder = 'Jul_03_2026';

latticeParams = strcat('a=',string(a),'nm, r=',string(r),'nm, n_x=',string(n));

% Import pure PhC data
% PhC_TE = 'Jul_03_2026/PhC/a390_r098_nx25_0/PHC_A390NM_R98NM_N25_TE_0.dat';
% PhC_TM = 'Jul_03_2026/PhC/a390_r098_nx25_0/PHC_A390NM_R98NM_N25_TM_0.dat';
PhC_TE = strcat(folder,'/PhC/a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PHC_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TE_',string(copy),'.dat');
PhC_TM = strcat(folder,'/PhC/a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PHC_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TM_',string(copy),'.dat');

% Import W1 data
% W1_TE = 'Jul_03_2026/PBG/a390_r098_nx25_0/W1_A390NM_R98NM_N25_TE_0.dat';
% W1_TM = 'Jul_03_2026/PBG/a390_r098_nx25_0/W1_A390NM_R98NM_N25_TM_0.dat';
W1_TE = strcat(folder,'/PBG/a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/W1_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TE_',string(copy),'.dat');
W1_TM = strcat(folder,'/PBG/a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/W1_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TM_',string(copy),'.dat');

% Import PBS data
% TEdir = 'Jul_03_2026/PBS/PBS_a390_r108_nx25_0/PBS_A390NM_R108NM_N25_TE_DIR_0.dat';
% TEadj = 'Jul_03_2026/PBS/PBS_a390_r108_nx25_0/PBS_A390NM_R108NM_N25_TE_ADJ_0.dat';
% TMdir = 'Jul_03_2026/PBS/PBS_a390_r108_nx25_0/PBS_A390NM_R108NM_N25_TM_DIR_0.dat';
% TMadj = 'Jul_03_2026/PBS/PBS_a390_r108_nx25_0/PBS_A390NM_R108NM_N25_TM_ADJ_0.dat';
TEdir = strcat(folder,'/PBS/PBS_a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PBS_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TE_DIR_',string(copy),'.dat');
TEadj = strcat(folder,'/PBS/PBS_a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PBS_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TE_ADJ_',string(copy),'.dat');
TMdir = strcat(folder,'/PBS/PBS_a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PBS_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TM_DIR_',string(copy),'.dat');
TMadj = strcat(folder,'/PBS/PBS_a',string(a),'_r',string(r),'_nx',string(n),'_',string(copy),'/PBS_A',string(a),'NM_R',string(r),'NM_N',string(n),'_TM_ADJ_',string(copy),'.dat');

plotData(PhC_TE, PhC_TM, W1_TE, W1_TM, latticeParams)
plotPBSData(TEdir, TEadj, TMdir, TMadj, latticeParams)