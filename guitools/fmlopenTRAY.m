
    correct_file = 0;
    
    while correct_file == 0
        
        
        [filename, pathname, type] = uigetfile( ...
           {'*.mat', 'FML Matlab Trajectory (*.mat)';}, ...
            'Pick a map or a previously saved workspace');
      if filename ~= 0 % File selected.
            correct_file = 0; 
            % Workspace
            workspace = load([pathname filename]);
            
             % Workspace loaded correctly
            if isfield(workspace,'trajectory') && isfield(workspace,'count') && isfield(workspace,'demos')
                
                correct_file = 1;
                handles.trajectoryl = workspace.trajectory; % Almacena los puntos de cada demostracion
                handles.cuental = workspace.count; % numero de puntos en cada demostracion 
                handles.demosl = workspace.demos; % numero de demostraciones
                
                
                guidata(hObject,handles);
                clear workspace;
            else
                h = errordlg('Not a valid workspace file. It should has all the FM2 variables.','Map loading error','modal');
           
                correct_file = 0;
                waitfor(h);
            end
      
      else
          correct_file = 1;
      end
    end
    
    