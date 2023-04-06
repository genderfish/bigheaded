% soundmap_small.m
% Jackie Culotta
% MatLab R2022a
% 2022/6/8
% This m-file generates soundmaps using the counterf function
clc;         % Clear the Command Window display 
clear all; % Clear Workspace (All variables will be removed from memory) 
format compact  % Control line spacing format 

% Sets working directory
pwd
cd('C:\Users\jacki\OneDrive\Documents (Onedrive)\Thesis\Analysis\Soundmap\MatLab\SmallTank')
%% Import data

onTop = xlsread('Soundmap_Small_onTop.xlsx');
onBottom  = xlsread('Soundmap_Small_onBottom.xlsx');

% Allocate imported arrays to column variable names 
onTop_dB = (onTop(:,2));
onBottom_dB = (onBottom(:,2));

X_cm_Top = (onTop(:,3));
Y_cm_Top = (onTop(:,4));

X_cm_Bottom = (onBottom(:,3));
Y_cm_Bottom = (onBottom(:,4));

%% Interpolate Between Sample Locations
% define a regular grid
[xq,yq] = meshgrid(0:1:110, 0:1:50); % in cm

% interpolate the scattered data over the grids for each depth
vq_onTop = griddata(X_cm_Top,Y_cm_Top,onTop_dB,xq,yq,'natural');
vq_onBottom = griddata(X_cm_Bottom,Y_cm_Bottom,onBottom_dB,xq,yq,'natural');

% To setup shared bar, need same min & max dB values
% confirm mins and maxes are the same or else each scale will be different
% added a dummy min value outside of the tank to fix this
minTop = min(onTop_dB) 
minBot = min(onBottom_dB)
maxTop = max(onTop_dB)
maxBot = max(onBottom_dB)

% both logicals should be true (1)
maxTop == maxBot % conveniently they have the same max value
minTop == minBot % needed to add 119 dB dummy point to onBottom

%% Tile all depths with base contour
% Create two polygon patches for tank exterior
v = [25 0; 38 4; 47 13; 50 20; 55 20; 60 20; 63 12; 72 3;85 0]; % vertices for bottom patch
f = [1:9]; % number of faces ie lines
v2 = [25 50; 38 47; 47 38; 50 30; 55 30; 60 30; 63 37; 72 46; 85 50]; % vertices for top patch

% Create figure and tiled layout
figure('Position', [1, 1, 750, 600])
t = tiledlayout(2,1);

% Shared title, x and y axes
% title(t,'Small Tank Sound Map');
xlabel(t,'Shuttle Tank Length (cm)', 'FontSize', 13','FontName','Arial');
ylabel(t,'Shuttle Tank Width (cm)','FontSize', 13,'FontName','Arial');

% Tile 1 - Top depth
nexttile
contourf(xq,yq,vq_onTop,10,... % ...vq,n ... where n = number of levels 
    'LineColor', 'none');
colormap("jet");
patch('Faces',f,'Vertices',v,...
    'EdgeColor','none', 'FaceColor','white') % bottom patch
patch('Faces',f,'Vertices',v2,...
    'EdgeColor','none', 'FaceColor','white') % top patch
% hold on ; plot(X_cm_Top,Y_cm_Top,'blacko') % plot sample locations
hold on ; plot(25,25, 'whitex', 'MarkerSize',10, 'LineWidth',2) % plot active speaker location
title('Top Depth','FontSize', 11,'FontName','Arial', 'FontWeight','normal');

% Tile 2 - Bottom Depth
nexttile
contourf(xq,yq,vq_onBottom,10,... % ...vq,n ... where n = number of levels 
    'LineColor', 'none')
patch('Faces',f,'Vertices',v,...
    'EdgeColor','none', 'FaceColor','white') % bottom patch
patch('Faces',f,'Vertices',v2,...
    'EdgeColor','none', 'FaceColor','white') % top patch
% hold on ; plot(X_cm_Bottom,Y_cm_Bottom,'blacko') % plot sample locations
hold on ; plot(25,25, 'whitex', 'MarkerSize',10, 'LineWidth',2) % plot active speaker location
title('Bottom Depth','FontSize', 11,'FontName','Arial','FontWeight','normal');

% Create shared colorbar
cb = colorbar;
cb.Layout.Tile = 'east';
cb.Label.String = 'Sound Pressure Level (dB re 1 \muPa)'; 
cb.FontName = 'Arial';
cb.Label.FontSize = 13;
%caxis([119,143]);                                                            % sets scale on color bar

% Export figure
  exportgraphics(t, 'Small_Tank_Soundmap.tif', 'Resolution',300)