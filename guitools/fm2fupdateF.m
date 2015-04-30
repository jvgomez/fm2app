[W, time] = FM2_VelocitiesMap(handles.fm2fmap,sat);


handles.fm2fF = W;
guidata(hObject,handles);

global fm2fanim_axes

axes(fm2fanim_axes);
cla;
imagesc(W);
colormap gray(256);
freezeColors;
title('Velocities Map')
axis xy;
axis image;
axis off;