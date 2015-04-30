
        
         global drawnewmap_axes 

    correct_file = 0;
    while correct_file == 0
        
  
        [filename, pathname, type] = uigetfile( ...
           {'*.bmp;*.png', 'Monochrome images (*.bmp, *.png)';
            '*.mat', 'Initial environment representation (*.mat)'}, ...
            'Pick a map or a previously saved workspace');
      if filename ~= 0 % File selected.
            
        
        if type == 1 % Image    
            map = imread([pathname filename]);
            if  ~ismatrix(map)
                h = errordlg('Not a valid map file. It should be a monochrome image (bmp or png).', ...
                    'Map loading error', 'modal');
                correct_file = 0;
                handles.marcaload = 0;
                waitfor(h);
                
            else % Image map loaded correctly
                correct_file = 1;
                map= ~flipdim(map,1);
         
                handles.drawnewmap = map; % "guarda el mapa cargado
                handles.fmdrawWidth = size (handles.drawnewmap,2); %x
                handles.fmdrawHeight = size (handles.drawnewmap,1); %y
                

                axes(drawnewmap_axes);
                cla;
                imagesc(map);
                colormap gray(256);
                axis xy;
                axis off;
                
                handles.marcaload = 1;
                set(handles.fmdrawWidth_edit, 'Enable', 'Off');
                set(handles.fmdrawHeight_edit, 'Enable', 'Off');
                set(handles.drawsaves_pushbutton,'Enable','On');
                set(handles.Delete_pushbutton, 'Enable', 'On');
                set(handles.showaxes_togglebutton, 'Enable', 'On');
                set (handles.clearnew_pushbutton,'Enable','On');
                set(handles.fmdraw_pushbutton,'Enable','On');
                
                set(handles.User_text, 'String', 'Add Obstacle or choose other');
                 % Choose default command line output for draw
               handles.output = hObject;

               % Update handles structure
               guidata(hObject, handles);
               
               
              
            end
            
        elseif type == 2 % New map create
           workspace = load([pathname filename]);
           if isfield(workspace,'drawnewmap') 
               handles.drawnewmap = workspace.drawnewmap;
      
               correct_file = 1;
               
               
               handles.fmdrawWidth = size (handles.drawnewmap,2);
               handles.fmdrawHeight = size (handles.drawnewmap,1);
               
               axes(drawnewmap_axes);
               cla;
               imagesc(handles.drawnewmap);
               colormap gray(256);
               axis image;
               axis off;
               
               handles.marcaload = 1;
               set(handles.fmdrawWidth_edit, 'Enable', 'Off');
               set(handles.fmdrawHeight_edit, 'Enable', 'Off');
               set(handles.drawsaves_pushbutton,'Enable','On');
               set(handles.Delete_pushbutton, 'Enable', 'On');
               set(handles.showaxes_togglebutton, 'Enable', 'On');
               set(handles.clearnew_pushbutton,'Enable','On');
               set(handles.fmdraw_pushbutton,'Enable','On');
                
               set(handles.User_text, 'String', 'Add Obstacle or choose other');
               % Choose default command line output for draw
               handles.output = hObject;

               % Update handles structure
               guidata(hObject, handles);
               
               
           
           else
                h = errordlg('Not a valid workspace file. It should has all the FM2 variables.','Map loading error','modal');   
                  % ,'modal');%%'Map loading error', 'error', 'modal'
                correct_file = 0;
                handles.marcaload = 0;
                waitfor (h);
               
           end
            
        end
      else
          correct_file = 1;
      end
    end
    
    
