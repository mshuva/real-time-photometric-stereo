function showFullscreen(image)
	% get the figure and axes handles
	hFig = gcf;
	hAx  = gca;
	% set the figure to full screen
	set(hFig,'units','normalized','outerposition',[0 0 1 1]);
	% set the axes to full screen
	set(hAx,'Unit','normalized','Position',[0 0 1 1]);
	% hide the toolbar
	set(hFig,'menubar','none')
	% to hide the title
	set(hFig,'NumberTitle','off');
	imagesc(image);
end