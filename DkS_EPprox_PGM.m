% DkS with non-smooth error bound problem
% accelerated proximal gradient method
function  [x_new] = DkS_EPprox_PGM( A, x_ini, lambda, ...
    c_lambda,error_out, error_in, Iter_out, Iter_in, k)
n = size(A,1);

% Initialization
x_i = x_ini;        % Current point x^k
yx = x_ini;         % Extrapolated point y^k
iter = 0;
t_pre = 1;

eigs_A1 = normest(A);
c_beta = 0.9;
beta = c_beta * eigs_A1;
Lf = 2*(abs(beta) +  eigs_A1);
alpha = 1;
A_beta = 2*(-A + beta * speye(n));
stepsize = alpha*1/Lf;
iter_pre = iter;
no_converg = 1;

% accelerated proximal gradient method
while no_converg
    iter = iter + 1;
    
    % --- gradient value ---
    grad = A_beta * yx;
    z = yx - stepsize* grad;
    x_inew = proximal_operator(z, k, lambda, stepsize);
    
    % --- stopping criterion ---
    if iter >= Iter_out
        break;
    end
    x_diff = x_inew - x_i;
    norm_xdiff = norm(x_diff, 2);
    if  norm_xdiff^2 < error_out
        break;
    end
    
    % --- FISTA momentum update ---
    t = (1 + sqrt(1 + 4 * t_pre^2)) / 2;
    yx = x_inew + ((t_pre - 1) / t) * (x_inew - x_i);
    
    % --- update lambda ---
    if  iter == iter_pre+Iter_in || norm_xdiff/norm(x_inew,2) < error_in
        iter_pre = iter;
        lambda = lambda * c_lambda;
    end
    
    % --- update for next iteration ---
    t_pre = t;
    x_i = x_inew;
    
end
x_new = x_inew;
end

function x = proximal_operator(z, k, lambda, stepsize)
% compute the proximal operator
st_lam = stepsize * lambda;
x = min(1, max(0, z - st_lam));
% Find the indices of the largest k elements
[~, idx] = maxk(z, k);
x(idx) = min(1, max(0, z(idx) + st_lam));
end