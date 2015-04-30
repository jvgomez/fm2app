[F, time] = FM2_VelocitiesMap(handles.fmlmap,sat);

%handles.fmlF = F;
guidata(hObject,handles);

global fmLF_axes

str = sprintf('F (s): %f', time);
set(handles.fmlFtime_text, 'String', str);

axes(fmLF_axes);
cla;
imagesc(F);
colormap gray(256);
freezeColors;
axis xy;
axis image;
title('Velocities Map');
axis off;

guidata(hObject,handles);  %añadido aparte
