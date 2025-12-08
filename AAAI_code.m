clear all; clc;
rng('default')

%% load dataset:
load('snap_hepth.mat');

%% Pre-processing
A = max(A,A'); % symmetrize
A = A - diag(diag(A)); % remove self-loops
% Extract largest connected component
G = graph(A);
[bins,binsizes] = conncomp(G);
idx = binsizes(bins) == max(binsizes);
SG = subgraph(G, idx);
A = adjacency(SG);
clear G SG;

G = graph(A);
E = incidence(G); % directed vertex-edge incidence matrix
L = laplacian(G); % graph laplacian
degree =  full(sum(A,2)); % degree vector

n = size(A,1); % Number of vertices
m = nnz(A)/2;  % Number of edges
w = ones(m,1); % edge weights (set to be 1 for unweighted graphs);

fprintf(1,'-----------Problem Stats---------------\n');
fprintf(1,'Number of vertices = %d\n',n);
fprintf(1,'Number of edges = %d\n',m);

K_values  = [10:10:100 200:100:1000];
for i = 1:length(K_values)
    rng(i)
    k = K_values(i);
    % initialization:
    x_ini = 1/n*ones(n,1);
    
    %% EP-Prox method
    % suggested parameters:
    % For different datasets, parameter fine-tuning may lead to better results.
    lambda = 1e-10;
    c_lambda = 20;
    error_out = 1e-11;
    Iter_out= 100;
    Iter_in = 10;
    error_in = 5e-1;
    
    t1 = clock;
    [ x_EPprox ] = DkS_EPprox_PGM(A, x_ini, lambda, ...
        c_lambda, error_out, error_in, Iter_out, Iter_in, k);
    t2 = clock;
    
    cutsize_EPprox = x_EPprox.'*A* x_EPprox;
    time_EPprox = etime(t2,t1);
    obj(i) = cutsize_EPprox;
    density(i) = obj(i)./(k*(k-1));
    time(i) = time_EPprox;
    
    fprintf('--- k = %d ---\n', k);
    
end
% display the results:
fprintf('--- Display Results ---\n');
fprintf('EdgeDensity | Runtime \n');
fprintf('    %.4f    %.4f\n', [density', time'].');

figure;
% Edge Density
semilogx(K_values, density, 'r--*');
xlabel('$k$','Interpreter', 'latex');
ylabel('Edge Density');
grid on;
title('HepTh');
legend('EP-Prox')

