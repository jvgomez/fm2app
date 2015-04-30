[F, time] = FM2_VelocitiesMap(handles.fm2map,sat);
handles.fm2F = F;
guidata(hObject,handles);

global fm2F_axes
str = sprintf('F (s): %f', time);
set(handles.fm2Ftime_text, 'String', str);

axes(fm2F_axes);
cla;
imagesc(F);
colormap gray(256);
freezeColors;
title('Velocities Map')
axis xy;
axis image;
axis off;