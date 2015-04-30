function [points,count]= kinesthetic_teaching (M, dataset)

global fmLmap_axes
global fmLres_axes

points = [];
button = 1;
count = 1;

s = warndlg('Introduce points of the trajectory by clicking on the map.To finish, press any other button than primary click.','Help','modal');
uiwait(s);
        

hold on;
axes (fmLmap_axes);
imagesc(M'); 
axis image;
axis off;
colormap gray(256);
axis xy;
title('Obstacles Map');

axes(fmLres_axes)
imagesc(M')
if  ~numel(dataset)==0
 plot(dataset(1,:), dataset(2,:),'.b');
end
axis image;
axis off;
colormap gray(256);
axis xy;
title('Trajectory Map');

fx = size(M,1); % tamaño x del mapa
fy = size(M,2); % tamaño y del mapa

while button == 1
    [x, y, button] = ginput(1);
    figure(FM2app2);
    x = round(x);
    y = round(y);
    if button == 1 
        if x > 0 && y > 0 && x < fx && y < fy && M(x,y)~=0 % no hay obstaculo y esta en el rango
            ph = 1; % punto valido
            points(:,count) = [x; y];          
            count = count + 1;
            if count > 2 
             if points(:,count-1) == points(:,count-2) % dos puntos iguales Avoid to save two equal points in the same demo.
              points(:,count-1) = []; 
              count = count - 1;
              ph = 0;
             end
            end
        
        elseif x < 0 || y < 0 || x > fx || y > fy  % Restriccion en caso de que este fuera del mapa
            l = errordlg('Point out of map bounds, please select another point.',...
        'Start point selection error','modal');
            uiwait(l);            
            ph = 0; % punto no valido
        elseif  M(x,y) == 0 % Punto en el obstaculo.
            l = errordlg('Point in an obstacle, please select another point.',...
        'Start point selection error','modal');
            uiwait(l);            
            ph = 0;
       end
    end   
    if ph == 0 % no se puede dibujar    
     axes(fmLmap_axes); 
     hold on;            
     axes(fmLres_axes); 
     hold on;  
    elseif ph == 1 % se puede dibujar
     axes(fmLmap_axes); 
     hold on;            
     plot(x,y,'.r');      
            
     axes(fmLres_axes); 
     hold on; 
     plot(x,y,'.r');     
   end
end
