function varargout = InputGui(varargin)
% INPUTGUI MATLAB code for InputGui.fig
%      INPUTGUI, by itself, creates a new INPUTGUI or raises the existing
%      singleton*.
%
%      H = INPUTGUI returns the handle to a new INPUTGUI or the handle to
%      the existing singleton*.
%
%      INPUTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INPUTGUI.M with the given input arguments.
%
%      INPUTGUI('Property','Value',...) creates a new INPUTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InputGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InputGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InputGui

% Last Modified by GUIDE v2.5 05-Jun-2014 18:29:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InputGui_OpeningFcn, ...
                   'gui_OutputFcn',  @InputGui_OutputFcn, ...
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


% --- Executes just before InputGui is made visible.
function InputGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InputGui (see VARARGIN)

% Choose default command line output for InputGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes InputGui wait for user response (see UIRESUME)
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
function varargout = InputGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Direct.
function Direct_Callback(hObject, eventdata, handles)
% hObject    handle to Direct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%inputs the filename and its data


%get file name and path
[f,p] = uigetfile(fullfile('/Users/rschneid/Documents/MATLAB/Test Files/','*.*'),'Choose data file');
FileName = fullfile(p,f);
[x,y,FileExtt] = fileparts(FileName);
%save path and file name and extension
setappdata(0,'FileExt', FileExtt);
setappdata(0,'FileName', FileName);
if FileName == 0
    FileName = '';
end
set(handles.PathName, 'String', FileName);
setappdata(0,'Checker',0);





% --- Executes on button press in AnalyzeData.
function AnalyzeData_Callback(hObject, eventdata, handles)
% hObject    handle to AnalyzeData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%assert that the data works somehow
%if not, send an error message in error text.
%ErrorTextBox
%if it works, then execute next GUI

%make a table from data.
%saves the first two values, and removes them from table. data starts on
%line3

if (0==getappdata(0,'Checker'))
    try
    Ext = getappdata(0, 'FileExt');
    FName = getappdata(0, 'FileName');
    %Check if its a .txt file, and show warning
        if strcmpi(Ext, '.txt')
            %get data.
            AT = table2array(readtable(FName, 'ReadVariableNames', false));
            %display a warning
            WarningMessage = 'WARNING: Some .txt extensions might not display properly. To avoid any possible errors, Format / SAVE_AS your data file to one of the perfered extensions: .xls, .xlsx, .csv, .dat';
            set(handles.ErrorTextBox, 'ForegroundColor', [.87, .50, 0]);
            set(handles.ErrorTextBox, 'String', WarningMessage);
            %make a table out of incoming data.
            PN = AT(1,1);
            type = AT(2,1);
            T(1,1) = PN;
            T(2,1) = type;
            T(1,2) = 0;
            T(1,3) = 0;
            T(2,2) = 0;
            T(2,3) = 0;
            Val = 3;
            for r=3:PN+3
                for c=1:3
                    T(r,c) = AT(Val,1);
                    Val = Val + 1;
                end
            end
            %setappdata(0,'PhaseNumber' ,PN);
            %setappdata(0,'PDFType' ,type)
            setappdata(0,'Data' , T);
            set(handles.AnalyzeData, 'String', 'Next');
            set(handles.AnalyzeData, 'FontSize', 14.0);
            setappdata(0,'Checker' , 1);
            %check if its a compatable file
        else if (strcmpi(Ext, '.txt') || strcmpi(Ext, '.csv') || strcmpi(Ext, '.xls') || strcmpi(Ext, '.xlsx') || strcmpi(Ext, '.dat') || strcmpi(Ext, '.xlsb') || strcmpi(Ext, '.xlsm') ||strcmpi(Ext, '.xltm') || strcmpi(Ext, '.xltx') || strcmpi(Ext, '.ods'))
            T = readtable(FName, 'ReadVariableNames', false);
            set(handles.ErrorTextBox, 'ForegroundColor', [0,.9,.7]);
            set(handles.ErrorTextBox, 'String', 'Data is compatable');
            %setappdata(0,'PhaseNumber' ,1);
            %setappdata(0,'PDFType' ,1);
            AT = table2array(T);
            setappdata(0,'Data' ,AT);
            set(handles.AnalyzeData, 'String', 'Next');
            set(handles.AnalyzeData, 'FontSize', 14.0);
            setappdata(0,'Checker' , 1);
            %else, throw a compatability error
            else
            set(handles.ErrorTextBox, 'ForegroundColor', [1,0,0]);
            set(handles.ErrorTextBox, 'String', 'Data not compatable. Acceptable file extensions are .txt, .dat, or .csv for delimited text files, and .xls, .xlsb, .xlsm, .xlsx, .xltm, .xltx, or .ods for spreadsheet files  ');
            end
        end
    catch err
        errorstring = [err.identifier, '. Acceptable file extensions are .txt, .dat, or .csv for delimited text files, and .xls, .xlsb, .xlsm, .xlsx, .xltm, .xltx, or .ods for spreadsheet files. UTF-16 .txt files Do not Function correctly, try reformating to something else.'];
        set(handles.ErrorTextBox, 'ForegroundColor', [1,0,0]);
        set(handles.ErrorTextBox, 'String', errorstring);
    end
else
    rmappdata(0,'Checker');
    rmappdata(0,'FileExt');
    rmappdata(0,'FileName');
    close;
    FormatData();
end
    





function PathName_Callback(hObject, eventdata, handles)
% hObject    handle to PathName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PathName as text
%        str2double(get(hObject,'String')) returns contents of PathName as a double


% --- Executes during object creation, after setting all properties.
function PathName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PathName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
