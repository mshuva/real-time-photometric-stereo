% ------------------------------ INITIALIZE WEBCAM ------------------------------
vidDevice = imaq.VideoDevice;
vidInfo = imaqhwinfo(vidDevice); % Acquire input video property
% hVideoIn = vision.VideoPlayer('Name', 'Final Video','Position', [100 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]); 	% not sure what this is for...
% ------------------------------ INITIALIZE WEBCAM ------------------------------


% ------------------------------ GENERATE LIGHTING ------------------------------
config1 = [1 0];
config2 = [0 1];
config3 = [1; 0];
config4 = [0; 1];
L = {config1, config2, config3, config4};
% ------------------------------ GENERATE LIGHTING ------------------------------