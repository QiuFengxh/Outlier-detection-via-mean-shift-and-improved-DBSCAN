function [ro_data] = ADMOF(data,labels,localKDE,icl,k)
% CALCULATE_SCORE Compute anomaly scores based on neighbor cluster center density (KDTree version)
%
% Inputs:
%   data     - Sample data matrix (num x dim)
%   labels   - Cluster label for each sample (0 = noise)
%   localKDE - Local density estimate for each sample (num x 1)
%   icl      - Cluster center indices (length = number of clusters)
%   k        - Number of neighbors
%
% Output:
%   ro_data  - Anomaly score for each sample (num x 1)

[num,~] = size(data);
maxcen = max(localKDE(icl,:));
ro_data = zeros(num,1);

Mdl = KDTreeSearcher(data);
[Index, ~] = knnsearch(Mdl, data, 'K', k+1);

for i = 1:num
    if labels(i) ~= 0
        neigh_idx = Index(i,2:k+1);
        neigh_center_density = zeros(k,1);
        for j = 1:k
            neigh_label = labels(neigh_idx(j));
            if neigh_label == 0
                neigh_center_density(j) = maxcen;
            else
                neigh_center_density(j) = localKDE(icl(neigh_label));
            end
        end
        mean_center_density = mean(neigh_center_density);
        ro_data(i) = mean_center_density / localKDE(i);
    else
        ro_data(i) = maxcen / localKDE(i);
    end
end
end