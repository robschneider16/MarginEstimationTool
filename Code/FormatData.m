function varargout = FormatData(varargin)
% FORMATDATA MATLAB code for FormatData.fig
%      FORMATDATA, by itself, creates a new FORMATDATA or raises the existing
%      singleton*.
%
%      H = FORMATDATA returns the handle to a new FORMATDATA or the handle to
%      the existing singleton*.
%
%      FORMATDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORMATDATA.M with the given input arguments.
%
%      FORMATDATA('Property','Value',...) creates a new FORMATDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FormatData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FormatData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FormatData

% Last Modified by GUIDE v2.5 12-Jun-2014 08:57:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FormatData_OpeningFcn, ...
                   'gui_OutputFcn',  @FormatData_OutputFcn, ...
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


% --- Executes just before FormatData is made visible.
function FormatData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datatable (see GUIDATA)
% varargin   command line arguments to FormatData (see VARARGIN)

% Choose default command line output for FormatData
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FormatData wait for user response (see UIRESUME)
% uiwait(handles.figure1);
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




%pn = getappdata(0, 'PhaseNumber');
%ty = getappdata(0, 'PDFType')
%stopnum = pn + 1;
%set(handles.EndRow, 'String', num2str(stopnum));
%set(handles.PDFType, 'String', num2str(ty));
dt = getappdata(0, 'Data');
set(handles.DataTable, 'Data' , dt);






% --- Outputs from this function are returned to the command line.
function varargout = FormatData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datatable (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function StartRow_Callback(hObject, eventdata, handles)
% hObject    handle to StartRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datatable (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartRow as text
%        str2double(get(hObject,'String')) returns contents of StartRow as a double


% --- Executes during object creation, after setting all properties.
function StartRow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PDFType_Callback(hObject, eventdata, handles)
% hObject    handle to PDFType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datatable (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PDFType as text
%        str2double(get(hObject,'String')) returns contents of PDFType as a double


% --- Executes during object creation, after setting all properties.
function PDFType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PDFType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FixedUnitCol_Callback(hObject, eventdata, handles)
% hObject    handle to FixedUnitCol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datatable (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FixedUnitCol as text
%        str2double(get(hObject,'String')) returns contents of FixedUnitCol as a double


% --- Executes during object creation, after setting all properties.
function FixedUnitCol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FixedUnitCol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LowerBoundCol_Callback(hObject, eventdata, handles)
% hObject    handle to LowerBoundCol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datatable (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LowerBoundCol as text
%        str2double(get(hObject,'String')) returns contents of LowerBoundCol as a double


% --- Executes during object creation, after setting all properties.
function LowerBoundCol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LowerBoundCol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function UpperBoundCol_Callback(hObject, eventdata, handles)
% hObject    handle to UpperBoundCol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datatable (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UpperBoundCol as text
%        str2double(get(hObject,'String')) returns contents of UpperBoundCol as a double


% --- Executes during object creation, after setting all properties.
function UpperBoundCol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UpperBoundCol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Compute.
function Compute_Callback(hObject, eventdata, handles)
% hObject    handle to Compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datatable (see GUIDATA)

BoxChecked=false;

UnfilteredData = get(handles.DataTable, 'Data');
[sx,sy] = size(UnfilteredData);
delimiter = '-';
y = isnumeric(UnfilteredData);
if y==0
    for x=1:sx
        for y=1:sy
            TempVal = UnfilteredData(x,y);
            TempVal = strrep(TempVal, 'weeks', '');
            TempVal = strrep(TempVal, 'week', '');
            TempVal = strrep(TempVal, 'months', '');
            TempVal = strrep(TempVal, 'month', '');
            TempVal = strrep(TempVal, 'years', '');
            TempVal = strrep(TempVal, 'year', '');
            TempVal = strrep(TempVal, 'hours', '');
            TempVal = strrep(TempVal, 'hour', '');
            TempVal = strrep(TempVal, 'days', '');
            TempVal = strrep(TempVal, 'day', '');

            TempVal = strrep(TempVal, '$', '');

            TempVal = strrep(TempVal, 'Weeks', '');
            TempVal = strrep(TempVal, 'Week', '');
            TempVal = strrep(TempVal, 'Months', '');
            TempVal = strrep(TempVal, 'Month', '');
            TempVal = strrep(TempVal, 'Years', '');
            TempVal = strrep(TempVal, 'Year', '');
            TempVal = strrep(TempVal, 'Hours', '');
            TempVal = strrep(TempVal, 'Hour', '');
            TempVal = strrep(TempVal, 'Days', '');
            TempVal = strrep(TempVal, 'Day', '');

            TempVal = strrep(TempVal, 'k', '000');
            TempVal = strrep(TempVal, 'K', '000');
            TempVal = strrep(TempVal, 'm', '000000');
            TempVal = strrep(TempVal, 'M', '000000');
            TempVal = strrep(TempVal, 'B', '000000000');
            TempVal = strrep(TempVal, 'b', '000000000');
            TempVal = strrep(TempVal, ' ', ''); 
            TempVal = strrep(TempVal, ',', '');

            TempData(x,y) = TempVal;
        end
    end

end

try
    StartRow = str2double(get(handles.StartRow, 'String'));
    StopRow = str2double(get(handles.EndRow, 'String'));
    NumberOfPhases = StopRow - StartRow+1 ;
    assert(NumberOfPhases >= 1);
    FCol = str2double(get(handles.FixedUnitCol, 'String'));
    LCol = str2double(get(handles.LowerBoundCol, 'String'));
    UCol = str2double(get(handles.UpperBoundCol, 'String'));
    if LCol==UCol
        BoxSelected = true;
    else
        BoxSelected = false;
    end
    Type = 1;
    if y==1
        TempData = get(handles.DataTable, 'Data');
        for i=StartRow:StopRow
            CurrentNewRow = i-StartRow+1;
            FormatedTable(CurrentNewRow,1) = TempData(i, FCol);
            FormatedTable(CurrentNewRow,2) = Type;
            FormatedTable(CurrentNewRow,3) = TempData(i, LCol);
            FormatedTable(CurrentNewRow,4) = TempData(i, UCol);
        end
    else
        if BoxSelected == true

            for i=StartRow:StopRow
                CurrentNewRow = i-StartRow+1;
                FormatedTable(CurrentNewRow,1) = str2double(TempData(i, FCol));
                FormatedTable(CurrentNewRow,2) = Type; 
                s = char(TempData(i,LCol));
                a = strsplit(s, delimiter);
                FormatedTable(CurrentNewRow,3) = str2double(a(1));
                FormatedTable(CurrentNewRow,4) = str2double(a(2));
            end
        else
            for i=StartRow:StopRow
                CurrentNewRow = i-StartRow+1;
                FormatedTable(CurrentNewRow,1) = str2double(TempData(i, FCol));
                FormatedTable(CurrentNewRow,2) = Type;
                FormatedTable(CurrentNewRow,3) = str2double(TempData(i, LCol));
                FormatedTable(CurrentNewRow,4) = str2double(TempData(i, UCol));
            end
        end
    end
    setappdata(0, 'Data', FormatedTable);
    setappdata(0, 'PhaseNumber', NumberOfPhases);
    setappdata(0, 'PDFType', Type);
    close;
    GUI2();
    SetupWindow();
catch err
    setappdata(0, 'Error', 'Please check that the Parameters are set correctly.  ');
    ErrorWindow(); 
end




function EndRow_Callback(hObject, eventdata, handles)
% hObject    handle to EndRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datatable (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndRow as text
%        str2double(get(hObject,'String')) returns contents of EndRow as a double


% --- Executes during object creation, after setting all properties.
function EndRow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndRow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
