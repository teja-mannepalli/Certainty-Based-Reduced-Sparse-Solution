function [J_CARSS,peaks,pos_sources,pos_sourcesm] = Stage_I(phi,locs,K,gd,Ds,...
    Des,Desm)

[peak_max_phi,peak_min_phi] = find_peaks_phi(phi,locs);
[peak_max_phi] = remodel_peakindxs(peak_max_phi,locs,Des);
[peak_min_phi] = remodel_peakindxs(peak_min_phi,locs,Desm);

peaks = [rem_zeros(peak_max_phi)' rem_zeros(peak_min_phi)'];
    
% fprintf('           The numer of peaks %d',numel(peaks~=0));
% fprintf('\n');
if sum(peak_max_phi)==0
    J_prior = zeros(size(K,2),1);
    pos_sources = 0;
else
    [J_prior,pos_sources] = Stage_I_max(peak_max_phi,locs,Des,K,phi,gd,Ds);
end

if sum(peak_min_phi)==0
     J_priorm = zeros(size(K,2),1);
     pos_sourcesm = 0;
else
    [J_priorm,pos_sourcesm] = Stage_I_min(peak_min_phi,locs,Desm,K,phi,gd,Ds);
end
J_CARSS = J_prior + J_priorm;
if sum(J_CARSS==0)==length(J_CARSS)
    J_CARSS = ones(size(J_CARSS));
end
end