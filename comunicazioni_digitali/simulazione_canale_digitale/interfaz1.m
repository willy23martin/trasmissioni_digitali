
function varargout = interfaz1(varargin)
% INTERFAZ1 MATLAB code for interfaz1.fig
%      INTERFAZ1, by itself, creates a new INTERFAZ1 or raises the existing
%      singleton*.
%
%      H = INTERFAZ1 returns the handle to a new INTERFAZ1 or the handle to
%      the existing singleton*.
%
%      INTERFAZ1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ1.M with the given input arguments.
%
%      INTERFAZ1('Property','Value',...) creates a new INTERFAZ1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interfaz1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interfaz1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interfaz1

% Last Modified by GUIDE v2.5 30-Nov-2016 22:24:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfaz1_OpeningFcn, ...
                   'gui_OutputFcn',  @interfaz1_OutputFcn, ...
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

x='';

% --- Executes just before interfaz1 is made visible.
function interfaz1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interfaz1 (see VARARGIN)

% Choose default command line output for interfaz1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interfaz1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interfaz1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ButSecBits.
function ButSecBits_Callback(hObject, eventdata, handles)
% hObject    handle to ButSecBits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load variables



axes(handles.axes2);
SecBits(myRecording);

% --- Executes on button press in ButErrorBitSim.
function ButErrorBitSim_Callback(hObject, eventdata, handles)
% hObject    handle to ButErrorBitSim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load codLineas 
load codCanal 
load canalOutput
load modDig 
load decoCanal
load demodulador
load codificacion 

rela=handles.relacion;
cla reset; 

relanum=str2num(rela);


axes(handles.axes2);
%SNR=str2num(rela);
BEP(relanum,length(datosDecoCanal));


% --- Executes on button press in ButErrorBloq.
function ButErrorBloq_Callback(hObject, eventdata, handles)
% hObject    handle to ButErrorBloq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load canalOutput 
load codLineas
load codCanal
load decoCanal 

Decodificacion(canal,codLine );

rela=handles.relacion;


relanum=str2num(rela);




[y,Fs] = audioread('audio.wav');

sound(y,Fs);

%axes(handles.axes2);



% --- Executes on button press in ButErrorSim.
function ButErrorSim_Callback(hObject, eventdata, handles)
% hObject    handle to ButErrorSim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rela=handles.relacion;
cla reset; 

axes(handles.axes2);

SNR=str2num(rela);
SEP1(SNR);

function TasaTx_Callback(hObject, eventdata, handles)
% hObject    handle to TasaTx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TasaTx as text
%        str2double(get(hObject,'String')) returns contents of TasaTx as a double
handles.tasaTx=get(hObject,'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function TasaTx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TasaTx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Relacion_Callback(hObject, eventdata, handles)
% hObject    handle to Relacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Relacion as text
%        str2double(get(hObject,'String')) returns contents of Relacion as a double
handles.relacion=get(hObject,'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Relacion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Relacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fuente.
function fuente_Callback(hObject, eventdata, handles)
% hObject    handle to fuente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load variables

axes(handles.axes1);
    
    stem(dataBin(1:100));hold on;
    xlabel('tiempo ');ylabel('Amplitud');
    title('Datos digitales a transmitir');
    ylim([0 1.5]);


% --- Executes on button press in Formateo.
function Formateo_Callback(hObject, eventdata, handles)
% hObject    handle to Formateo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load variables

codi=Codificacion64(archivo);
save codificacion codi
disp('termino Formateo')


% --- Executes on button press in CodCanal.
function CodCanal_Callback(hObject, eventdata, handles)
% hObject    handle to CodCanal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load codificacion

convolucion=CodificacionCanal(codi);
entrada=convolucion;

save codCanal convolucion entrada

disp('termino convolucion')


% --- Executes on button press in CodLinea.
function CodLinea_Callback(hObject, eventdata, handles)
% hObject    handle to CodLinea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load codCanal

codLine=CodManchester(convolucion);

save codLineas codLine

codLine2=CodManchesterGrafica(convolucion);

cla reset; 

axes(handles.axes1);

 stairs(1:(length(convolucion))*2,codLine2);
  xlabel('tiempo ');ylabel('Amplitud');
    title('Codigo de Linea');
    
  ylim([-1.5 1.5]);
  xlim([0 200]);


% --- Executes on button press in ModDig.
function ModDig_Callback(hObject, eventdata, handles)
% hObject    handle to ModDig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load codLineas


modulacion=Modular(codLine);

modula=modulacion;

save modDig modula


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over fuente.
%function pushbutton7_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fuente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Canal.
function Canal_Callback(hObject, eventdata, handles)
% hObject    handle to Canal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load modDig

 ys=handles.relacion;
 SNR=str2num(ys);
 yaw=awgn(modula,SNR*1.5);
 scatterplot(yaw);
 canal=yaw;

save canalOutput canal

% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)


% hObject    handle to grabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fs=4000;
nBits=8; %N?mero de bits por muestra
duration=3; %Tiempo de grabaci?n del audio
recObj= audiorecorder(fs,nBits,1);
disp('Start speaking.')
recordblocking(recObj, duration);
disp('End of Recording.')
play(recObj);


archivo='audioProyecto.wav';
myRecording = getaudiodata(recObj);

audiowrite(archivo,myRecording,4000);%Guarda el audio

data = getaudiodata(recObj, 'uint8');
axes(handles.axes1);

plot(data);%dibujo el audio
dataBin=de2bi(data, 'left-msb');%paso de los decimales del audio a binarios

save variables dataBin data archivo fs myRecording
