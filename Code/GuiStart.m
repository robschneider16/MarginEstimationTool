function varargout = GuiStart(varargin)
% GUISTART MATLAB code for GuiStart.fig
%      GUISTART, by itself, creates a new GUISTART or raises the existing
%      singleton*.
%
%      H = GUISTART returns the handle to a new GUISTART or the handle to
%      the existing singleton*.
%
%      GUISTART('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUISTART.M with the given input arguments.
%
%      GUISTART('Property','Value',...) creates a new GUISTART or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GuiStart_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GuiStart_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GuiStart

% Last Modified by GUIDE v2.5 05-Jun-2014 17:07:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GuiStart_OpeningFcn, ...
                   'gui_OutputFcn',  @GuiStart_OutputFcn, ...
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


% --- Executes just before GuiStart is made visible.
function GuiStart_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GuiStart (see VARARGIN)

% Choose default command line output for GuiStart
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GuiStart wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Display an image in the top right
A = imread('JPLLogo.png');
axes(handles.axes1);
imshow(A);
% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);

    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);





% --- Outputs from this function are returned to the command line.
function varargout = GuiStart_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ManualInput.
function ManualInput_Callback(hObject, eventdata, handles)
% hObject    handle to ManualInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    close;
    GUI3();
catch err
    setappdata( 0, 'Error', char(err));
    ErrorWindow();
end
% --- Executes on button press in Import.
function Import_Callback(hObject, eventdata, handles)
% hObject    handle to Import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    close;
    InputGui();
catch err
    setappdata( 0, 'Error', char(err));
    ErrorWindow();
end
