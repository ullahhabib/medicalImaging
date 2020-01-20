function varargout = gui1(varargin)
% GUI1 MATLAB code for gui1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui1

% Last Modified by GUIDE v2.5 21-Nov-2017 14:22:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui1_OutputFcn, ...
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

%path for the images
imgpath = '..\data\';
%for phantom type
pht1thumb = imread(fullfile(imgpath, 'phantom.png'));
%pht2thumb = imread(fullfile(imgpath, 'phantom2.png'));
axes(handles.axes10); imshow(pht1thumb);
%axes(handles.axes11); imshow(pht2thumb);

set(handles.text_phantomtype, 'String', '1');
handles.inputPhantom = -1;
handles.phantomType = -1;
%showing default image
%input_place_img = imread(fullfile(imgpath, 'input_place.jpg'));
%axes(handles.axes_slicephantom); imshow(input_place_img);

% --- Executes just before gui1 is made visible.
function gui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui1 (see VARARGIN)

% Choose default command line output for gui1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in ImageDifference.
function ImageDifference_Callback(hObject, eventdata, handles)
% hObject    handle to ImageDifference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[hObject, eventdata, handles] = gui2(hObject, eventdata, handles);

% --- Executes on button press in makePhantom.
function makePhantom_Callback(hObject, eventdata, handles)
% hObject    handle to makePhantom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ph
ph = phantom(125);
d = 95;
F = fanbeam(ph,d);
I = ifanbeam(F,d);
axes(handles.axes13);
imshow(ph);
imwrite(ph,'makePhantom.jpg');

% --- Executes on button press in GrayImage.
function GrayImage_Callback(hObject, eventdata, handles)
% hObject    handle to GrayImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ph 
J = filter2(fspecial('sobel'),ph);
I=J;
K=mat2gray(I);
axes(handles.axes6);
imshow(K);
imwrite(K,'intensity.jpg');

% --- Executes on slider movement.
function Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ph 
val=0.01*get(handles.Slider, 'Value')-0.01;
imbright=ph+val;
axes(handles.axes5);
imshow(imbright);

% --- Executes during object creation, after setting all properties.
function Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor',[.9 .9 .9]);
end 

% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.axes5);
Image = frame2im(F);
imwrite(Image, 'Contrast.jpg')

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radioPhantom1.
function radioPhantom1_Callback(hObject, eventdata, handles)
% hObject    handle to radioPhantom1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioPhantom1
state = get(hObject, 'Value');
    status1 = str2double(get(handles.radioPhantom1,'Value'));

    'wait here';

% --- Executes on button press in radioPhantom2.
function radioPhantom2_Callback(hObject, eventdata, handles)
% hObject    handle to radioPhantom2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioPhantom2


% --- Executes on slider movement.
function height_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to height_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 sliderValue = get(hObject, 'Value');
 set(handles.textHSlideValue, 'String', num2str(floor(sliderValue)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function height_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to height_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function width_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to width_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  sliderValue = get(hObject, 'Value');
    set(handles.textWSlideValue, 'String', num2str(floor(sliderValue)));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function width_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to width_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in createPhantom.
function createPhantom_Callback(hObject, eventdata, handles)
% hObject    handle to createPhantom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    DEFAULT_PHANTOMSIZE = [256 256];
    sliderHValue = get(handles.height_Slider,'Value');
    sliderWValue = get(handles.width_Slider,'Value');
    
    if(sliderHValue == 0) sliderHValue = 1; end
    if(sliderWValue == 0) sliderWValue = 1; end
    
    barsize = floor([sliderHValue*DEFAULT_PHANTOMSIZE(1)/100  sliderWValue*DEFAULT_PHANTOMSIZE(2)/100]);
    
    if (get(handles.radioPhantom1, 'Value') ~= 0)
        type = 1;
    elseif (get(handles.radioPhantom2, 'Value') ~= 0)
        type = 2;
    else
        'You have to choose one type';
        type = -1;
    end
    
    if type ~= -1
        myphantom = makephantom(type, DEFAULT_PHANTOMSIZE, barsize); 

        %display:
        set(handles.text_phantomtype, 'String', sprintf('%d', type));
        set(handles.text_phantomtype, 'Visible', 'on');

        axes(handles.axes_slicephantom); 
        a=set(handles.axes_slicephantom);
        imshow(myphantom);
        guidata(hObject, handles);    

        % create structure of handles add some additional data
        handles.phantomType = type;
        handles.inputPhantom = myphantom; 
        % save the structure
        guidata(hObject,handles);
    end;


%function selectPhantom_CreateFcn(hObject, eventdata, handles)

% --- Executes when selected object is changed in selectPhantom.
function selectPhantom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in selectPhantom 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%retrieve GUI data, i.e. the handles structure
handles = guidata(hObject); 
 
switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'radioPhantom1'
      set(handles.width_Slider,'enable','on');
      set(handles.height_Slider,'enable','on');

    case 'radioPhantom2'
      set(handles.width_Slider,'enable','off');
      set(handles.height_Slider,'enable','off');
    otherwise

end
%updates the handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DEFAULT_PHANTOMSIZE = [256 256];
    sliderValue = get(handles.Slider,'Value');    
    if(sliderValue == 0) sliderValue = 1; end
    
    barsize = floor([sliderValue*DEFAULT_PHANTOMSIZE(1)/100]);
    
    if type ~= -1
        myphantom = input(type, DEFAULT_PHANTOMSIZE, barsize); 

        %display:
        set(handles.text_phantomtype, 'String', sprintf('%d', type));
        set(handles.text_phantomtype, 'Visible', 'on');

        axes(handles.axes9); 
        a=set(handles.axes9);
        imshow(myphantom);
        guidata(hObject, handles);    

        % create structure of handles add some additional data
        handles.phantomType = type;
        handles.inputPhantom = myphantom; 
        % save the structure
        guidata(hObject,handles);
    end


% --- Executes on button press in loadResult.
function loadResult_Callback(hObject, eventdata, handles)
% hObject    handle to loadResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 myCtReconstruction



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
