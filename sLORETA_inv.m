function [J_sLORETA] = sLORETA_inv(K,phi,alpha)
[Nchan, ~] = size(K);

H = eye(Nchan,Nchan);
pre = 0;
% alpha = 100;
if pre==0
    if isempty(alpha)
        [U,s,~] = csvd(K);
        [reg_corner,~,~,~] = l_curve(U,s,phi,'tsvd');
        alpha = reg_corner;
        close
    end
    T_sLORETA = K'*pinv(K*K'+alpha*H);
else
    if size(K,2)>21000
        load('C:\Users\DELL\Documents\MATLAB\T_sLORETA_IITKGP2AIIMS','T_sLORETA');
    else
        load('C:\Users\DELL\Documents\MATLAB\T_sLORETA_IITKGP.mat','T_sLORETA');
    end
end

J_sLORETA = T_sLORETA*phi;
end

