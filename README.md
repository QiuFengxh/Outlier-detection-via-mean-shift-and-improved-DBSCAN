# Outlier Detection via Adaptive Density-Aware Clustering and Multi-Cluster Outlier Factor
Overview
This repository provides the implementation of two closely related algorithms for robust unsupervised anomaly detection:
1. ADBSCAN — An adaptive density-based clustering algorithm that extends classical DBSCAN by automatically adjusting density parameters across varying local neighborhood structures, enabling more accurate cluster discovery in datasets with non-uniform density distributions.
2. ADMOF (Adaptive Density-aware Multi-cluster Outlier Factor) — A novel outlier detection method built upon ADBSCAN. ADMOF computes an outlier score for each data point by evaluating its deviation relative to multiple surrounding clusters, capturing richer contextual information than single-cluster or k-nearest-neighbor-based approaches.
3. https://github.com/user-attachments/assets/8f489585-a345-41df-9387-8dd31fa2bde2
