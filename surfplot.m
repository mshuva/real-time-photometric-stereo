function surfplot(fxy)
%
% Syntax:       surfplot(fxy);
%               
% Inputs:       fxy is an (m x n) matrix
%               
% Description:  Plots the surface f(i,j) = fxy(i,j)
%

% Parse inputs
[m, n] = size(fxy);

% Lighting vector
% Centered above image, far away from surface
S = [n/2, m/2, 10 * max(fxy(:))];

% Plot surface
surfl(fxy, S);

% Format axis
shading interp;
colormap gray;
% axis fill;
axis equal;
set(gca,'xdir','normal');
set(gca,'ydir','reverse');
