%
% Photometric stereo demo
%
% Original code from Prof. Raj Nadakuditi's EECS 453/551 class @ University of Michigan
% 

clear all; clc;

nIters  = 1000;                     % # of iterative least-square steps
lambda  = 0;                        % Tikhonov regularization parameter
scaleFactor = 0.25;					% Scale image by this

% ------------------------------ INITIALIZE WEBCAM ------------------------------
vidDevice = imaq.VideoDevice;
vidInfo = imaqhwinfo(vidDevice); % Acquire input video property
height = vidInfo.MaxHeight;		% collect size of image
width = vidInfo.MaxWidth;
% ------------------------------ INITIALIZE WEBCAM ------------------------------

% ------------------------------ GENERATE LIGHTING ------------------------------
config1 = [1 0];
config2 = [0 1];
config3 = [1; 0];
config4 = [0; 1];
L = {config1, config2, config3, config4};
% ------------------------------ GENERATE LIGHTING ------------------------------

m = height*scaleFactor;				% Scale image size
n = width*scaleFactor;				% Scale image size

I = ones(m*n,4); M = zeros(m,n);    % initialize image matrix
i = 1;

while(1)
    i = i + 1; i = mod(i-1,4)+1;		% Need to cycle through images and lighting
    
    figure(1)
    showFullscreen(L{i})
    colormap(gray)
    drawnow
% ------------------------------ BEGIN PROCESSING ------------------------------
    [U,~,~] = svds(I,3);				% Take sparse SVD, only need left singular vectors
    N = [U(:,2:3) U(:,1)];				% Top 3 left singular vectors correspond to (z,x,y) normal
    N = reshape(N,[m,n,3]);				% Reshape into matrix
    
    % Compute gradients from normals
    DFDX = -N(:,:,1) ./ N(:,:,3);
    DFDY =  N(:,:,2) ./ N(:,:,3);
    DFDX(isnan(DFDX) | ~M) = 0;         % Clean data and apply mask
    DFDY(isnan(DFDY) | ~M) = 0;         % Clean data and apply mask
    
    % Construct least-squares problem from gradients
    [A, b] = constructSurface(DFDX, DFDY, lambda);
    
    % Solve least-squares problem
	[fxy, ~] = lsqr(A, b, [], nIters);
    % fxy = A\b;
    
    % Format surface
    FXY = reshape(fxy, [m, n]);         			% Reshape into matrix
    if nnz(M) == 0
        FXY = zeros(m,n);							% Handle the case where there is no object
    else
        FXY = (FXY - min(FXY(M))) .* M;				% Anchor to z-axis and apply mask
    end
    
    figure(2);
    % 	subplot(2,2,1); imshow(FXY, []);  title('Depth Map');   colorbar;
    % 	subplot(2,2,2); surfplot(FXY);    title('Front View'); view([0 90])
    % 	subplot(2,2,3); surfplot(FXY);    title('Side View'); view([0 0])
    % 	subplot(2,2,4); [az,el] = view; surfplot(FXY);    title('Surface'); view([az,el]);
    [az,el] = view; surfplot(FXY); title('Surface'); view([az,el]);			% Plot surface
% ------------------------------- END PROCESSING -------------------------------
    
    images{i} = step(vidDevice);									% Acquire single frame
    img = imresize(rgb2gray(flipdim(images{i},2)),scaleFactor); 	% Obtain the mirror image for displaying
    I(:,i) = double(img(:));										% Store vectorized image as columns
    M = reshape(I(:,1),m,n);										
    M = (M > 0.5);													% Generate mask
end