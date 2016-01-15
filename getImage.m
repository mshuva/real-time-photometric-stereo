%% Code courtesy of Jeffrey Lu and the Magneto project from EECS 451 (Fall 2014)

% close all; clear all;					% close figures and release camera

% % ------------------------------ INITIALIZE WEBCAM ------------------------------
% vidDevice = imaq.VideoDevice;
% vidInfo = imaqhwinfo(vidDevice); % Acquire input video property
% % hVideoIn = vision.VideoPlayer('Name', 'Final Video','Position', [100 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]); 	% not sure what this is for...
% % ------------------------------ INITIALIZE WEBCAM ------------------------------


% % ------------------------------ GENERATE LIGHTING ------------------------------
% config1 = [1 0];
% config2 = [0 1];
% config3 = [1; 0];
% config4 = [0; 1];
% L = {config1, config2, config3, config4};
% % ------------------------------ GENERATE LIGHTING ------------------------------


% ------------------------------ IMAGE ACQUISITION ------------------------------
% 1. Display the image on the screen
% 2. Aquire the image and store it into the I matrix
% 3. Repeat loop with next configuration
for i = 1:4
	figure(1)
	showFullscreen(L{i})
	colormap(gray)
	drawnow
	pause(1)
	img = step(vidDevice);							% Acquire single frame
	img = imresize(rgb2gray(flipdim(img,2)),0.25); 	% Obtain the mirror image for displaying
	I(:,i) = img(:);								% Store vectorized image as column
end
% ------------------------------ IMAGE ACQUISITION ------------------------------

I = double(I);				% Needs to be a double for SVD to work
% imagesc(img)
% colormap(gray)							% Set colormap to grayscale for viewing