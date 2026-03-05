function [IDX, isnoise]=ADBSCAN(X,MinPts,erfa) % DBSCAN clustering function
% erfa: coefficient for computing epsilon
% epsilon is redefined as a dynamically computed value in this version

% === Part 1: Preprocessing with calculateknn ===
k = MinPts;
[rho, mutual_knn_count, Idx, D] = calculateknn(X, k);

% Filter high mutual-kNN samples (those where mutual_knn_count == k)
high_mutual_indices = find(mutual_knn_count == k);
KNmatrix = high_mutual_indices;
rhomatrix = rho(high_mutual_indices);

% Combine into matrix M and sort by density in descending order
M = [KNmatrix, rhomatrix];
M = sortrows(M, 2, 'descend');

% === Part 2: Modified DBSCAN Main Loop ===
C=0;           % Cluster counter, initialized to 0
n=size(X,1);   % Number of data points
IDX=zeros(n,1);        % Cluster label array, n x 1
visited=false(n,1);    % Visited flag array, all false initially
isnoise=false(n,1);    % Noise flag array, all false initially

% Traverse high mutual-kNN samples in order of M (high to low density)
for m_idx = 1:size(M, 1)
    i = M(m_idx, 1); % Original index of the current candidate core point

    if ~visited(i)
        visited(i) = true;

        % Dynamically compute epsilon: k-th nearest neighbor distance * erfa
        current_epsilon = D(i, k) * erfa;

        Neighbors = RegionQuery(i, current_epsilon);

        if numel(Neighbors) < MinPts
            isnoise(i) = true;
        else
            C = C + 1;
            ExpandCluster(i, Neighbors, C, current_epsilon);
        end
    end
end

% === Nested Function Definitions ===
    function ExpandCluster(i, Neighbors, C, current_eps)
        IDX(i) = C; % Assign point i to cluster C
        k_expand = 1;
        while true
            j = Neighbors(:,k_expand); % Current neighbor point being processed

            if ~visited(j)
                visited(j) = true;

                j_epsilon = current_eps;
                Neighbors2 = RegionQuery(j, j_epsilon);

                if numel(Neighbors2) >= MinPts % If j is also a core point
                    Neighbors = [Neighbors Neighbors2];
                end
            end

            if IDX(j) == 0 % If j has not been assigned to any cluster
                IDX(j) = C;
            end

            k_expand = k_expand + 1;
            if k_expand > numel(Neighbors)
                break;
            end
        end
    end

    function Neighbors = RegionQuery(i, eps)
        Neighbors = Idx(i, find(D(i,:) <= eps)); % Find all points within distance eps
    end

end
