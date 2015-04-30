function varargout = FM2app2(varargin)
% FM2APP2 MATLAB code for FM2app2.fig
%      FM2APP2, by itself, creates a new FM2APP2 or raises the existing
%      singleton*.
%
%      H = FM2APP2 returns the handle to a new FM2APP2 or the handle to
%      the existing singleton*.
%
%      FM2APP2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FM2APP2.M with the given input arguments.
%
%      FM2APP2('Property','Value',...) creates a new FM2APP2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FM2app2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FM2app2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FM2app2

% Last Modified by GUIDE v2.5 20-Jul-2014 17:44:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FM2app2_OpeningFcn, ...
                   'gui_OutputFcn',  @FM2app2_OutputFcn, ...
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


% --- Executes just before FM2app2 is made visible.
function FM2app2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FM2app2 (see VARARGIN)



% Choose default command line output for FM2app2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Axes FM2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes(handles.fm2map_axes); 
axis off; % no mostramos los ejes

axes(handles.fm2F_axes);
axis off;

axes(handles.fm2T_axes);
axis off;

axes(handles.fm2vels_axes);
axis off;


global fm2map_axes
fm2map_axes= handles.fm2map_axes; %se hace global la variable.


global fm2F_axes
fm2F_axes = handles.fm2F_axes;

global fm2T_axes
fm2T_axes = handles.fm2T_axes;

global fm2vels_axes
fm2vels_axes = handles.fm2vels_axes;






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Axes FML
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes(handles.fmLmap_axes);
axis off;

axes(handles.fmLF_axes);
axis off;

axes(handles.fmLres_axes);
axis off;

global fmLmap_axes
fmLmap_axes = handles.fmLmap_axes;

global fmLF_axes
fmLF_axes = handles.fmLF_axes;

global fmLres_axes
fmLres_axes = handles.fmLres_axes;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Axes FM2F
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes(handles.fm2fmap_axes);
axis off;

axes(handles.fm2fanim_axes);
axis off;

axes(handles.fm2fdist_axes);
axis off;

axes(handles.fm2fveloc_axes);
axis off;

global fm2fmap_axes
fm2fmap_axes = handles.fm2fmap_axes;

global fm2fanim_axes
fm2fanim_axes = handles.fm2fanim_axes;

global fm2fdist_axes
fm2fdist_axes = handles.fm2fdist_axes;

global fm2fveloc_axes
fm2fveloc_axes = handles.fm2fveloc_axes;


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
set(handles.fm2axes_uipanel, 'Visible', 'On');
set(handles.fmlaxes_uipanel, 'Visible', 'Off');
set(handles.fm2faxes_uipanel, 'Visible', 'Off');

%setappdata(handles.fm2map_axes,'fm2map_axes',handles.fm2map_axes);
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --------------------------------------------------------------------
function fml_menu_Callback(hObject, eventdata, handles)
% hObject    handle to fml_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.fm2axes_uipanel, 'Visible', 'Off');
set(handles.fm2faxes_uipanel, 'Visible', 'Off');
set(handles.fmlaxes_uipanel, 'Visible', 'On');

% --------------------------------------------------------------------

function fm2f_menu_Callback(hObject, eventdata, handles)
% hObject    handle to fml_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.fm2axes_uipanel, 'Visible', 'Off');
set(handles.fmlaxes_uipanel, 'Visible', 'Off');
set(handles.fm2faxes_uipanel, 'Visible', 'On');

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



% UIWAIT makes FM2app2 wait for user response (see UIRESUME)
% 


% --- Outputs from this function are returned to the command line.
function varargout = FM2app2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over axes background.
function fm2map_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fm2map_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set (handles.fm2map_axes,'Renderer','painters');

% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Executes on mouse press over axes background.
function fm2F_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fm2F_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set (handles.fm2F_axes,'Renderer','painters');
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




% --- Executes on mouse press over axes background.
function fm2T_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fm2T_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set (handles.fm2T_axes,'Renderer','painters');

% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




% --- Executes on mouse press over axes background.
function fm2vels_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fm2vels_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set (handles.fm2vels_axes,'Renderer','painters'); 
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Executes on mouse press over axes background.
function fmLmap_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fmLmap_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set (handles.fmLmap_axes,'Renderer','painters'); %permite imprimir bien
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Executes on mouse press over axes background.
function fmLF_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fmLF_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set (handles.fmLF_axes,'Renderer','painters'); %permite imprimir bien
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Executes on mouse press over axes background.
function fmLres_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fmLres_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set (handles.fmLres_axes,'Renderer','painters'); %permite imprimir bien
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Executes on mouse press over axes background.
function fmLtest_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fmLtest_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set (handles.fmLtest_axes,'Renderer','painters'); %permite imprimir bien
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fast Marching Square Formations GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on mouse press over axes background.
function fm2fmap_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fm2fmap_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set (handles.fm2fmap_axes,'Renderer','painters'); %permite imprimir bien
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Executes on mouse press over axes background.
function fm2fanim_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fm2fanim_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set (handles.fm2fanim_axes,'Renderer','painters'); %permite imprimir bien
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Executes on mouse press over axes background.
function fm2fdist_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fm2fdist_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set (handles.fm2fdist_axes,'Renderer','painters'); %permite imprimir bien
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Executes on mouse press over axes background.
function fm2fveloc_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fm2fveloc_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set (handles.fm2fveloc_axes,'Renderer','painters'); %permite imprimir bien
% Choose default command line output for FM2app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
