function [certain] = certainty(locs,peak_max_phi,K,phi,pos_sources)
certain_base = zeros(size(peak_max_phi));
K_local = zeros(length(peak_max_phi),sum(sum(locs(peak_max_phi,:)~=0)~=0));
phi_local = K_local;
for i=1:length(peak_max_phi)
    K_local(i,1:sum(locs(peak_max_phi(i),:)~=0)) = K(locs(peak_max_phi(i,1),1),locs(peak_max_phi(i),:)~=0);
    phi_local(i,1:sum(locs(peak_max_phi(i),:)~=0)) = phi(locs(peak_max_phi(i,1),:)~=0)';
%     scale = norm(K_local)/norm(phi_local);
    if (sum(phi_local(i,:) + K_local(i,:))/2)~=0
        sk = (sum(phi_local(i,:)*10e2 + K_local(i,:)*10e2)/2)/10e2;
        cert = sum(phi_local(i,:) - K_local(i,:))/sk;
%         if cert~=0
%             disp(cert);
%         end
    else
        cert = 1;
    end
    if isnan(cert)
        cert = 0;
    end
%     certain_base(i,:) = 100 - abs(cert);
    certain_base(i,:) = abs(cert);
end
certain = zeros(size(pos_sources));
for i=1:size(pos_sources,1)
    for j = 1:size(pos_sources,2)
        if pos_sources(i,j)~=0
            certain(i,j) = certain_base(i,1);
        end
    end
end
end