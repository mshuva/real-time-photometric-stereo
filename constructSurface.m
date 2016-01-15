function [A, b] = constructSurface(DFDX, DFDY, lambda)
%
% Syntax: [A, b] = hw8p9(DFDX, DFDY, lambda);
%
% Inputs: DFDX and DFDY are (m x n) matrices containing the partial
% derivatives of f with respect to x and y at each pixel
% coordinate
%
% lambda >= 0 is the Tikhonov regularization parameter
%
% Outputs: A is a (3mn x mn) sparse matrix and b is a (3mn x 1) vector
% such that solving
%
% fxy = argmin f | | b − Af||ˆ 2
%
% yields the surface FXY = reshape(fxy, [m, n]) with partial
% derivatives DFDX and DFDY
%
	[m,n] = size(DFDX);

	% construct b
	b = [DFDX(:); DFDY(:); zeros(m*n,1)];

	% Construct A matrix
	Im = speye(m,m);
	In = speye(n,n);
	Imn = speye(m*n,m*n);

	Dm = sparse(1:m-1,2:m,ones(1,m-1),m,m) - Im;
	Dm(end,1) = 1;
	Dn = sparse(1:n-1,2:n,ones(1,n-1),n,n) - In;
	Dn(end,1) = 1;

	A = [kron(Dn,Im); kron(In,Dm); sqrt(lambda)*Imn];

end