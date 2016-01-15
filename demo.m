%
% Photometric stereo demo
%

close all; clear all; clc;

initDemo;

while(1)
	getImage;							% Acquire images
	[m,n] = size(img);					% Get size of image
	nIters  = 1000;                     % # of iterative least-square steps
	lambda  = 0;                        % Tikhonov regularization parameter

	[U,S,V] = svds(I,3);				% Take sparse SVD
	N = [U(:,2:3) U(:,1)];				% Top 3 left singular vectors correspond to (z,x,y) normal
	N = reshape(N,[m,n,3]);				% Reshape into matrix

	M = img;
	M = (M > 0.3);

	% Compute gradients from normals
	DFDX = -N(:,:,1) ./ N(:,:,3);
	DFDY =  N(:,:,2) ./ N(:,:,3);
	DFDX(isnan(DFDX) | ~M) = 0;         % Clean data and apply mask
	DFDY(isnan(DFDY) | ~M) = 0;         % Clean data and apply mask

	% Construct least-squares problem from gradients
	[A, b] = constructSurface(DFDX, DFDY, lambda);

	% Solve least-squares problem (MATLAB IMPLEMENTATION)
	[fxy, ~] = lsqr(A, b, [], nIters);			% MATLAB implmentation

	% Solve least-squares problem (OCTAVE IMPLEMENTATION)
	% 
	% fxy = pcg(A'*A,A'*b);						% Octave implmentation

	% Format surface
	FXY = reshape(fxy, [m, n]);         % Reshape into matrix
	FXY = (FXY - min(FXY(logical(M)))) .* M;     % Anchor to z-axis and apply mask

	% Write stl file
	% [XX, YY] = meshgrid(1:n, m:-1:1);
	% FV = surf2solid(XX, YY, FXY, 'elevation', 0);
	% stlwrite(outpath, FV);
	% fprintf('%s written\n', outpath);

	% Plot results
	% figure;
	% subplot(2,2,1); imshow(DFDX, []); title('x-gradients'); colorbar;
	% subplot(2,2,2); imshow(DFDY, []); title('y-gradients'); colorbar;
	% subplot(2,2,3); imshow(FXY, []);  title('depth map');   colorbar;
	% subplot(2,2,4); surfplot(FXY);    title('surface');

	% display('Finished reconstructing surface. Plotting results.')

	figure(2);  surfplot(FXY)
	% subplot(1,2,1); imshow(FXY, []);  title('depth map');   colorbar;
	% subplot(1,2,2); surfplot(FXY);    title('surface');
end