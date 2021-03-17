clc
close all;
clear;

load('K_carss_IITKGP');
load('grid_IITKGP.mat');
load('K_IITKGP_ft.mat');
load('elec_IITKGP');

%%
[Ds] = find_Ds(grid);
r = 85;
fprintf('Stage-0');
fprintf('\n');
[locs,peak_indxs_max,peak_indxs_min,Ds,Delec] = Stage_0(K,elec.chanpos,grid.dipos,r,Ds);
% [~,locs] = find_locs(Delec,elec,db);
%%
close all;
clc
aa = [1400,345];
gd = 20;

phi = sum(K(:,aa),2);

J_problem = zeros(size(K,2),1);
J_problem(aa,1) = 1;

fprintf('CARSS');
fprintf('\n');

[J_CARSS,peaks,pos_sources_all,J_MNE]...
    = CARSS(K,phi,gd,locs,peak_indxs_max,peak_indxs_min,Ds);

phians = K*J_MNE;
fprintf('Error = %d',round(sum(phi - phians)/sum(phi),3));
fprintf('\n');
