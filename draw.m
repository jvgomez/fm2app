function varargout = draw(varargin)
% DRAW MATLAB code for draw.fig
%      DRAW, by itself, creates a new DRAW or raises the existing
%      singleton*.
%
%      H = DRAW returns the handle to a new DRAW or the handle to
%      the existing singleton*.
%
%      DRAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAW.M with the given input arguments.
%
%      DRAW('Property','Value',...) creates a new DRAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before draw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to draw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help draw

% Last Modified by GUIDE v2.5 17-Aug-2014 08:39:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @draw_OpeningFcn, ...
                   'gui_OutputFcn',  @draw_OutputFcn, ...
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
end

% --- Executes just before draw is made visible.
function draw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to draw (see VARARGIN)
%handles.fm2newmap = 0;

global drawnewmap_axes

drawnewmap_axes = handles.drawnewmap_axes;

axes(drawnewmap_axes);
axis off;


handles.marcaload = 0;%inicializamos a 0 la variable para saber si se ha cargado o no
handles.error1 = 1; % se inicializan a 1 porque no se sabe la resolucion
handles.error2 = 1; % se inicializan a 1 porque no se sabe la resolucion

handles.point = 0;% utilizado para verificar si es valido el punto marcado

handles.showaxes = 0; % no muestra el eje de coordenadas por defecto.

handles.fmdrawWidth = 0; 
handles.fmdrawHeight= 0;

% Choose default command line output for draw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



end



% --- Outputs from this function are returned to the command line.
function varargout = draw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in drawsaves_pushbutton.
function drawsaves_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to drawsaves_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   
  if handles.marcaload == 0 % Por si no hay ningun mapa
   errordlg ('You do not have to save never', ...
                    'Information for Save', 'modal');
  elseif handles.marcaload == 1

      drawnewmap = handles.drawnewmap; 
        
        
        [filename, pathname] = uiputfile({
            '*.mat','Initial environment representation (*.mat)' }, 'Save figure as');
        save([pathname filename], 'drawnewmap');
        %copyfile('guitools/README2.txt', [pathname 'README2.txt']);
  end
end


% --- Executes on button press in drawloaddata_pushbutton.
function drawloaddata_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to drawloaddata_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
drawopenGUI;

handles.output = hObject;
guidata(hObject, handles);

end

% --- Executes on button press in fmdraw_pushbutton.
function fmdraw_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fmdraw_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.User_text, 'String', 'Click in axes for draw');

position = 0;
global drawnewmap_axes
wid = handles.fmdrawWidth;
hei = handles.fmdrawHeight;

if handles.marcaload == 0 % Es un mapa nuevo 
  if handles.error1 == 1 || handles.error2 == 1 % verifica que se tienen las dimensiones
   errordlg ('You should be introduce Height and Width', ...
                    'Information for Resolution', 'modal');
  else              
   axes(drawnewmap_axes);
   
   Wo=[hei wid]; %Definimos la matriz [fila columna]
   Wo= ones (Wo);%LLeno toda la matriz de unos
   Wo(:,1) = 0; %todas la filas de la primera columna son 0
   Wo(:,end) = 0; %todas las filas de la columna end son 0
   Wo(1,:) = 0; %todas las columnas de la primera fila son 0
   Wo(end,:) = 0; %todas las columnas de la ultima fila son cero
   
   if handles.showaxes == 0 % no se muestran los ejes
    imagesc(Wo);
    colormap gray(256);
    axis off;
    axis xy;
   elseif handles.showaxes == 1 % se muestran los ejes
    imagesc(Wo);
    colormap gray(256);
    axis on;
    axis xy;
   end
  
     while handles.point == 0
     [c,f] = ginput(2); %Se encarga de obtener coordenadas de la grafica.
     f = round (f);
     c = round (c);
     handles.point = 1;
      if  c(1) <= 0 || c(1) >= wid || f(1) <= 0 || f(1) >= hei || c(2) <= 0 || c(2) >= wid || f(2) <= 0 || f(2) >= hei %comparamos el segundo punto %comparamos el primero punto
        h = warndlg('Point out of map bounds, please select another point.',...
        'Start point selection error','modal');
         uiwait(h); % Prevents to run ginputax by clicking the OK button.
         
         
        handles.point = 0;
      end
     end 
     
     P1= [f(1) c(1)]; %punto necesario 1
     P2= [f(2) c(2)]; %punto necesario 2
     P3= [f(1) c(2)]; 
     P4= [f(2) c(1)];
   
    
     
   row = P3-P1; %diferencia entre la fila
   column = P4-P1; %diferencia entre columna
 if row(2) > 0 && column(1) > 0
     position = 1;
 elseif row(2) < 0 && column(1) > 0
     row = P1-P3;
     position = 2;
 elseif row(2) > 0 && column(1) < 0
     column = P1-P4; % ahora es positivo
     position = 3;
 elseif row(2) < 0 && column(1) < 0 
     row = P1-P3;
     column = P1-P4;
     position = 4;
 end    
 if position == 1 
   for x = 0: column (1) %Se rellena fila y columna a la vez
    P(1) = P1(1) + x;
    for i=0:row(2)    
     P(2) = P1(2)+i;
     Wo(P(1),P(2))=0;
     i=i+1;
    end
    x = x + 1;
    Wo (P(1),P(2)) = 0;
   end
 elseif position == 2
   for x = 0: column (1) %Se rellena fila y columna a la vez
     P(1) = P3(1) + x;
     for i=0:row(2)    
      P(2) = P3(2)+i;
      Wo(P(1),P(2))=0;
      i=i+1;
     end
     x = x + 1;
     Wo (P(1),P(2)) = 0;
   end
 elseif position == 3 
   for x = 0: column (1) %Se rellena fila y columna a la vez
     P(1) = P4(1) + x;
     for i=0:row(2)    
      P(2) = P4(2)+i;
      Wo(P(1),P(2))=0;
      i=i+1;
     end
     x = x + 1;
     Wo (P(1),P(2)) = 0;
   end
 elseif position == 4 
   for x = 0: column (1) %Se rellena fila y columna a la vez
     P(1) = P2(1) + x;
     for i=0:row(2)    
      P(2) = P2(2)+i;
      Wo(P(1),P(2))=0;
      i=i+1;
     end
     x = x + 1;
     Wo (P(1),P(2)) = 0;
   end
 end
 
 
   if handles.showaxes == 0 
    imagesc(Wo);
    colormap gray(256);
    axis off;
    axis xy;
   elseif handles.showaxes == 1
    imagesc(Wo);
    colormap gray(256);
    axis on;
    axis xy;
   end
 
   
   set(handles.drawsaves_pushbutton,'Enable','On');
   set(handles.Delete_pushbutton, 'Enable', 'On');
   set(handles.showaxes_togglebutton, 'Enable', 'On');
   set (handles.clearnew_pushbutton,'Enable','On');
   set(handles.User_text, 'String', 'Click other pushbutton');
    
    position = 0;
    handles.drawnewmap = Wo;
    handles.marcaload = 1;
    handles.point = 0;

    
  end
elseif handles.marcaload == 1 % el mapa es cargado o ya se ha dibujado sobre él.
    
    axes(drawnewmap_axes);
   
   if handles.showaxes == 0 % se utiliza axis off
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis off;
    axis xy;
   elseif handles.showaxes == 1
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis xy;
   end
    
    set(handles.drawloaddata_pushbutton,'Enable','Off');
    set(handles.Delete_pushbutton, 'Enable', 'Off');
    set(handles.drawsaves_pushbutton, 'Enable', 'Off');
    set(handles.clearnew_pushbutton,'Enable','Off');
   
    position = 0;
    
    while handles.point == 0
     [c,f] = ginput(2); %Se encarga de obtener coordenadas de la grafica
     f = round (f);
     c = round (c);
     handles.point = 1;
     if  c(1) <= 0 || c(1) >= wid || f(1) <= 0 || f(1) >= hei || c(2) <= 0 || c(2) >= wid || f(2) <= 0 || f(2) >= hei %comparamos el segundo punto %comparamos el primero punto
        h = warndlg('Point out of map bounds, please select another point.',...
        'Start point selection error','modal');
        uiwait(h); % Prevents to run ginputax by clicking the OK button.
        handles.point = 0;
     end  
    end
      
     P1= [f(1) c(1)]; %punto necesario 1
     P2= [f(2) c(2)]; %punto necesario 2
     P3= [f(1) c(2)]; 
     P4= [f(2) c(1)];
     
   row = P3-P1; %diferencia entre la fila
   column = P4-P1; %diferencia entre columna
 if row(2) > 0 && column(1) > 0
     position = 1;
 elseif row(2) < 0 && column(1) > 0
     row = P1-P3;
     position = 2;
 elseif row(2) > 0 && column(1) < 0
     column = P1-P4; % ahora es positivo
     position = 3;
 elseif row(2) < 0 && column(1) < 0 
     row = P1-P3;
     column = P1-P4;
     position = 4;
 end    
 if position == 1 
   for x = 0: column (1) %Se rellena fila y columna a la vez
    P(1) = P1(1) + x;
    for i=0:row(2)    
     P(2) = P1(2)+i;
     handles.drawnewmap(P(1),P(2))=0;
     i=i+1;
    end
    x = x + 1;
    handles.drawnewmap(P(1),P(2)) = 0;
   end
 elseif position == 2
   for x = 0: column (1) %Se rellena fila y columna a la vez
     P(1) = P3(1) + x;
     for i=0:row(2)    
      P(2) = P3(2)+i;
      handles.drawnewmap(P(1),P(2))=0;
      i=i+1;
     end
     x = x + 1;
     handles.drawnewmap(P(1),P(2)) = 0;
   end
 elseif position == 3 
   for x = 0: column (1) %Se rellena fila y columna a la vez
     P(1) = P4(1) + x;
     for i=0:row(2)    
      P(2) = P4(2)+i;
      handles.drawnewmap(P(1),P(2))=0;
      i=i+1;
     end
     x = x + 1;
     handles.drawnewmap(P(1),P(2)) = 0;
   end
 elseif position == 4 
   for x = 0: column (1) %Se rellena fila y columna a la vez
     P(1) = P2(1) + x;
     for i=0:row(2)    
      P(2) = P2(2)+i;
      handles.drawnewmap(P(1),P(2))=0;
      i=i+1;
     end
     x = x + 1;
     handles.drawnewmap(P(1),P(2)) = 0;
   end
 end
 
  if handles.showaxes == 0 % se utiliza axis off
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis off;
    axis xy
   elseif  handles.showaxes == 1
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis on;
    axis xy;
  end
    set(handles.drawloaddata_pushbutton,'Enable','On');
    set(handles.Delete_pushbutton, 'Enable', 'On');
    set(handles.drawsaves_pushbutton, 'Enable', 'On');
    set(handles.clearnew_pushbutton,'Enable','On');
    set(handles.User_text, 'String', 'Click other pushbutton');  
    position = 0;
    handles.point = 0;
    
end
  
% Choose default command line output for draw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
end


% --- Executes when Draw_uipanel is resized.
function Draw_uipanel_ResizeFcn(hObject, eventdata, handles) %Esta propiedad de Uipanel que reajusta el tamaño.
% hObject    handle to Draw_uipanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

u = findobj('Tag','Draw_uipanel'); 
fig = gcbo;
old_units = get(fig,'Units'); 
set(fig,'Units','normalized');
figpos = get(fig,'Position');
upos = [0, 0, 1, 1]; % Xmin Ymin Wight Height 
set(u,'Position',upos);
set(fig,'Units',old_units)
end



function fmdrawHeight_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fmdrawWidth_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmdrawWidth_edit as text
% str2double(get(hObject,'String')) returns contents of fmdrawWidth_edit as a double

height = get(hObject, 'Value');
height = str2double(get(hObject,'String'));

set(handles.fmdrawHeight_edit, 'String', height);



handles.fmdrawHeight = height; %%  altura
handles.error1 = 0; % esto verifica que se ha escrito la altura.
guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function fmdrawHeight_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmdrawWidth_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end 

function fmdrawWidth_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fmdrawWidth_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmdrawWidth_edit as text
%        str2double(get(hObject,'String')) returns contents of fmdrawWidth_edit as a double

width = get(hObject, 'Value');
width = str2double(get(hObject,'String'));

set(handles.fmdrawWidth_edit, 'String', width);

handles.fmdrawWidth = width;%%  anchura
handles.error2 = 0;% Verifica anchura

set (handles.fmdraw_pushbutton,'Enable','On');
guidata(hObject,handles);

end

% --- Executes during object creation, after setting all properties.
function fmdrawWidth_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmdrawWidth_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
 end
end


% --- Executes on button press in Delete_pushbutton.
function Delete_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Delete_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

wid = handles.fmdrawWidth;
hei = handles.fmdrawHeight;

set(handles.User_text, 'String', 'Click in axes for delete');

if handles.marcaload == 0
    errordlg ('You should be draw, if you want delete', ...
                    'Information for Delete', 'modal');
 
else
    set(handles.fmdraw_pushbutton,'Enable','Off');
    set(handles.drawloaddata_pushbutton, 'Enable', 'Off');
    set(handles.drawsaves_pushbutton, 'Enable', 'Off');
    set (handles.clearnew_pushbutton,'Enable','Off');

   while handles.point == 0
    if handles.showaxes == 0 % se utiliza axis off
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis off;
    axis xy;
   elseif handles.showaxes == 1
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis xy;
    axis on;
    end
  [C,F] = ginput(2); %Se encarga de obtener coordenadas de la grafica.

    F = round (F);
    C = round (C);

    P1= [F(1) C(1)]; %punto necesario 1
    P2= [F(2) C(2)]; %punto necesario 2
    P3= [F(1) C(2)]; 
    P4= [F(2) C(1)];

   handles.point = 1;
    if  C(1) <= 0+1 || C(1) >= wid-1 || F(1) <= 0+1 || F(1) >= hei-1 || C(2) <= 0+1 || C(2) >= wid-1 || F(2) <= 0+1 || F(2) >= hei-1 %comparamos el primero punto
        h = warndlg('Point out of map bounds, please select another point.',...
        'Start point selection error','modal');
        uiwait(h); % Prevents to run ginputax by clicking the OK button.
        handles.point = 0;
 
    end  

   end
  
     handles.point = 0;

    row2 = P3-P1; %diferencia de filas (rows)
    column2 = P4-P1;
   
    
   if row2(2) > 0 && column2(1) > 0
    position = 1;
   elseif row2(2) < 0 && column2(1) > 0
    row2= P1-P3;
    position = 2;
   elseif row2(2) > 0 && column2(1) < 0
    column2= P1-P4; % ahora es positivo
    position = 3;
   elseif row2(2) < 0 && column2(1) < 0 
    row2= P1-P3;
    column2= P1-P4;
    position = 4;
   end 
    
 if position == 1 
   for x = 0: column2 (1) %Se rellena fila y columna a la vez
    P(1) = P1(1) + x;
    for i=0:row2(2)    
     P(2) = P1(2)+i;
     handles.drawnewmap(P(1),P(2))=1;
     i=i+1;
    end
    x = x + 1;
    handles.drawnewmap(P(1),P(2)) =1;
   end
   
 elseif position == 2
   for x = 0: column2(1) %Se rellena fila y columna a la vez
     P(1) = P3(1) + x;
     for i=0:row2(2)    
      P(2) = P3(2)+i;
      handles.drawnewmap(P(1),P(2))=1;
      i=i+1;
     end
     x = x + 1;
     handles.drawnewmap(P(1),P(2)) =1;
   end
   
 elseif position == 3 
   for x = 0: column2(1) %Se rellena fila y columna a la vez
     P(1) = P4(1) + x;
     for i=0:row2(2)    
      P(2) = P4(2)+i;
      handles.drawnewmap(P(1),P(2))=1;
      i=i+1;
     end
     x = x + 1;
     handles.drawnewmap(P(1),P(2)) =1;
   end
 elseif position == 4 
   for x = 0: column2(1) %Se rellena fila y columna a la vez
     P(1) = P2(1) + x;
     for i=0:row2(2)    
      P(2) = P2(2)+i;
      handles.drawnewmap(P(1),P(2))=1;
      i=i+1;
     end
     x = x + 1;
     handles.drawnewmap(P(1),P(2)) =1;
   end
 end
   
 
   if handles.showaxes == 0 % se utiliza axis off
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis off;
    axis xy;
   elseif handles.showaxes == 1
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis xy;
    axis on
   end
 
    set(handles.fmdraw_pushbutton,'Enable','On');
    set(handles.drawloaddata_pushbutton, 'Enable', 'On');
    set(handles.drawsaves_pushbutton, 'Enable', 'On');
    set (handles.clearnew_pushbutton,'Enable','On');
 
    position = 0;
    % Choose default command line output for draw
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

 end
set(handles.User_text, 'String', 'Click other pushbutton');  
end




% --- Executes on button press in showaxes_togglebutton.
function showaxes_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to showaxes_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showaxes_togglebutton

button_state = get (hObject, 'Value');
if button_state == get (hObject , 'Max') 
   
    handles.showaxes = 1; % "Utilizamos Axes xy"
   
elseif button_state == get (hObject , 'Min')

    handles.showaxes = 0; % "No se ven los ejes"

end
 % Choose default command line output for draw
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);
end


% --- Executes on button press in clearnew_pushbutton.
function clearnew_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to clearnew_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global drawnewmap_axes

   wid = handles.fmdrawWidth;
   hei = handles.fmdrawHeight;

   handles.drawnewmap=[hei wid]; 
   handles.drawnewmap= ones (handles.drawnewmap);
   handles.drawnewmap(:,1) = 0; 
   handles.drawnewmap(:,end) = 0;
   handles.drawnewmap(1,:) = 0; 
   handles.drawnewmap(end,:) = 0; 
   
   
   axes(drawnewmap_axes);
   if handles.showaxes == 0 % se utiliza axis off
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis off;
    axis xy;
   elseif handles.showaxes == 1
    imagesc(handles.drawnewmap);
    colormap gray(256);
    axis xy;
    axis on;
  end
   
% Choose default command line output for draw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
end
