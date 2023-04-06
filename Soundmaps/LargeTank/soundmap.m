% soundmap.m
% Jackie Culotta
% R2022a
% 2022/6/3
% This m-file generates soundmaps using the counterf and contourfcmap functions
% Using large tank data

clc;         % Clear the Command Window display 
clear all; % Clear Workspace (All variables will be removed from memory) 
format compact  %Control line spacing format 

pwd
cd('C:\Users\jacki\OneDrive\Documents (Onedrive)\Thesis\Analysis\Soundmap\MatLab\LargeTank')% Sets working directory
%% Import data
onTop = xlsread('Soundmap_Large_onTop.xlsx');
onMiddle = xlsread('Soundmap_Large_onMiddle.xlsx');
onBottom  = xlsread('Soundmap_Large_onBottom.xlsx');

% Allocate imported arrays to column variable names 
onTop_dB = (onTop(:,1));
onMiddle_dB = (onMiddle(:,1));
onBottom_dB = (onBottom(:,1));

X_cm = (onTop(:,2));
Y_cm = (onTop(:,3));

X_cm_Middle= (onMiddle(:,2));
Y_cm_Middle = (onMiddle(:,3));

X_cm_Bottom = (onBottom(:,2));
Y_cm_Bottom = (onBottom(:,3));

%% Interpolate Between Sample Locations
% define a regular grid
[xq,yq] = meshgrid(0:1:400, 0:1:155); % in cm

% interpolate the scattered data over the grids for each depth
vq_onTop = griddata(X_cm,Y_cm,onTop_dB,xq,yq,'natural');
vq_onMiddle = griddata(X_cm_Middle,Y_cm_Middle,onMiddle_dB,xq,yq,'natural');
vq_onBottom = griddata(X_cm_Bottom,Y_cm_Bottom,onBottom_dB,xq,yq,'natural');

% Set interior tank boundaries as NaN
    % redundant if patches are used
% vq([1:58],[165:232]) = NaN; % cut out area below shuttle
% vq([97:end],[165:232]) = NaN; % cut out area above shuttle

% Create polygon patches for tank exterior
v = [77 0; 116 11; 144 39; 164 58; 232 58; 252 38; 280 10; 319 0;77 0];
f = [1:9];
v2 = [77 154; 116 144; 144 116; 164 96; 232 96; 252 115; 280 144; 319 154;77 154]; 

%% (Optional) Create contourf 2D map from interpolated values
figure
contourf(xq,yq,vq_onTop,10,... % ...vq,n ... where n = number of levels 
    'LineColor', 'none') 
c2 = colorbar('eastoutside');
hold on
plot(X_cm,Y_cm,'blacko') % plot sample locations
legend('SPL','Sample Location',...
    'Location','south','AutoUpdate','off');
patch('Faces',f,'Vertices',v,...
    'EdgeColor','none', 'FaceColor','white') % bottom patch
patch('Faces',f,'Vertices',v2,...
    'EdgeColor','none', 'FaceColor','white') % top patch
plot(X_cm,Y_cm,'blacko') % plot sample locations
c2.Label.String = 'Sound Pressure Level (dB re 1 \muPa)';
c2.Label.FontSize = 13;
xlabel('Shuttle Tank Length (cm)', 'FontSize', 13);
ylabel('Shuttle Tank Width (cm)','FontSize', 13);
title('Broadcast at Top Depth','FontSize', 15);

%% Tile all depths with base contour

% confirm mins and maxes are identical 
% or else each scale will be different
min(onTop_dB)
min(onMiddle_dB)
min(onBottom_dB)
max(onTop_dB)
max(onMiddle_dB)
max(onBottom_dB)

% Create tiled layout
figure('Position', [1, 1, 750, 900]) % 300px * 2in height, 2.5 in wide
t = tiledlayout(3,1);

% Shared title, x and y axes
%title(t,'Broadband Sound Map');
xlabel(t,'Shuttle Tank Length (cm)', 'FontName', 'Arial', 'FontSize', 13);
ylabel(t,'Shuttle Tank Width (cm)', 'FontName', 'Arial', 'FontSize', 13);

% Tile 1 - Top depth
nexttile
contourf(xq,yq,vq_onTop,10,... % ...vq,n ... where n = number of levels 
    'LineColor', 'none');
colormap("jet"); % sets colormap for all maps
patch('Faces',f,'Vertices',v,...
    'EdgeColor','none', 'FaceColor','white') % bottom patch
patch('Faces',f,'Vertices',v2,...
    'EdgeColor','none', 'FaceColor','white') % top patch
%hold on ; plot(X_cm,Y_cm,'blacko') % plot sample locations
hold on ; plot(77,77, 'whitex', 'MarkerSize',10, 'LineWidth',2) % plot active speaker location
title('Top Depth','FontName', 'Arial', 'FontWeight', 'normal', 'FontSize', 11);

% Tile 2 - Middle Depth
nexttile
contourf(xq,yq,vq_onMiddle,10,... % ...vq,n ... where n = number of levels 
    'LineColor', 'none') 
patch('Faces',f,'Vertices',v,...
    'EdgeColor','none', 'FaceColor','white') % bottom patch
patch('Faces',f,'Vertices',v2,...
    'EdgeColor','none', 'FaceColor','white') % top patch
%hold on ; plot(X_cm,Y_cm,'blacko') % plot sample locations
hold on ; plot(77,77, 'whitex', 'MarkerSize',10, 'LineWidth',2) % plot active speaker location
title('Middle Depth','FontName', 'Arial', 'FontWeight', 'normal','FontSize', 11);

% Tile 3 - Bottom Depth
nexttile
contourf(xq,yq,vq_onBottom,10,... % ...vq,n ... where n = number of levels 
    'LineColor', 'none') 
patch('Faces',f,'Vertices',v,...
    'EdgeColor','none', 'FaceColor','white') % bottom patch
patch('Faces',f,'Vertices',v2,...
    'EdgeColor','none', 'FaceColor','white') % top patch
%hold on ; plot(X_cm,Y_cm,'blacko') % plot sample locations
hold on ; plot(77,77, 'whitex', 'MarkerSize',10, 'LineWidth',2) % plot active speaker location
title('Bottom Depth','FontName', 'Arial', 'FontWeight', 'normal','FontSize', 11);

% Create shared colorbar
cb = colorbar;
cb.Layout.Tile = 'east';
cb.Label.String = 'Sound Pressure Level (dB re 1 \muPa)'; 
cb.Label.FontSize = 13;

% Export figure
 exportgraphics(t,'Large_Tank_Soundmap.tif', 'Resolution',300);