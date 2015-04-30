         global fm2map_axes
         global fm2F_axes
         global fm2T_axes
         global fm2vels_axes
       

             
    correct_file = 0;        
    while correct_file == 0
             
      
        [filename, pathname, type] = uigetfile( ...
           {'*.bmp;*.png', 'Monochrome images (*.bmp, *.png)';
            '*.mat', 'FM2 Matlab Workspaces (*.mat)';
            '*.mat', 'Initial environment representation (*.mat)'}, ...
            'Pick a map or a previously saved workspace');
     if filename ~= 0 % File selected.
            correct_file = 0;
        
        if type == 1 % Image    
            map = imread([pathname filename]);
            if  ~ismatrix(map)
                h = errordlg('Not a valid map file. It should be a monochrome image (bmp or png).', ...
                    'Map loading error', 'modal');
            waitfor(h);
                correct_file = 0;
            else % Image map loaded correctly
                correct_file = 1;
                
                str = sprintf('Map size (px): [%d x %d]',size(map,1), size(map,2));
                set(handles.fm2mapsize_text, 'String', str);

                map = flipdim(map, 1); %"invierte la matriz"
                handles.fm2map = map;% "guarda el mapa
                guidata(hObject,handles);

                sat = str2double(get(handles.fm2sat_box, 'String'));
                fm2updateF;
                axes(fm2map_axes);
           
                cla;
                imagesc(map);
                colormap gray(256);
                title ('Obstacles Map');
                axis xy;
                axis image;
                axis off;
          
                fm2updateF;

                set(handles.hint_text1, 'String', 'Adjust the saturation value and select start & goal points by clicking the Start & Goal button.');
                set(handles.fm2start_text, 'String', 'Start: ');
                set(handles.fm2goal_text, 'String', 'Goal: ');
                set(handles.fm2run_pushbutton, 'Enable', 'Off'); % For security.
                
                axes(fm2T_axes);
                cla;
                axes(fm2vels_axes);
                cla;
            end

        elseif type == 2 % Workspace
            workspace = load([pathname filename]);

             % Workspace loaded correctly
            if isfield(workspace,'fm2map') && isfield(workspace,'fm2sat')...
            && isfield(workspace,'fm2F') && isfield(workspace,'fm2T') ...
            && isfield(workspace,'fm2path') && isfield(workspace,'fm2vels')...
            && isfield(workspace,'fm2times') ...
            && isfield(workspace,'fm2start_point') && isfield(workspace,'fm2goal_point')
        
                correct_file = 1;
                handles.fm2map = workspace.fm2map;
                handles.fm2F = workspace.fm2F;
                handles.fm2T = workspace.fm2T;
                handles.fm2path =  workspace.fm2path;
                handles.fm2vels =  workspace.fm2vels;
                handles.fm2times =  workspace.fm2times;
                handles.fm2sat =  workspace.fm2sat;
                handles.fm2start_point =  workspace.fm2start_point;
                handles.fm2goal_point =  workspace.fm2goal_point;
                guidata(hObject,handles);
                clear workspace;
                
                set(handles.fm2run_pushbutton, 'Enable', 'On');
                set(handles.fm2save_popupmenu, 'Enable', 'On');
                set(handles.fm2save_pushbutton, 'Enable', 'On');

                set(handles.fm2sat_box, 'String', handles.fm2sat);
                set(handles.fm2sat_slider, 'Value', handles.fm2sat);
                
                str = sprintf('Start: [%d, %d]',handles.fm2start_point(1),handles.fm2start_point(2));
                set(handles.fm2start_text, 'String', str);

                str = sprintf('Goal: [%d, %d]',handles.fm2goal_point(1),handles.fm2goal_point(2));
                set(handles.fm2goal_text, 'String', str);

                str = sprintf('Map size (px): [%d x %d]',size(handles.fm2map,1), size(handles.fm2map,2));
                set(handles.fm2mapsize_text, 'String', str);

                str = sprintf('F (s): %f', handles.fm2times(1));
                set(handles.fm2Ftime_text, 'String', str);

                str = sprintf('T (s): %f', handles.fm2times(2));
                set(handles.fm2Ttime_text, 'String', str);
                
                set(handles.fm2run_pushbutton, 'Enable', 'On');

                axes(fm2map_axes);
                cla;
                imagesc(handles.fm2map);
                colormap gray(256);
                freezeColors;
                title('Obstacles Map')
                axis xy;
                axis image;
                axis off;
                hold on;
                plot(handles.fm2start_point(1),handles.fm2start_point(2),'rx','MarkerSize', 15);
                plot(handles.fm2goal_point(1),handles.fm2goal_point(2),'k*','MarkerSize', 15);
                plot(handles.fm2path(1,:), handles.fm2path(2,:), 'b-', 'LineWidth', 5);

                axes(fm2F_axes);
                cla;
                imagesc(handles.fm2F);
                colormap gray(256);
                freezeColors;
                title('Velocities Map');
                axis xy;
                axis image;
                axis off;
                hold on;

                axes(fm2T_axes);
                cla;
                set(handles.figure1, 'Colormap',...
                [0 0 0;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 0.9375;0.125 1 0.875;0.1875 1 0.8125;0.25 1 0.75;0.3125 1 0.6875;0.375 1 0.625;0.4375 1 0.5625;0.5 1 0.5;0.5625 1 0.4375;0.625 1 0.375;0.6875 1 0.3125;0.75 1 0.25;0.8125 1 0.1875;0.875 1 0.125;0.9375 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0;1 1 1]);
                imagesc(handles.fm2T);
                freezeColors;
                title('Map of Times-of-arrival');
                axis xy;
                axis image;
                axis off;

                axes(fm2vels_axes);
                cla;
                plot(handles.fm2vels(2,:), handles.fm2vels(1,:), 'b-', 'LineWidth', 2);
                hold on;
                plot(handles.fm2vels(2,1), handles.fm2vels(1,1), 'rx', 'MarkerSize', 15);
                plot(handles.fm2vels(2,end), handles.fm2vels(1,end), 'k*', 'MarkerSize', 15);
                ylim([0 1.05]);
                hold off;
                title('Result')
                
            else
                 h = errordlg('Not a valid workspace file. It should has all the FM2 variables.','Map loading error','modal');   
                  % ,'modal');%%'Map loading error', 'error', 'modal'
                correct_file = 0;
                waitfor(h);
            end
            
        elseif type == 3 % New map create
           workspace = load([pathname filename]);
           if isfield(workspace,'drawnewmap') 
               handles.fm2map = workspace.drawnewmap;
               map = handles.fm2map;
              
               correct_file = 1;
               
               str = sprintf('Map size (px): [%d x %d]',size(map,1), size(map,2));
               set(handles.fm2mapsize_text, 'String', str);

               map = flipdim(map, 1); 
               handles.fm2map = map; 
               guidata(hObject,handles);
               sat = str2double(get(handles.fm2sat_box, 'String'));
               fm2updateF;

               axes(fm2map_axes);
               cla;
               imagesc(map);
               colormap gray(256);
               title('Obstacles Map');
               axis xy;
               axis image;
               axis off;
                
               fm2updateF;

               set(handles.hint_text1, 'String', 'Adjust the saturation value and select start & goal points by clicking the Start & Goal button.');
               set(handles.fm2start_text, 'String', 'Start: ');
               set(handles.fm2goal_text, 'String', 'Goal: ');
               set(handles.fm2run_pushbutton, 'Enable', 'Off'); % For security.
                
               axes(fm2T_axes);
               cla;
               axes(fm2vels_axes);
               cla;
           else
                h = errordlg('Not a valid workspace file. It should has all the FM2 variables.','Map loading error','modal');   
                  % ,'modal');%%'Map loading error', 'error', 'modal'
                correct_file = 0;
                waitfor(h);
               
           end
            
        end
        
      else 
          correct_file = 1; 
      end
    end

    % Updating GUI.
    set(handles.fm2sat_slider, 'Enable', 'On');
    set(handles.fm2sat_box, 'Enable', 'On');
    set(handles.fm2sg_pushbutton, 'Enable', 'On');
  
