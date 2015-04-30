function varargout = FM2app(varargin)
% FM2APP MATLAB code for FM2app.fig
%      FM2APP, by itself, creates a new FM2APP or raises the existing
%      singleton*.
%
%      H = FM2APP returns the handle to a new FM2APP or the handle to
%      the existing singleton*.
%
%      FM2APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FM2APP.M with the given input arguments.
%
%      FM2APP('Property','Value',...) creates a new FM2APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FM2app_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FM2app_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FM2app

% Last Modified by GUIDE v2.5 20-Sep-2014 16:58:33

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Common part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FM2app_OpeningFcn, ...
                   'gui_OutputFcn',  @FM2app_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FM2app is made visible.
function FM2app_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FM2app (see VARARGIN)
handles.cuenta = 0;
handles.trayectory = 0; %trayectoria que se guarga
handles.trayectoryl = 0; %trayectoria cargada
handles.cuental = 0;  
handles.demosl = 0;


% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FM2app wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Setting initial values.
if isempty(regexp(path,['algorithms' pathsep], 'once'))
    addpath([pwd, '/algorithms']);    % path algorithms
end

if isempty(regexp(path,['fm2tools' pathsep], 'once'))
    addpath([pwd, '/fm2tools']);    % tool scripts
end

%% Descomentar esto o quitar los if.
if isempty(regexp(path,['guitools' pathsep], 'once'))
    addpath([pwd, '/guitools']);    % tool scripts
end

if isempty(regexp(path,['thirdparty' pathsep], 'once'))
    addpath([pwd, '/thirdparty']);    % tool scripts
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


set(handles.fml_uipanel, 'Visible', 'Off');
set(handles.fm2_uipanel, 'Visible', 'Off');
set(handles.fm2f_uipanel,'Visible','Off');






% --- Outputs from this function are returned to the command line.
function varargout = FM2app_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Topbar Menu Callbacks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------------------------------------------------------
function algorithms_menu_Callback(hObject, eventdata, handles)
% hObject    handle to algorithms_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fm2_menu_Callback(hObject, eventdata, handles)
% hObject    handle to fm2_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.fm2_uipanel, 'Visible', 'On');
set(handles.fml_uipanel, 'Visible', 'Off');
set(handles.fm2f_uipanel,'Visible','Off');


% --------------------------------------------------------------------
function fml_menu_Callback(hObject, eventdata, handles)
% hObject    handle to fml_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.fml_uipanel, 'Visible', 'On');
set(handles.fm2_uipanel,'Visible','Off');
set(handles.fm2f_uipanel,'Visible','Off');

% --------------------------------------------------------------------
function fm2f_menu_Callback(hObject, eventdata, handles)
% hObject    handle to fm2f_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.fml_uipanel, 'Visible', 'Off');
set(handles.fm2_uipanel,'Visible','Off');
set(handles.fm2f_uipanel,'Visible','On');



% --------------------------------------------------------------------
function about_menu_Callback(hObject, eventdata, handles)
% hObject    handle to about_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str = sprintf('FM2app - Fast Marching Square\nVersion: 1.0 - 05/10/2014\n\nAuthor: Javier V. Gómez\njvgomez@ing.uc3m.es\nwww.javiervgomez.com\nhttp://roboticslab.uc3m.es/\nCarlos III University of Madrid \nand \nDavid Palomo Perez\n100276596@alumnos.uc3m.es\nCarlos III University of Madrid');
msgbox(str,'About FM2app', 'help');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fast Marching Square GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function fm2sat_box_Callback(hObject, eventdata, handles)
% hObject    handle to fm2sat_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fm2sat_box as text
%        str2double(get(hObject,'String')) returns contents of fm2sat_box as a double



sat = str2double(get(hObject, 'String'));
sat = checkLimits(sat,0,1, 'saturation');

handles.fm2sat = sat;
guidata(hObject,handles);

set(hObject, 'String', sat);
set(handles.fm2sat_slider, 'Value', sat);

fm2updateF; %se actualiza el mapa al valor nuevo.


% --- Executes during object creation, after setting all properties.
function fm2sat_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2sat_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'Value', 1);
set(hObject,'String', 1);

handles.fm2sat = 1;
guidata(hObject,handles);

% --- Executes on slider movement.
function fm2sat_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fm2sat_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


sat = get(hObject, 'Value'); % IMPROVE: there should be a better way to round to 2 decimals.
sat = str2double(sprintf('%.2f', sat)); % To only show 2 decimals.; 
set(handles.fm2sat_box, 'String', sat);

handles.fm2sat = sat;
guidata(hObject,handles);

fm2updateF;


% --- Executes during object creation, after setting all properties.
function fm2sat_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2sat_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'Value', 1);


% --- Executes on button press in fm2loaddata_pushbutton.
function fm2loaddata_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2loaddata_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.fm2start_text, 'String', 'Start: '); 
set(handles.fm2goal_text, 'String', 'Goal: ');
FM2app2;
fm2openGUI;
set(handles.hint_text1, 'String', 'Click over the environment map to select the FM2 start and goal points.');

% --- Executes on button press in fm2sg_pushbutton.
function fm2sg_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2sg_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fm2map_axes

 % Start point
point_ok = 0;
while point_ok == 0
    figure(FM2app2);
    axes(fm2map_axes);
    [x,y] = ginput(1);
    y = round(y);
    x = round(x);       
    point_ok = 1;
    
    if y < 0 || y > size(handles.fm2map,1) || x < 0 || x > size(handles.fm2map,2)
        h = warndlg('Point out of map bounds, please select another point.',...
        'Start point selection error','modal');
        uiwait(h); % Prevents to run ginputax by clicking the OK button.
        point_ok = 0;
    elseif handles.fm2map(y,x) == 0
         h = warndlg('Point in an obstacle, please select another point.',...
        'Start point selection error','modal');
        uiwait(h);  % Prevents to run ginputax by clicking the OK button.
        point_ok = 0;
    end
end

handles.fm2start_point = [x; y];
str = sprintf('Start: [%d, %d]',x,y);
set(handles.fm2start_text, 'String', str);



axes(fm2map_axes);
cla;
imagesc(handles.fm2map);
colormap gray(256);
axis xy;
axis image;
axis off;
hold on;
title('Obstacles Map');
plot(x,y,'rx','MarkerSize', 15);
point_ok = 0;
while point_ok == 0
    figure(FM2app2);
    axes(fm2map_axes);
    [x,y] = ginput(1);
    y = round(y);
    x = round(x);       
    point_ok = 1;
    if y < 0 || y > size(handles.fm2map,1) || x < 0 || x > size(handles.fm2map,2)
        h = warndlg('Point out of map bounds, please select another point.',...
        'Start point selection error','modal');
        uiwait(h); % Prevents to run ginputax by clicking the OK button.
        point_ok = 0;
    elseif handles.fm2map(y,x) == 0
         h = warndlg('Point in an obstacle, please select another point.',...
        'Start point selection error','modal');
        uiwait(h);  % Prevents to run ginputax by clicking the OK button.
        point_ok = 0;
    end
end


handles.fm2goal_point = [x; y];
str = sprintf('Goal: [%d, %d]',x,y);
set(handles.fm2goal_text, 'String', str);

axes(fm2map_axes);
plot(x,y,'k*','MarkerSize', 15);
hold on;
title('Obstacles Map');
hold off;

guidata(hObject,handles);  

set(handles.fm2run_pushbutton, 'Enable', 'On');

set(handles.hint_text1, 'String', 'Now click on Compute FM2! to run the Fast Marching Square algorithm.');


% --- Executes on button press in fm2run_pushbutton.
function fm2run_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2run_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% IMPROVEMENT : add option of additive drawing: if data not reloaded, select if
% the new FM2 run should detele the previous computed path.

global fm2F_axes
global fm2map_axes
global fm2vels_axes


sat = str2double(get(handles.fm2sat_box, 'String'));
map = handles.fm2map;
start = handles.fm2start_point;
goal = handles.fm2goal_point;

 % FM2 template. The velocities map F is recomputed just to show how the


[F, T, path, vels, times] = FM2(map, sat, start, goal);

 % Updating gui.
handles.fm2F = F;
handles.fm2path = path;
handles.fm2vels = vels;
handles.fm2times = times;
handles.fm2sat = sat;
guidata(hObject,handles);

figure(FM2app2); % activa la pantalla 2

str = sprintf('F (s): %f', times(1));
set(handles.fm2Ftime_text, 'String', str);

freezeColors(fm2F_axes);

fm2updateT;

axes(fm2map_axes);
colormap gray(256);
freezeColors;
hold on;
plot(path(1,:), path(2,:), 'b-', 'LineWidth', 5);
title('Obstacles Map');

axes(fm2vels_axes);
cla;
plot(vels(2,:), vels(1,:), 'b-', 'LineWidth', 2);
hold on;
plot(vels(2,1), vels(1,1), 'rx', 'MarkerSize', 15);
plot(vels(2,end), vels(1,end), 'k*', 'MarkerSize', 15);
ylim([0 1.05]);
title('Result');
hold off;



xlabel('Distance (m)')
ylabel('Speed (m/s)')


set(handles.hint_text1, 'String', 'You can see the results of the FM2 algorithm. Now use the Save button');

set(handles.fm2save_popupmenu, 'Enable', 'On');
set(handles.fm2save_pushbutton, 'Enable', 'On');


% --- Executes on selection change in fm2save_popupmenu.
function fm2save_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to fm2save_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fm2save_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fm2save_popupmenu


% --- Executes during object creation, after setting all properties.
function fm2save_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2save_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fm2save_pushbutton.
function fm2save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fm2map_axes
global fm2F_axes
global fm2T_axes
global fm2vels_axes


what_to_save = get(handles.fm2save_popupmenu,'Value');

switch what_to_save
    case 1
        fm2map = handles.fm2map;
        fm2sat = handles.fm2sat;
        fm2F = handles.fm2F;
        fm2T = handles.fm2T;
        fm2path = handles.fm2path;
        fm2vels = handles.fm2vels;
        fm2times = handles.fm2times;
        fm2start_point = handles.fm2start_point;
        fm2goal_point = handles.fm2goal_point;
        
        [filename, pathname] = uiputfile('output/fm2workspace.mat', 'Save FM2 workspace as');
        save([pathname filename], 'fm2map', 'fm2sat', 'fm2F', 'fm2T', 'fm2path', 'fm2vels', 'fm2times', 'fm2start_point', 'fm2goal_point');
        copyfile('guitools/README.txt', [pathname 'README.txt']);
        
    otherwise
        % TODO : include save as fig. Tried so hard already but unable to
        % get a satisfactory solution.
        [file, path, ~] = uiputfile({'*.eps','Encapsulated PostScript (*.eps)';'*.pdf','Portable Document Format (*.pdf)'}, 'Save figure as');
        
        if file ~= 0
            filetype = file(end-2:end);

            switch what_to_save
                case 2
                    axes_to_save = fm2map_axes;
                case 3
                    axes_to_save = fm2F_axes;
                case 4
                    axes_to_save = fm2T_axes;
                case 5
                    axes_to_save = fm2vels_axes;
                    
                    
            end
            
            % TODO : does not save properly the figures.
            %Runs the export_fig command with the path and file name, along with the
            %filetype
            export_fig(axes_to_save,[path,file],['-',filetype],'-painters');
            export_fig(axes_to_save,[path,file],['-',filetype],'-painters');
            
            %Message box
            msgbox({'Done!';'';...
            ['The file ',file,'.',filetype,' can be found in:'];path},...
            'Save Figure File','help','modal');

        elseif isempty(file) == 0
            msgbox('Not saved.','Save figure file','warn','modal');
        end
end


% --- Executes on button press in fm2new_pushbutton.
function fm2new_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2new_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
draw;

% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fast Marching Learning GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%nn%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in fmlloaddata_pushbutton.
function fmlloaddata_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fmlloaddata_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% set(handles.fm2start_text, 'String', 'Start: ');
set(handles.fmlgoal_text, 'String', 'Goal: ');
FM2app2;
fmlopenGUI;

set(handles.fmloadtrajectory_pushbutton, 'Enable', 'On'); %habilita la posibilidad de cargar una trayectoria
set(handles.hint_text2, 'String', 'Click Load Trajectory or introduce nºdemos.');


function fmldemo_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fmldemo_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmldemo_edit as text
%        str2double(get(hObject,'String')) returns contents of fmldemo_edit as a double
n = get(hObject, 'Value');
n = str2double(get(hObject,'String'));

set(handles.fmldemo_edit, 'String', n);

handles.fmln = n;%%  demos
guidata(hObject,handles);

set(handles.fmlsat_slider, 'Enable', 'On');
set(handles.fmlsat_box, 'Enable', 'On');
set(handles.fmlsg_pushbutton, 'Enable', 'On');
set(handles.fmlaoi_slider, 'Enable', 'On');
set(handles.fmlaoi_box, 'Enable', 'On');
set(handles.hint_text2, 'String', 'Click now Introduce Demos.');


% --- Executes during object creation, after setting all properties.
function fmldemo_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmldemo_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fmlsat_box_Callback(hObject, eventdata, handles)
% hObject    handle to fmlsat_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmlsat_box as text
%        str2double(get(hObject,'String')) returns contents of fmlsat_box as a double

sat = str2double(get(hObject, 'String'));
sat = checkLimits(sat,0.00,1, 'saturation');

handles.fmlsat = sat;


set(hObject, 'String', sat);
set(handles.fmlsat_slider, 'Value', sat);

fmLupdateF;
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function fmlsat_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmlsat_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'Value', 1);
set(hObject,'String', 1);

handles.fmlsat = 1;
guidata(hObject,handles);





% --- Executes during object creation, after setting all properties.
function fmlsat_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmlsat_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function fmlsat_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fmlsat_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


sat = get(hObject, 'Value'); % IMPROVE: there should be a better way to round to 2 decimals.
sat = str2double(sprintf('%.2f', sat)); % To only show 2 decimals.; 
set(handles.fmlsat_box, 'String', sat);

set(handles.fmlsat_slider,'Min',0.01)


handles.fmlsat = sat;


fmLupdateF;
guidata(hObject,handles);


% --- Executes on slider movement.
function fmlaoi_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fmlaoi_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

aoi = get(hObject, 'Value'); % IMPROVE: there should be a better way to round to 2 decimals.
aoi = str2double(sprintf('%d', round(aoi))); 
set(handles.fmlaoi_box, 'String', aoi);

x = size(handles.fmlmap,1);
y = size(handles.fmlmap,2);

if x > y % Se el AOI sera el min del tamaño del mapa dividido entre dos.
  Maxaoi = y/2;
elseif y > x 
  Maxaoi = x/2;
elseif x == y || y==x % Caso de que sea iguales
  Maxaoi = x/2;
end
Maxaoi = fix(Maxaoi);



set(handles.fmlaoi_slider,'Min',10)
set(handles.fmlaoi_slider, 'Max', Maxaoi);

handles.maxaoi = Maxaoi;
handles.fmlaoi = aoi;


guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function fmlaoi_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmlaoi_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function fmlaoi_box_Callback(hObject, eventdata, handles)
% hObject    handle to fmlaoi_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmlaoi_box as text
%        str2double(get(hObject,'String')) returns contents of fmlaoi_box as a double


aoi = str2double(get(hObject, 'String'));
aoi = checkLimits(aoi,10,handles.maxaoi, 'aoi');

handles.fmlaoi = aoi;


set(hObject, 'String', aoi);
set(handles.fmlaoi_slider, 'Value', aoi);

guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function fmlaoi_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmlaoi_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'Value', 10);
set(hObject,'String', 10);

handles.fmlaoi = 10;
guidata(hObject,handles);


% --- Executes on button press in fmlsg_pushbutton.
function fmlsg_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fmlsg_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fmLmap_axes
global fmLF_axes


n = handles.fmln; % numero de demostraciones
aoi_size = handles.fmlaoi; % valor de AOI
map = handles.fmlmap; 
sat = handles.fmlsat;

p =[];                                 
demos = cell(1,n);  
handles.demos = cell(1,n); 
handles.trajectory = cell(1,n); % Variable para almacenar trayectorias
handles.cuenta = cell(1,n) ; % Numero de puntos que conforman cada trayectoria


figure(FM2app2);

cla;

% Simulation of kinesthetic teaching.
for k=1:n 
    [dataset,cuenta] = kinesthetic_teaching (map', p);
    p = [p dataset]; % This line is just to help plotting previous points.
    cuenta = cuenta -1;
    handles.cuenta{k} = cuenta; % save trajectory
    demos{k} = dataset; 
    handles.demos{k} = dataset; %Se utiliza en el Recalculo del codigo
    handles.trajectory{k} = dataset; % almacena las trayectorias
    
end


figure(FM2app2);

% Executing the FML algorithm.

[F, T, end_point, dx, dy] = FML(map, demos, sat, aoi_size);
% Updating gui
handles.fmlT = T;
handles.fmlF = F;
handles.fmlsat = sat;
handles.fmlmap = map;

axes(fmLF_axes);
cla;
imagesc(F');
colormap gray(256);
axis xy;
axis image;
title('Velocities Map');
axis off;




guidata(hObject,handles);


% Getting some reproductions from the initial poitns of the demos.
for i = 1:n
    start_point = demos{i}(:,1);
    start_point_r = round(start_point);
    path = compute_geodesic(handles.fmlT, start_point_r);
    starts(:, i) = start_point;
    paths{i} = path;
end

% Plotting results.
axes(fmLmap_axes)
cla;
imagesc(map);
colormap gray(256);
hold on;
axis xy;
title('Result Map');

handles.fmlmap = map;

box on;
h = streamslice(-dx,-dy); % Reproductions field with stream lines.
set(h,'color','b');

for i = 1:length(paths)  
    ff = plot(paths{i}(1,:),paths{i}(2,:),'b','LineWidth',3);
    f = plot(starts(1,i),starts(2,i),'k.','markersize',30);
end

for i = 1:n 
    g = scatter(demos{i}(1,:),demos{i}(2,:),'.r');
end

plot(end_point(1),end_point(2),'k*','markersize',15,'linewidth',3);

set(gca,'xtick',[], 'ytick',[]);
hold off;
axis image;

guidata(hObject,handles);

set(handles.fmlsave_popupmenu, 'Enable', 'On');
set(handles.fmlsave_pushbutton, 'Enable', 'On');
set(handles.fmrecalculate_pushbutton, 'Enable', 'On');
set(handles.hint_text2, 'String', 'Click popupmenu,select axes and click Save.');


% --- Executes on selection change in fmlsave_popupmenu.
function fmlsave_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to fmlsave_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fmlsave_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fmlsave_popupmenu


% --- Executes during object creation, after setting all properties.
function fmlsave_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmlsave_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fmlsave_pushbutton.
function fmlsave_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fmlsave_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fmLmap_axes
global fmLF_axes
global fmLres_axes

what_to_save = get(handles.fmlsave_popupmenu,'Value'); 

switch what_to_save
    case 1
        fmlmap = handles.fmlmap;
        fmlsat = handles.fmlsat;
        fmlf = handles.fmlF;
        n = handles.fmln;
        aoi = handles.fmlaoi;
        demos = handles.demos;
               
        [filename, pathname] = uiputfile('output/fmlworkspace.mat', 'Save FML workspace as');
        save([pathname filename],'fmlmap', 'fmlf', 'fmlsat','n','aoi','demos');
        copyfile('guitools/README.txt', [pathname 'README.txt']);
        
    case 2    % guardamos la trayectoria para poder cargarla luego.
        trajectory = handles.trajectory;
        count = handles.cuenta;
        demos = handles.demos;
        
        [filename, pathname] = uiputfile('output/fmltrajectory.mat', 'Save FML workspace as');
        save([pathname filename],'trajectory', 'count','demos');
        copyfile('guitools/README.txt', [pathname 'README.txt']);
        
        
    otherwise
        % TODO : include save as fig. Tried so hard already but unable to
        % get a satisfactory solution.
        [file, path, ~] = uiputfile({'*.eps','Encapsulated PostScript (*.eps)';'*.pdf','Portable Document Format (*.pdf)'}, 'Save figure as');
        
        if file ~= 0
            filetype = file(end-2:end);

            switch what_to_save
                case 3
                    axes_to_save = fmLmap_axes;
                case 4
                    axes_to_save = fmLF_axes;
                case 5
                    axes_to_save = fmLres_axes;
     
                
            end
            
            % TODO : does not save properly the figures.
            %Runs the export_fig command with the path and file name, along with the 
            %filetype 
            export_fig(axes_to_save,[path,file],['-',filetype], '-transparent','-painters'); %painters
            export_fig(axes_to_save,[path,file],['-',filetype], '-transparent','-painters'); %painters
            
            %Message box 
            msgbox({'Done!';'';... 
            ['The file ',file,'.',filetype,' can be found in:'];path},... 
            'Save Figure File','help','modal'); 

        elseif isempty(file) == 0 
            msgbox('Not saved.','Save figure file','warn','modal'); 
        end
end


     


% --- Executes on button press in fmlnewmap_pushbutton.
function fmlnewmap_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fmlnewmap_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
draw;

% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in fmrecalculate_pushbutton.
function fmrecalculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fmrecalculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fmLF_axes
global fmLmap_axes

n = handles.fmln;
aoi_size = handles.fmlaoi;
map = handles.fmlmap; 
sat = handles.fmlsat;
demos = handles.demos;
figure(FM2app2);

% Executing the FML algorithm.

[F, T, end_point, dx, dy] = FML(map, demos, sat, aoi_size);
% Updating gui
handles.fmlT = T;
handles.fmlF = F;
handles.fmlsat = sat;
handles.fmlmap = map;
guidata(hObject,handles);

axes(fmLF_axes);
cla;
imagesc(F');
colormap gray(256);
axis xy;
axis image;
title('Velocities Map');
axis off;


% Getting some reproductions from the initial poitns of the demos.
for i = 1:n
    start_point = demos{i}(:,1);
    start_point_r = round(start_point);
    path = compute_geodesic(handles.fmlT, start_point_r);
    starts(:, i) = start_point;
    paths{i} = path;
end

% Plotting results.
axes(fmLmap_axes)
cla;
imagesc(map);
colormap gray(256);
hold on;
axis xy;
title('Result Map');

box on;
h = streamslice(-dx,-dy); % Reproductions field with stream lines.
set(h,'color','b');

for i = 1:length(paths)  
    ff = plot(paths{i}(1,:),paths{i}(2,:),'b','LineWidth',3);
    f = plot(starts(1,i),starts(2,i),'k.','markersize',30);
end

for i = 1:n 
    g = scatter(demos{i}(1,:),demos{i}(2,:),'.r');
end

plot(end_point(1),end_point(2),'k*','markersize',15,'linewidth',3);

set(gca,'xtick',[], 'ytick',[]);
hold off;
axis image;

guidata(hObject,handles);

set(handles.fmlsave_popupmenu, 'Enable', 'On');
set(handles.fmlsave_pushbutton, 'Enable', 'On');


% --- Executes on button press in fmloadtrajectory_pushbutton.
function fmloadtrajectory_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fmloadtrajectory_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fmLmap_axes
global fmLres_axes


figure(FM2app2);
fmlmap = handles.fmlmap; %ahora tenemos el mapa que se ha cargado

axes(fmLres_axes)
imagesc(handles.fmlmap);
axis image;
axis off;
colormap gray(256);
axis xy;
title('Trajectory Map');





fmlopenTRAY; %carga trayectoria



for r=1:size(handles.cuental,2)
    l=1;
 for y=1:handles.cuental{r} %porque tenemos dos puntos por trayectoria   
  xtra = handles.trajectoryl{r}(l);
  ytra = handles.trajectoryl{r}(l+1);
  if ytra > size(fmlmap,1) || xtra > size(fmlmap,2)
      l=l + 2;
  else 
  
     figure(FM2app2); 
     axes(fmLmap_axes)
     hold on;
     plot(xtra,ytra,'.r');
     l=l + 2;
     title('Obstacles Map');
     axes (fmLres_axes)
     hold on;
     plot(xtra,ytra,'.r');
     title('Trajectory Map');
  end
 end
end

handles.fmlmap = fmlmap;


FM2app2;




handles.fmln = size(handles.cuental,2);
aoi_size = handles.fmlaoi;
map = handles.fmlmap; 
sat = handles.fmlsat;
handles.demos = handles.demosl;


set(handles.fmlsat_slider, 'Enable', 'On');
set(handles.fmlsat_box, 'Enable', 'On');
set(handles.fmlsg_pushbutton, 'Enable', 'Off');
set(handles.fmlaoi_slider, 'Enable', 'On');
set(handles.fmlaoi_box, 'Enable', 'On');

set(handles.fmlsave_popupmenu, 'Enable', 'On');
set(handles.fmlsave_pushbutton, 'Enable', 'On');
set(handles.fmrecalculate_pushbutton, 'Enable', 'On');

set(handles.fmldemo_edit,'Enable','Off');

set(handles.hint_text2, 'String', 'Click Recalcule and Run FML.');

% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fast Marching Square Formations GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%nn%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in fm2floaddata_pushbutton.
function fm2floaddata_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2floaddata_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FM2app2;
fm2fopenGUI;
set(handles.hint_text3, 'String', 'Click Start, Goal and Run.');


function fm2fsat_box_Callback(hObject, eventdata, handles)
% hObject    handle to fm2fsat_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fm2fsat_box as text
%        str2double(get(hObject,'String')) returns contents of fm2fsat_box as a double
sat = str2double(get(hObject, 'String'));
sat = checkLimits(sat,0.00,1, 'saturation');

handles.fm2fsat = sat;


set(hObject, 'String', sat);
set(handles.fm2fsat_slider, 'Value', sat);

fm2fupdateF;
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function fm2fsat_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2fsat_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Value', 1);
set(hObject,'String', 1);

handles.fm2fsat = 1;
guidata(hObject,handles);


% --- Executes on slider movement.
function fm2fsat_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fm2fsat_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

sat = get(hObject, 'Value'); % IMPROVE: there should be a better way to round to 2 decimals.
sat = str2double(sprintf('%.2f', sat)); % To only show 2 decimals.; 
set(handles.fm2fsat_box, 'String', sat);

set(handles.fm2fsat_slider,'Min',0)


handles.fm2fsat = sat;


fm2fupdateF;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fm2fsat_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2fsat_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in fm2fnewmap_pushbutton.
function fm2fnewmap_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2fnewmap_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
draw;

% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function fm2funcertainty_box_Callback(hObject, eventdata, handles)
% hObject    handle to fm2funcertainty_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fm2funcertainty_box as text
%        str2double(get(hObject,'String')) returns contents of fm2funcertainty_box as a double
uncertainty = str2double(get(hObject, 'String'));
uncertainty = checkLimits(uncertainty,0.00,1, 'uncertainty');

handles.fm2funcertainty = uncertainty;


set(hObject, 'String', uncertainty);
set(handles.fm2funcertainty_slider, 'Value', uncertainty);

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fm2funcertainty_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2funcertainty_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Value', 1);
set(hObject,'String', 1);

handles.fm2funcertainty = 1;
guidata(hObject,handles);

% --- Executes on slider movement.
function fm2funcertainty_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fm2funcertainty_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
uncertainty = get(hObject, 'Value'); % IMPROVE: there should be a better way to round to 2 decimals.
uncertainty = str2double(sprintf('%.2f', uncertainty)); % To only show 2 decimals.; 
set(handles.fm2funcertainty_box, 'String', uncertainty);

set(handles.fm2funcertainty_slider,'Min',0)


handles.fm2funcertainty = uncertainty;

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fm2funcertainty_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2funcertainty_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end





function fm2fdist_box_Callback(hObject, eventdata, handles)
% hObject    handle to fm2fdist_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fm2fdist_box as text
%        str2double(get(hObject,'String')) returns contents of fm2fdist_box as a double

dist = str2double(get(hObject, 'String'));
dist = checkLimits(dist,1,25, 'dist');

handles.fm2fdist = dist;


set(hObject, 'String', dist);
set(handles.fm2fdist_slider, 'Value', dist);

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fm2fdist_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2fdist_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Value', 25);
set(hObject,'String', 25);

handles.fm2fdist = 25;
guidata(hObject,handles);

% --- Executes on slider movement.
function fm2fdist_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fm2fdist_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

dist = get(hObject, 'Value'); % IMPROVE: there should be a better way to round to 2 decimals.
dist = str2double(sprintf('%d', round(dist))); % To only show 2 decimals.; 
set(handles.fm2fdist_box, 'String', dist);

set(handles.fm2fdist_slider,'Min',1)
set(handles.fm2fdist_slider,'Max',25)

handles.fm2fdist = dist;

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function fm2fdist_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2fdist_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value', 25);
set(hObject,'String', 25);

handles.fm2fdist = 25;
guidata(hObject,handles)


% --- Executes on slider movement.
function fm2fsteps_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fm2fsteps_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
steps = get(hObject, 'Value'); % IMPROVE: there should be a better way to round to 2 decimals.
steps = str2double(sprintf('%d', round(steps))); % To only show 2 decimals.; 
set(handles.fm2fsteps_box, 'String', steps);

set(handles.fm2fsteps_slider,'Min',1)
set(handles.fm2fsteps_slider,'Max',100)

handles.fm2fsteps = steps;

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fm2fsteps_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2fsteps_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value', 100);
set(hObject,'String', 100);

handles.fm2fsteps = 100;
guidata(hObject,handles)


function fm2fsteps_box_Callback(hObject, eventdata, handles)
% hObject    handle to fm2fsteps_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fm2fsteps_box as text
%        str2double(get(hObject,'String')) returns contents of fm2fsteps_box as a double
steps = str2double(get(hObject, 'String'));
steps = checkLimits(steps,1,100, 'dist');

handles.fm2fsteps = steps;


set(hObject, 'String', steps);
set(handles.fm2fsteps_slider, 'Value', steps);

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fm2fsteps_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2fsteps_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Value', 100);
set(hObject,'String', 100);

handles.fm2fsteps = 100;
guidata(hObject,handles);


% --- Executes on button press in fm2frun_pushbutton.
function fm2frun_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2frun_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fm2fmap_axes;
global fm2fanim_axes;
global fm2fveloc_axes;
global fm2fdist_axes;

%% Parameters
steps_data = handles.fm2fsteps;    % Steps between iterations.
dist_data = handles.fm2fdist;% Desired distance between robots.

if (mod(dist_data,2)==0) % Comprueba si es par o impar
 dist_data = dist_data + 1;
end
    
uvedoble = handles.fm2fsat;
uvedobleo = handles.fm2fmap;

uncertainty = handles.fm2funcertainty;
set(handles.fm2fsave_pushbutton, 'Enable', 'On');
set(handles.fm2fsave_popupmenu, 'Enable', 'On');
[F,G,fm2fmap_res,dist_foll1,dist_foll2,Bleader,Bfoll1,Bfoll2,jj] = robotFormation(fm2fmap_axes,fm2fanim_axes,fm2fveloc_axes,fm2fdist_axes,uncertainty,uvedoble,uvedobleo,steps_data,dist_data);

handles.fm2fmap_res = fm2fmap_res;


handles.dist_foll1= dist_foll1;
handles.dist_foll2= dist_foll2; 
handles.Bleader= Bleader;
handles.Bfoll1= Bfoll1;
handles.Bfoll2= Bfoll2;

handles.jj = jj;


set(handles.hint_text2, 'String', 'Click popupmenu and select axes. Then, click save.');

handles.F = F;
handles.G = G;

guidata(hObject,handles)


% --- Executes on selection change in fm2fsave_popupmenu.
function fm2fsave_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to fm2fsave_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fm2fsave_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fm2fsave_popupmenu


% --- Executes during object creation, after setting all properties.
function fm2fsave_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fm2fsave_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in fm2fsave_pushbutton.
function fm2fsave_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2fsave_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fm2fmap_axes
global fm2fanim_axes
global fm2fdist_axes
global fm2fveloc_axes

what_to_save = get(handles.fm2fsave_popupmenu,'Value'); 

switch what_to_save
    case 1
        
     
        fm2fsat = handles.fm2fsat;
        fm2fmap = handles.fm2fmap_res;
        fm2funcertainty = handles.fm2funcertainty;
        fm2fsteps = handles.fm2fsteps;
        fm2fdist = handles.fm2fdist;
        fm2fGanim = handles.G;
        fm2fFanim = handles.F;
        dist_foll1 = handles.dist_foll1;
        dist_foll2 = handles.dist_foll2;
        Bleader = handles.Bleader;
        Bfoll1 = handles.Bfoll1;
        Bfoll2 = handles.Bfoll2;
        jj = handles.jj;
        
        [filename, pathname] = uiputfile('output/fm2fworkspace.mat', 'Save FM2F workspace as');
        save([pathname filename],'fm2fsat','fm2fmap','fm2funcertainty','fm2fsteps','fm2fdist','fm2fGanim','fm2fFanim','dist_foll1','dist_foll2','Bleader','Bfoll1','Bfoll2','jj');
        copyfile('guitools/README.txt', [pathname 'README.txt']);
                
        
    otherwise
        % TODO : include save as fig. Tried so hard already but unable to
        % get a satisfactory solution.
        [file, path, ~] = uiputfile({'*.eps','Encapsulated PostScript (*.eps)';'*.pdf','Portable Document Format (*.pdf)'}, 'Save figure as');
        
        if file ~= 0
            filetype = file(end-2:end); 



            switch what_to_save
                case 2
                    axes_to_save = fm2fmap_axes;
                case 3
                    axes_to_save = fm2fanim_axes;
                case 4
                    axes_to_save = fm2fdist_axes;
                case 5
                    axes_to_save = fm2fveloc_axes;
                
            end
            
            % TODO : does not save properly the figures.
            %Runs the export_fig command with the path and file name, along with the 
            %filetype 
            export_fig(axes_to_save,[path,file],['-',filetype], '-transparent','-painters'); %painters
            export_fig(axes_to_save,[path,file],['-',filetype], '-transparent','-painters'); %painters
            
            %Message box 
            msgbox({'Done!';'';... 
            ['The file ',file,'.',filetype,' can be found in:'];path},... 
            'Save Figure File','help','modal'); 

        elseif isempty(file) == 0 
            msgbox('Not saved.','Save figure file','warn','modal'); 
        end
end
