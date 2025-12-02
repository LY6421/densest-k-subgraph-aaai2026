# A Scalable and Exact Relaxation for Densest k-Subgraph via Error Bounds

This repository contains the demo codes for our paper.

The extended version with supplementary material is available on arXiv: [https://arxiv.org/abs/2511.11451](https://arxiv.org/abs/2511.11451)

If you find this work useful, please cite XXX (coming soon).

## Benchmark Methods

We compare our proposed method with six widely-used baselines for the Densest-$k$-Subgraph (D$k$S) problem:

(i) Greedy method [Feige et al., 2001]  
(ii) Truncated Power Method (TPM) [Yuan et al., 2013]  
(iii) Rank-1 Binary Principal Component (Rank-1 PC) approximation [Papailiopoulos et al., 2014]  
(iv) Lovász relaxation via Linearized-ADMM (Lovász) [Konar and Sidiropoulos, 2021]  
(v) Extreme Point Pursuit (EXPP) method [Liu et al., 2024a, 2024b]  
(vi) Frank-Wolfe (FW) method [Lu et al., 2025]

We used our own implementations for (i) and (ii).
For methods (3), (4), and (6), we used the official implementations provided by the original authors:
- (iii): [https://github.com/mitliagkas/spannogram](https://github.com/mitliagkas/spannogram}).
- (iv): [https://github.com/mitliagkas/spannogram](https://github.com/luqh357/DkS-Diagonal-Loading}).
- (vi):[https://github.com/mitliagkas/spannogram](https://github.com/luqh357/DkS-Diagonal-Loading}),
