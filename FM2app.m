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

% Last Modified by GUIDE v2.5 22-Oct-2013 12:51:09

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

if isempty(regexp(path,['guitools' pathsep], 'once'))
    addpath([pwd, '/guitools']);    % tool scripts
end

if isempty(regexp(path,['thirdparty' pathsep], 'once'))
    addpath([pwd, '/thirdparty']);    % tool scripts
end

axes(handles.fm2map_axes);
axis off;

axes(handles.fm2F_axes);
axis off;

axes(handles.fm2T_axes);
axis off;

axes(handles.fm2vels_axes);
axis off;
 
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


% --------------------------------------------------------------------
function fml_menu_Callback(hObject, eventdata, handles)
% hObject    handle to fml_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.fm2_uipanel, 'Visible', 'Off');

% --------------------------------------------------------------------
function about_menu_Callback(hObject, eventdata, handles)
% hObject    handle to about_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str = sprintf('FM2app - Fast Marching Square\nVersion: 1.0 - 22/10/2013\n\nAuthor: Javier V. Gómez\njvgomez@ing.uc3m.es\nwww.javiervgomez.com\nhttp://roboticslab.uc3m.es/\nCarlos III University of Madrid');
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

fm2updateF;


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

fm2openGUI;

% --- Executes on button press in fm2sg_pushbutton.
function fm2sg_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2sg_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.hint_text, 'String', 'Click over the environment map to select the FM2 start and goal points.');

 % Start point
point_ok = 0;
while point_ok == 0
    [x,y] = ginputax(handles.fm2map_axes,1);
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

axes(handles.fm2map_axes);
cla;
imagesc(handles.fm2map);
colormap gray(256);
axis xy;
axis image;
axis off;
hold on;
plot(x,y,'rx','MarkerSize', 15);

 % Goal point
point_ok = 0;
while point_ok == 0
    [x,y] = ginputax(handles.fm2map_axes,1);
    y = round(y);
    x = round(x);       
    point_ok = 1;
    if y < 0 || y > size(handles.fm2map,1) || x < 0 || x > size(handles.fm2map,2)
        h = warndlg('Point out of map bounds, please select another point.',...
        'Goal point selection error','modal');
        uiwait(h);  % Prevents to run ginputax by clicking the OK button.
        point_ok = 0;
    elseif handles.fm2map(y,x) == 0
        h = warndlg('Point in an obstacle, please select another point.',...
        'Goal point selection error','modal');
        uiwait(h);  % Prevents to run ginputax by clicking the OK button.
        point_ok = 0;
    end
end

handles.fm2goal_point = [x; y];
str = sprintf('Goal: [%d, %d]',x,y);
set(handles.fm2goal_text, 'String', str);

axes(handles.fm2map_axes);
plot(x,y,'k*','MarkerSize', 15);
hold off;

guidata(hObject,handles);  

set(handles.fm2run_pushbutton, 'Enable', 'On');

set(handles.hint_text, 'String', 'Now click on Compute FM2! to run the Fast Marching Square algorithm.');


% --- Executes on button press in fm2run_pushbutton.
function fm2run_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fm2run_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% IMPROVEMENT : add option of additive drawing: if data not reloaded, select if
% the new FM2 run should detele the previous computed path.

sat = str2double(get(handles.fm2sat_box, 'String'));
map = handles.fm2map;
start = handles.fm2start_point;
goal = handles.fm2goal_point;

 % FM2 template. The velocities map F is recomputed just to show how the
 % FM2 template is.

[F, T, path, vels, times] = FM2(map, sat, start, goal);

 % Updating gui.
handles.fm2F = F;
handles.fm2path = path;
handles.fm2vels = vels;
handles.fm2times = times;
handles.fm2sat = sat;
guidata(hObject,handles);

str = sprintf('F (s): %f', times(1));
set(handles.fm2Ftime_text, 'String', str);

freezeColors(handles.fm2F_axes);

fm2updateT;

axes(handles.fm2map_axes);
colormap gray(256);
freezeColors;
hold on;
plot(path(1,:), path(2,:), 'b-', 'LineWidth', 5);

axes(handles.fm2vels_axes);
cla;
plot(vels(2,:), vels(1,:), 'b-', 'LineWidth', 2);
hold on;
plot(vels(2,1), vels(1,1), 'rx', 'MarkerSize', 15);
plot(vels(2,end), vels(1,end), 'k*', 'MarkerSize', 15);
ylim([0 1.05]);
hold off;

set(handles.hint_text, 'String', 'You can see the results of the FM2 algorithm: path, velocities map, times-of-arrival function and velocities profile. Now use the Save button to store data.');

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
                    axes_to_save = handles.fm2map_axes;
                case 3
                    axes_to_save = handles.fm2F_axes;
                case 4
                    axes_to_save = handles.fm2T_axes;
                case 5
                    axes_to_save = handles.fm2vels_axes;
            end
            
            % TODO : does not save properly the figures.
            %Runs the export_fig command with the path and file name, along with the 
            %filetype 
            export_fig(axes_to_save,[path,file],['-',filetype], '-transparent');

            %Message box 
            msgbox({'Done!';'';... 
            ['The file ',file,'.',filetype,' can be found in:'];path},... 
            'Save Figure File','help','modal'); 

        elseif isempty(file) == 0 
            msgbox('Not saved.','Save figure file','warn','modal'); 
        end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fast Marching Learning GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
