        global fmLmap_axes;
        global fmLF_axes;
        global fmLres_axes;

        axes(fmLres_axes);
        cla;
        
    correct_file = 0;
    
    while correct_file == 0
        
        
        [filename, pathname, type] = uigetfile( ...
           {'*.bmp;*.png', 'Monochrome images (*.bmp, *.png)';
            '*.mat', 'FML Matlab Workspaces (*.mat)';
            '*.mat', 'Initial environment representation (*.mat)'}, ...
            'Pick a map or a previously saved workspace');
      if filename ~= 0 % File selected.
            correct_file = 0;
        
        if type == 1 % Image    
            mapname= imread([pathname filename]);
            if  ~ismatrix(mapname)
                h = errordlg('Not a valid map file. It should be a monochrome image (bmp or png).', ...
                    'Map loading error', 'error', 'modal');
                correct_file = 0;
                waitfor(h);
            else % Image map loaded correctly
                correct_file = 1;
                
                str = sprintf('Map size (px): [%d x %d]',size(mapname,1), size(mapname,2));
                set(handles.fmlmapsize_text, 'String', str);
                
                handles.aosizeX = size(mapname,2); %se utilizan para posteriormente calcular el aosize
                handles.aosizeY = size(mapname,1); %se utilizan para posteriormente calcular el aosize
                
                mapname = ~flipdim(mapname,1); %"invierte la matriz"
                handles.fmlmap = mapname;
                guidata(hObject,handles);
                
                sat = str2double(get(handles.fmlsat_box, 'String'));
                
                fmLupdateF;
                
                axes(fmLmap_axes);
                cla;
                imagesc(mapname);
                colormap gray(256);
                axis xy;
                axis image;
                axis off;
                title('Obstacles Map');
                
                set(handles.fm2sg_pushbutton, 'Enable', 'Off'); % For security.
                
                
                
            end
            
        elseif type == 2
            
            % Workspace
            workspace = load([pathname filename]);
            
             % Workspace loaded correctly
            if isfield(workspace,'fmlmap') && isfield(workspace,'fmlf') && isfield(workspace,'fmlsat')...
                    && isfield(workspace,'n') && isfield(workspace,'aoi') && isfield(workspace,'demos')
               
                correct_file = 1;
                handles.fmlmap = workspace.fmlmap;
                handles.fmlF = workspace.fmlf;
                handles.fmlsat =  workspace.fmlsat;
                handles.n = workspace.n;
                handles.aoi = workspace.aoi;
                handles.demos = workspace.demos;
                
                
                guidata(hObject,handles);
                clear workspace;
                
                [F, T, end_point, dx, dy] = FML(handles.fmlmap, handles.demos, handles.fmlsat, handles.aoi);
                % Updating gui
                handles.fmlT = T;
                handles.fmlF = F;
                guidata(hObject,handles);

                axes(fmLF_axes);
                cla;
                imagesc(F');
                colormap gray(256);
                axis xy;
                axis off;
                axis image;
                title('Velocities Map');
                axis off;


                % Getting some reproductions from the initial poitns of the demos.
                for i = 1:handles.n
                    start_point = handles.demos{i}(:,1);
                    start_point_r = round(start_point);
                    path = compute_geodesic(handles.fmlT, start_point_r);
                    starts(:, i) = start_point;
                    paths{i} = path;
                end

                % Plotting results.
                axes(fmLmap_axes)
                cla;
                imagesc(handles.fmlmap);
                colormap gray(256);
                hold on;
                axis xy;
                axis off;
                title('Result Map');

                box on;
                h = streamslice(-dx,-dy); % Reproductions field with stream lines.
                set(h,'color','b');

                for i = 1:length(paths)  
                    ff = plot(paths{i}(1,:),paths{i}(2,:),'b','LineWidth',3);
                    f = plot(starts(1,i),starts(2,i),'k.','markersize',30);
                end

                for i = 1:handles.n 
                    g = scatter(handles.demos{i}(1,:),handles.demos{i}(2,:),'.r');
                end

                plot(end_point(1),end_point(2),'k*','markersize',15,'linewidth',3);

                set(gca,'xtick',[], 'ytick',[]);
                hold off;
                axis image;

                guidata(hObject,handles);

    
                set(handles.fmlsg_pushbutton, 'Enable', 'On');
       

                set(handles.fmlsat_box, 'String', handles.fmlsat);
                set(handles.fmlsat_slider, 'Value', handles.fmlsat);
               

                str = sprintf('Map size (px): [%d x %d]',size(handles.fmlmap,1), size(handles.fmlmap,2));
                set(handles.fmlmapsize_text, 'String', str);
                
        
                
              
            else
                h = errordlg('Not a valid workspace file. It should has all the FM2 variables.','Map loading error','modal');
                 
                correct_file = 0;
                waitfor(h);
            end
                
         elseif type == 3 % New map create
           workspace = load([pathname filename]);
           
           if isfield(workspace,'drawnewmap') 
               handles.fmlmap = workspace.drawnewmap;
               
             
               map = handles.fmlmap;
              
               correct_file = 1;
               
               str = sprintf('Map size (px): [%d x %d]',size(map,1), size(map,2));
               set(handles.fmlmapsize_text, 'String', str);

               map = flipdim(map, 1); %"invierte la matriz"
               handles.fmlmap = map;% "guarda el mapa
               
               guidata(hObject,handles);
               sat = str2double(get(handles.fmlsat_box, 'String'));
               fmLupdateF;

               axes(fmLmap_axes);
               cla;
               imagesc(map);
               colormap gray(256);
               axis xy;
               axis image;
               axis off;
               title('Obstacles Map'); 
               
               fmLupdateF;

               set(handles.fm2sg_pushbutton, 'Enable', 'Off'); % For security.
                
               
           else
                h = errordlg('Not a valid workspace file. It should has all the FM2 variables.','Map loading error','modal');   
                
                correct_file = 0;
                waitfor(h);
           end
        end
      else
          correct_file = 1;
     end
    end  
    % Updating GUI.
    set(handles.fmlsat_slider, 'Enable', 'Off');
    set(handles.fmlsat_box, 'Enable', 'Off');
    set(handles.fmlsg_pushbutton, 'Enable', 'Off');
    set(handles.fmldemo_edit, 'Enable', 'On');
    set(handles.fmlaoi_slider, 'Enable', 'Off');
    set(handles.fmlaoi_box, 'Enable', 'Off');
    set(handles.fmrecalculate_pushbutton, 'Enable','Off');
                
                
                
                
                
                
                
                
                