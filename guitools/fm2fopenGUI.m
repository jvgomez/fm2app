        
        global fm2fanim_axes;
        global fm2fmap_axes;
        global fm2fveloc_axes
        global fm2fdist_axes
        

    correct_file = 0;
    
    while correct_file == 0
        
        
        [filename, pathname, type] = uigetfile( ...
           {'*.bmp;*.png', 'Monochrome images (*.bmp, *.png)';
            '*.mat', 'FM2F Matlab Workspaces (*.mat)';
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
                set(handles.fm2fmapsize_text, 'String', str);
                
                Wo = ~flipdim(mapname,1); 
                SE = strel('disk', 10); 
                Wo = ~imdilate(~Wo, SE);

                %Black borders.
                Wo(1,:) = 0;
                Wo(end,:) = 0;
                Wo(:,1) = 0;
                Wo(:,end) = 0;
                
                axes(fm2fmap_axes)
                cla;
                imagesc(Wo);
                colormap gray(256);
                axis xy;
                axis image;
                axis off;
                title('Formations Map');
                
                sat = 1;
                [W,time] = FM2_VelocitiesMap(Wo,sat);
                  
                handles.fm2fsat = W;
                
                handles.fm2fmap = Wo;
                guidata(hObject,handles);
                
                sat = str2double(get(handles.fm2fsat_box, 'String'));
                
                axes(fm2fanim_axes);
                cla;
                imagesc(W);
                colormap gray(256);
                axis xy;
                axis image;
                axis off;
                title('Velocities Map');
                
                
                set(handles.fm2frun_pushbutton, 'Enable', 'Off'); % For security.
                
                
                
            end
            
        elseif type == 2 % Workspace
            workspace = load([pathname filename]);
            
             %Workspace loaded correctly
            if isfield(workspace,'fm2fsat') && isfield(workspace,'fm2fmap') && isfield(workspace,'dist_foll1') && isfield(workspace,'dist_foll2') && isfield(workspace,'Bleader')... 
               && isfield(workspace,'fm2funcertainty') && isfield(workspace,'fm2fsteps') && isfield(workspace,'fm2fdist') && isfield(workspace,'fm2fGanim') && isfield(workspace,'fm2fFanim')...
               && isfield(workspace,'Bfoll1') && isfield(workspace,'Bfoll2') && isfield(workspace,'jj')
           
           
                correct_file = 1;
                handles.fm2fsat = workspace.fm2fsat;
                handles.fm2fmap = workspace.fm2fmap;
                handles.dist_foll1 = workspace.dist_foll1;
                dist_foll1 = handles.dist_foll1;
                handles.dist_foll2 = workspace.dist_foll2;
                dist_foll2 = handles.dist_foll2;
                handles.Bleader = workspace.Bleader;
                Bleader = handles.Bleader; 
                handles.Bfoll1 = workspace.Bfoll1;
                Bfoll1 = handles.Bfoll1;
                handles.Bfoll2 = workspace.Bfoll2;
                Bfoll2 = handles.Bfoll2;
                handles.fm2funcertainty = workspace.fm2funcertainty;
                handles.fm2fsteps = workspace.fm2fsteps;
                handles.fm2fdist = workspace.fm2fdist;
                handles.fm2fGanim = workspace.fm2fGanim;
                handles.fm2fFanim = workspace.fm2fFanim;
                handles.jj = workspace.jj;
                
                
                guidata(hObject,handles);
                clear workspace;

                str = sprintf('Map size (px): [%d x %d]',size(handles.fm2fmap,1), size(handles.fm2fmap,2));
                set(handles.fm2fmapsize_text, 'String', str);
                
                

                axes(fm2fmap_axes);
                cla;
                imagesc(handles.fm2fmap);
                colormap gray(256);
                axis xy;
                axis image;
                axis off;
                hold on;
                title('Formations Map');
                
                axes(fm2fanim_axes);
                cla;
                imagesc(handles.fm2fsat);
                colormap gray(256);
                axis xy;
                axis image;
                axis off;
                hold on;
                title('Velocities Map');
                
                axes(fm2fveloc_axes); 
                cla;
                
                
                m = min(min(min(Bleader),min(Bfoll1)),min(Bfoll2));
                M = max(max(max(Bleader),max(Bfoll1)),max(Bfoll2));
                axis on;
                axis([1 handles.jj-1 m-0.1, M+0.1]); %0.1

                hold on;


                time=1:length(Bleader);
                plot(time,Bleader,'k');
                plot(time,Bfoll1,'--b');
                plot(time,Bfoll2,':r');
                xlabel('Iteration');
                ylabel('Speed (m/s)');
                legend('Leader', 'Follower 1', 'Follower 2');
                
                axes(fm2fdist_axes);
                cla
            
                s = min(min(dist_foll1),min(dist_foll2));
                S = max(max(dist_foll1),max(dist_foll2));


                axis on;
                axis([1 handles.jj-1 s-1, S+1]); %1

                hold on;

                plot(time,dist_foll1,'--b');
                plot(time,dist_foll2,':r');
                legend('Follower 1' , 'Follower 2');
                xlabel('Iteration');
                ylabel('% Perp_direct');

            else
                h = errordlg('Not a valid workspace file. It should has all the FM2 variables.','Map loading error','modal');
                 % ,'modal');%%'Map loading error', 'error', 'modal'
                correct_file = 0;
                waitfor(h);
            end
                
         elseif type == 3 % New map create
           workspace = load([pathname filename]);
           
           if isfield(workspace,'drawnewmap') 
               handles.fm2fmap = workspace.drawnewmap;
               
             
               map = handles.fm2fmap;
              
               correct_file = 1;
               
                
                str = sprintf('Map size (px): [%d x %d]',size(map,1), size(map,2));
                set(handles.fm2fmapsize_text, 'String', str);
                
                Wo = (map); %"invierte la matriz"
                SE = strel('disk', 10); % Obstacles dilation.
                Wo = ~imdilate(~Wo, SE);

                %Black borders.
                Wo(1,:) = 0;
                Wo(end,:) = 0;
                Wo(:,1) = 0;
                Wo(:,end) = 0;
                
                axes(fm2fmap_axes)
                cla;
                imagesc(Wo);
                colormap gray(256);
                axis xy;
                axis image;
                axis off;
                title('Formations Map');
                
                sat = 1;
                [W,time] = FM2_VelocitiesMap(Wo,sat);
                  
                handles.fm2fsat = W;
                
                handles.fm2fmap = Wo;% "guarda el mapa
                guidata(hObject,handles);
                
                sat = str2double(get(handles.fm2fsat_box, 'String'));
                
                axes(fm2fanim_axes);
                cla;
                imagesc(W);
                colormap gray(256);
                axis xy;
                axis image;
                axis off;
                title('Velocities Map');
                
                
                
                set(handles.fm2frun_pushbutton, 'Enable', 'Off'); % For security.

               
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
    set(handles.fm2frun_pushbutton, 'Enable', 'On');
    set(handles.fm2fsat_slider, 'Enable', 'On');
    set(handles.fm2fsat_box, 'Enable', 'On');
    set(handles.fm2funcertainty_slider, 'Enable', 'On');
    set(handles.fm2funcertainty_box, 'Enable', 'On');
    set(handles.fm2fsteps_slider, 'Enable', 'On');
    set(handles.fm2fsteps_box, 'Enable', 'On');
    set(handles.fm2fdist_slider, 'Enable', 'On');
    set(handles.fm2fdist_box, 'Enable', 'On');
    
    
    
    
    
    

