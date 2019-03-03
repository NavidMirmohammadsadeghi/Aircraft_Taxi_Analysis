
function varargout = TaxiEventExtraction(varargin)
% TaxiEventExtraction MATLAB code for TaxiEventExtraction.fig
%      TaxiEventExtraction, by itself, creates a new TaxiEventExtraction or raises the existing
%      singleton*.
%
%      H = TaxiEventExtraction returns the handle to a new TaxiEventExtraction or the handle to
%      the existing singleton*.
%
%      TaxiEventExtraction('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TaxiEventExtraction.M with the given input arguments.
%
%      TaxiEventExtraction('Property','Value',...) creates a new TaxiEventExtraction or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TaxiEventExtraction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TaxiEventExtraction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TaxiEventExtraction

% Last Modified by GUIDE v2.5 04-Jul-2017 10:39:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TaxiEventExtraction_OpeningFcn, ...
    'gui_OutputFcn',  @TaxiEventExtraction_OutputFcn, ...
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


% --- Executes just before TaxiEventExtraction is made visible.
function TaxiEventExtraction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TaxiEventExtraction (see VARARGIN)

% Choose default command line output for TaxiEventExtraction
handles.output = hObject;
theImage = imread('FAA.jpg');
set(gca,'NextPlot','add');
 % Use actual variable names from your program!
Im1=imshow(theImage,'Parent',handles.axes6);
set(Im1,'hittest','off') 
hold on;

Image2 = imread('VT_Invent_The Future.jpg');
set(gca,'NextPlot','add');

Im2=imshow(Image2,'Parent',handles.axes7);
set(Im2,'hittest','off')
hold on;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TaxiEventExtraction wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = TaxiEventExtraction_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]      = uigetfile({'*.csv';'*.xlsx'});
handles.Batch_Mode_Files = [];
handles.pathname         = [pathname,filename];
guidata(hObject,handles)



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
contents = cellstr(get(hObject,'String'));
Value    = get(hObject,'Value');
handles.Airport_Name = contents{get(hObject,'Value')};
handles.Value        = Value;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Output_folder_name = uigetdir;
guidata(hObject,handles)

% function edit2_Callback(Edit_Button, eventdata, handles)
% % hObject    handle to edit2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
% % Hints: get(hObject,'String') returns contents of edit2 as text
% %        str2double(get(hObject,'String')) returns contents of edit2 as a double
% t = handles.staticText1;
% set(Edit_Button, 'String', sprintf('%g', t));
% drawnow;

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
AirportName= handles.Airport_Name;
load([ AirportName '.mat']);

hold on;

set(gca,'NextPlot','add');

axes(handles.axes4);

for i =1:1:length(Airport);
    if strcmp(Airport(i,1).element_feature_type,'aixm_TaxiwayElement')
        fill(Airport(i, 1).extent{1,1}(:,1),Airport(i,1).extent{1,1}(:,2),'w');
    end;
    if strcmp(Airport(i,1).element_feature_type,'aixm_RunwayElement');
        fill(Airport(i, 1).extent{1,1}(:,1),Airport(i,1).extent{1,1}(:,2),'y');
    end;
    if strcmp(Airport(i,1).element_feature_type,'aixm_ApronElement');
        fill(Airport(i, 1).extent{1,1}(:,1),Airport(i,1).extent{1,1}(:,2),'r');
    end;
    hold on;
end

Value = handles.Value;

switch Value
    case 2
        axis([-84.45 -84.405 33.62 33.66]);
    case 3
        axis([-87.94 -87.87 41.95 42.01]);
    case 4
        axis([-73.83 -73.75 40.62 40.665]);
    case 5
        axis([-80.97 -80.92 35.195 35.23]);
    case 6
        axis([-95.37 -95.3 29.95 30.01]);
    case 7
        axis([-104.74 -104.6 39.82 39.9]);
end


hold on;

if isempty(handles.Batch_File_Number)==1
    
    Airport_Report = handles.Results;
    
    Real_Flights   = handles.Real_Flights;
    
    Ops_Type       = Airport_Report(handles.Index_Plot).Operation;
    
    S1 = scatter(Real_Flights(Airport_Report(handles.Index_Plot).Index_Main_File).Track.longitude,Real_Flights(Airport_Report(handles.Index_Plot).Index_Main_File).Track.latitude);
    
    if isempty(Airport_Report(handles.Index_Plot).Enter_Rwy_Lat)==0
        
        hold on;
        
        E1=scatter(Airport_Report(handles.Index_Plot).Enter_Rwy_Long,Airport_Report(handles.Index_Plot).Enter_Rwy_Lat,'filled','b');
        
        hold on;
        
        T1=scatter(Airport_Report(handles.Index_Plot).On_Off_Long,Airport_Report(handles.Index_Plot).On_Off_Lat,'filled','g');
        
        hold on;
        
        X1=scatter(Airport_Report(handles.Index_Plot).Exit_Rwy_Long,Airport_Report(handles.Index_Plot).Exit_Rwy_Lat,'filled','r');
        
        if strcmp(Ops_Type,'A')==1
            
            legend([S1 E1 T1 X1],{'Arrival Track','First Point in Runway','Touchdown/ WheelsOff Point','Exit Point'},'FontSize',14);
            
        elseif strcmp(Ops_Type,'D')==1
            
            legend([S1 E1 T1 X1],{'Departure Track','First Point in Runway','Touchdown/ WheelsOff Point','Exit Point'},'FontSize',14);
            
        end %if strcmp(Ops_Type,'A')==1
    end %if isempty(Airport_Report(handles.Index_Plot).Enter_Rwy_Lat)==0
    
else %if isempty(handles.Batch_File_Number)==1
    
    Airport_Report = handles.Results(handles.Batch_File_Number).result;
    
    Real_Flights   = handles.Real_Flights(handles.Batch_File_Number).First_Output;
    
    Ops_Type       = Airport_Report(handles.Index_Plot).Operation;
    
    S1 = scatter(Real_Flights(Airport_Report(handles.Index_Plot).Index_Main_File).Track.longitude,Real_Flights(Airport_Report(handles.Index_Plot).Index_Main_File).Track.latitude);
    
    if isempty(Airport_Report(handles.Index_Plot).Enter_Rwy_Lat)==0
        
        hold on;
        
        E1=scatter(Airport_Report(handles.Index_Plot).Enter_Rwy_Long,Airport_Report(handles.Index_Plot).Enter_Rwy_Lat,'filled','b');
        
        hold on;
        
        T1=scatter(Airport_Report(handles.Index_Plot).On_Off_Long,Airport_Report(handles.Index_Plot).On_Off_Lat,'filled','g');
        
        hold on;
        
        X1=scatter(Airport_Report(handles.Index_Plot).Exit_Rwy_Long,Airport_Report(handles.Index_Plot).Exit_Rwy_Lat,'filled','r');
        
        if strcmp(Ops_Type,'A')==1
            
            legend([S1 E1 T1 X1],{'Arrival Track','First Point in Runway','Touchdown/ WheelsOff Point','Exit Point'},'FontSize',14);
            
        elseif strcmp(Ops_Type,'D')==1
            
            legend([S1 E1 T1 X1],{'Departure Track','First Point in Runway','Touchdown/ WheelsOff Point','Exit Point'},'FontSize',14);
            
        end %if strcmp(Ops_Type,'A')==1
    end %if isempty(Airport_Report(handles.Index_Plot).Enter_Rwy_Lat)==0
    
end %if isempty(handles.Batch_File_Number)==1








function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
Output_Name = get(hObject,'String');
if isempty(Output_Name)
    set(hObject, 'String', 'Enter Output Name');
    errordlg('Enter Output Name!','Error');
end
handles.Outputname = Output_Name;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
Flight_key = str2double(get(hObject,'String'));

if isempty(handles.Batch_File_Number)==1
    Index_Plot_Airport_Report = find(Flight_key==handles.Flight_Key);
    
    handles.Index_Plot        = Index_Plot_Airport_Report;
else
    Result                    = handles.Results(handles.Batch_File_Number).result;
    handles.Flight_Key        = [Result.Flight_Key];
    Index_Plot_Airport_Report = find(Flight_key==handles.Flight_Key);
    
    handles.Index_Plot        = Index_Plot_Airport_Report;
end

guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% This m-file parses the ASDE-X data
% Date: 12/30/08
% modified and editted: 1/21/17
%%% Navid Mirmohammadsadeghi
%%in line 184 where I check that we are considering the real flights or
%%ground movements, because KDEN is very high change the criteria from 10%
%%of the first altitude to the 1% of the altitude

% clc;
%
% clear;
if isempty(handles.Batch_Mode_Files)==1
    
    Batch_Mode = 0;
    
    input_directory = handles.pathname;
    
    Airport_Name    = handles.Airport_Name;
    
    Output_Name     = handles.Outputname;
    
    warning off;
    
    % input_directory='C:\Users\Navid\Documents\DATA for Individual Runs\ASDEX\IAH+ASDEX\2015\201507\20150716';
    % Open input file
    % input_directory = handles.pathname;
    % Input_File_ID = fopen([input_directory,'\IFF_IAH+ASDEX_20150716_060000_86350_FILTERED.csv'],'r'); %filePointer
    Input_File_ID   = fopen(input_directory,'r');
    
    Airport_Name    = Airport_Name;
    
    % Define variables
    FlightCounter = 0;
    Base_Date_Number = datenum('01/01/1970'); % In number of days since 01/01/0000
    
    % Pre allocating
    
    
    
    % Read file
    while(feof(Input_File_ID) == 0)
        
        % Do not read next line if current line is Header
        if FlightCounter == 0 || Record_Type ~= '2'
            aline = fgetl(Input_File_ID); % Get line
            Record_Type = aline(1);
        end
        
        if Record_Type == '2' % New Flight detected
            
            % FLight Counter
            %         if mod(FlightCounter, 100) == 0
            %             disp(['Number of flights processed: ', num2str(FlightCounter)]);
            %         end
            FlightCounter = FlightCounter + 1; % Counts the number of flights
            %handles.staticText1= FlightCounter;
            %edit2_Callback(hObject, eventdata, handles)
            %         handles.Counter = FlightCounter;
            h = hObject;
            % set(h , 'Units' , 'Normalized' , 'position' , [0.4 0.4 0.2 0.2]);
            % h1 = uicontrol(h , 'style' , 'text' , 'Units' , 'Normalized'...
            %                , 'position' , [0.4 0.4 0.2 0.2] , 'string' , 'Output');
            
            set(h , 'string' , ['Processed Flight:' num2str(FlightCounter)]);
            %pause(0.5)
            drawnow;
            
            guidata(hObject,handles)
            %         waitbar(handles.Counter);
            % ------------------------------------------------------
            % Header Record: Record Type 2
            % ------------------------------------------------------
            aline_split = textscan(aline, '%d%f%d%d%s%*s%*s%s%*d%s%*s%*s%s\n', 'delimiter', ',');
            
            Header.recType    = aline_split{1};
            Header.recTime    = aline_split{2};
            Header.fltKey     = aline_split{3};
            Header.bcnCode    = aline_split{4};
            Header.cid        = char(aline_split{5});
            %Header.source     = char(aline_split{6});
            %Header.msgType    = char(aline_split{7});
            Header.acId       = char(aline_split{6});
            %Header.recTypeCat = aline_split{9};
            Header.acType     = char(aline_split{7});
            %Header.orig       = char(aline_split{11});
            %Header.dest       = char(aline_split{12});
            Header.opsType    = char(aline_split{8});
            
            % ------------------------------------------------------
            % FlightPlan Record: Record Type 4
            % ------------------------------------------------------
            aline = fgetl(Input_File_ID); % Read line
            Record_Type = aline(1);
            if Record_Type ~= '4'
                disp(['Error: Record Type 4 Expected. FlightKey: ', num2str(Header.fltKey)]);
                pause;
            end
            %         aline_split = textscan(aline, '%d%f%d%d%s%s%s%s%d%s%s%s%c%f%f%s%s%s%d%c%c%c%s%d%c%d%s\n', 'delimiter', ',');
            
            %         FlightPlan.recType              = aline_split{1};
            %         FlightPlan.recTime              = aline_split{2};
            %         %FlightPlan.fltKey               = aline_split{3};
            %         %FlightPlan.bcnCode              = aline_split{4};
            %         %FlightPlan.cid                  = char(aline_split{5});
            %         %FlightPlan.source               = char(aline_split{6});
            %         %FlightPlan.msgType              = char(aline_split{7});
            %         FlightPlan.acId                 = char(aline_split{3});
            %         %FlightPlan.recTypeCat           = aline_split{9};
            %         FlightPlan.acType               = char(aline_split{4});
            %         %FlightPlan.orig                 = char(aline_split{11});
            %         %FlightPlan.dest                 = char(aline_split{12});
            %         %FlightPlan.altCode              = char(aline_split{13});
            %        %FlightPlan.alt                  = aline_split{14};
            %        %FlightPlan.maxAlt               = aline_split{15};
            %         %FlightPlan.altString            = char(aline_split{16});
            %         %FlightPlan.requestedAltString   = char(aline_split{17});
            %         %FlightPlan.route                = char(aline_split{18});
            %         %FlightPlan.estTime              = aline_split{19};
            %         %FlightPlan.fltCat               = char(aline_split{20});
            %         %FlightPlan.perfCat              = char(aline_split{21});
            %         FlightPlan.opsType              = char(aline_split{5});
            %         %FlightPlan.equipList            = char(aline_split{23});
            %         %FlightPlan.coordinationTime     = aline_split{24};
            %         %FlightPlan.coordinationTimeType = char(aline_split{25});
            %         %FlightPlan.leaderDir            = aline_split{26};
            %         %FlightPlan.scratchPad           = char(aline_split{27});
            
            % ------------------------------------------------------
            % Header Record: Record Type 2
            % ------------------------------------------------------
            PDARS(FlightCounter).Header = Header;
            
            % Change time format from seconds from 01/01/1970 to actual
            % date and time
            %         Number_Of_Days = PDARS(FlightCounter).Header.recTime / (24 * 3600); % Number of days since 01/01/1970 for track point
            %         Actual_Date_In_Days = Base_Date_Number + Number_Of_Days;
            %         Actual_Date_Formatted = datestr(Actual_Date_In_Days, 'yyyy-mm-dd'); % Date formatted yyyy-mm-dd
            %         Actual_Hours_Formatted = datestr(Actual_Date_In_Days, 'HH:MM:SS'); % Time formatted HH:MM:SS
            %         PDARS(FlightCounter).Header.recTime_Formatted_Date = Actual_Date_Formatted;
            %         PDARS(FlightCounter).Header.recTime_Formatted_Time = Actual_Hours_Formatted;
            
            % ------------------------------------------------------
            % FlightPlan Record: Record Type 4
            % ------------------------------------------------------
            %         PDARS(FlightCounter).FlightPlan = FlightPlan;
            
            % Change time format from seconds from 01/01/1970 to actual
            % date and time
            %         Number_Of_Days = PDARS(FlightCounter).FlightPlan.recTime / (24 * 3600); % Number of days since 01/01/1970 for track point
            %         Actual_Date_In_Days = Base_Date_Number + Number_Of_Days;
            %         Actual_Date_Formatted = datestr(Actual_Date_In_Days, 'yyyy-mm-dd'); % Date formatted yyyy-mm-dd
            %         Actual_Hours_Formatted = datestr(Actual_Date_In_Days, 'HH:MM:SS'); % Time formatted HH:MM:SS
            %         PDARS(FlightCounter).FlightPlan.recTime_Formatted_Date = Actual_Date_Formatted;
            %         PDARS(FlightCounter).FlightPlan.recTime_Formatted_Time = Actual_Hours_Formatted;
            
            % ------------------------------------------------------
            % Track Record: Record Type 3
            % ------------------------------------------------------
            % Sometimes there are more than 1 flight plan record. The first one
            % is recorded and the following ones are skipped.
            while Record_Type == '4'
                aline = fgetl(Input_File_ID); % Get next Record Type
                Record_Type = aline(1);
            end
            TrackRecord = 0;
            while Record_Type == '3' % Loop through the position records of that flight
                
                % ------------------------------------------------------
                % Track Record: Record Type 3
                % ------------------------------------------------------
                TrackRecord = TrackRecord + 1;
                aline_split = textscan(aline, '%*d%f%*d%*d%*s%*s%*s%*s%*d%f%f%f%*s%*d%*f%*f%f%f%*f%*f%*c%*c%*s%*c%*d%*s%*d\n', 'delimiter', ',');
                
                %PDARS(FlightCounter).Track.recType(TrackRecord)        = aline_split{1};
                PDARS(FlightCounter).Track.recTime(TrackRecord)        = aline_split{1};
                %PDARS(FlightCounter).Track.fltKey(TrackRecord)         = aline_split{3};
                %PDARS(FlightCounter).Track.bcnCode(TrackRecord)        = aline_split{4};
                %PDARS(FlightCounter).Track.cid(TrackRecord)            = aline_split{5};
                %PDARS(FlightCounter).Track.source(TrackRecord)         = aline_split{6};
                %PDARS(FlightCounter).Track.msgType(TrackRecord)        = aline_split{7};
                %PDARS(FlightCounter).Track.acId(TrackRecord)           = aline_split{2};
                %PDARS(FlightCounter).Track.recTypeCat(TrackRecord)     = aline_split{9};
                PDARS(FlightCounter).Track.latitude(TrackRecord)       = aline_split{2};
                PDARS(FlightCounter).Track.longitude(TrackRecord)      = aline_split{3};
                PDARS(FlightCounter).Track.alt(TrackRecord)            = aline_split{4};
                %PDARS(FlightCounter).Track.posCode(TrackRecord)        = aline_split{13};
                %PDARS(FlightCounter).Track.significance(TrackRecord)   = aline_split{14};
                %PDARS(FlightCounter).Track.latitudeAccur(TrackRecord)  = aline_split{15};
                %PDARS(FlightCounter).Track.longitudeAccur(TrackRecord) = aline_split{16};
                PDARS(FlightCounter).Track.altAccur(TrackRecord)       = aline_split{5};
                PDARS(FlightCounter).Track.groundSpeed(TrackRecord)    = aline_split{6};
                %PDARS(FlightCounter).Track.course(TrackRecord)         = aline_split{19};
                %PDARS(FlightCounter).Track.rateOfClimb(TrackRecord)    = aline_split{20};
                %
                %             PDARS(FlightCounter).Track.leaderDir(TrackRecord)      = aline_split{25};
                %             PDARS(FlightCounter).Track.scratchpad(TrackRecord)     = aline_split{26};
                %             PDARS(FlightCounter).Track.msawInhibitInd(TrackRecord) = aline_split{27};
                
                % Change time format from seconds from 01/01/1970 to actual
                % date and time
                %             Number_Of_Days = aline_split{2} / (24 * 3600); % Number of days since 01/01/1970 for track point
                %             Actual_Date_In_Days = Base_Date_Number + Number_Of_Days;
                %             Actual_Date_Formatted = datestr(Actual_Date_In_Days, 'yyyy-mm-dd'); % Date formatted yyyy-mm-dd
                %             Actual_Hours_Formatted = datestr(Actual_Date_In_Days, 'HH:MM:SS'); % Time formatted HH:MM:SS
                %             PDARS(FlightCounter).Track.recTime_Formatted_Date(TrackRecord) = {Actual_Date_Formatted};
                %             PDARS(FlightCounter).Track.recTime_Formatted_Time(TrackRecord) = {Actual_Hours_Formatted};
                
                % Read Line
                aline = fgetl(Input_File_ID); % Get Record Type 3
                Record_Type = aline(1);
                
                % Extracting Real Flights
                Average_alt = mean(PDARS(FlightCounter).Track.alt);
                if abs(PDARS(FlightCounter).Track.alt(1)-Average_alt)<= 0.2%0.1*PDARS(FlightCounter).Track.alt(1)
                    PDARS(FlightCounter).RealFlights=[];
                else
                    PDARS(FlightCounter).RealFlights=PDARS(FlightCounter).Track;
                end
                
            end % while Record_Type == 3
        end % if Record_Type == 2 % New Flight detected
    end % while fid ~= eofPDATS
    
    %% Making a new file just for actual flights
    Length_PDARS=length(PDARS);
    
    for lp=1:Length_PDARS
        if isempty(PDARS(lp).RealFlights)==1
            RealFlights(lp).Header=[];
            %RealFlights(lp).FlightPlan=[];
            RealFlights(lp).Track=[];
        else
            RealFlights(lp).Header=PDARS(lp).Header;
            %RealFlights(lp).FlightPlan=PDARS(lp).FlightPlan;
            RealFlights(lp).Track=PDARS(lp).Track;
        end
    end
    % % % % % % empty_elems = arrayfun(@(s) all(structfun(@isempty,s)), A.B);
    empty_cells=arrayfun(@(s) any(structfun(@isempty,s)),RealFlights);
    Real_Flights_Final=RealFlights(~empty_cells);
    % Close open files
    fclose('all');
    
    First_Output = Real_Flights_Final;
    %This Scetion will separate arrivals and departures
    % RFL= length(Real_Flights_Final);
    %
    % counter2=0;
    %
    % for i=1:RFL
    %     if mod(counter2,100) == 0
    %         disp(['Number of Categorized Flights:' num2str(counter2)]);
    %     end
    %
    %     if strcmp(Real_Flights_Final(i).Header.opsType,'A') == 1
    %         Real_Flights_Arrivals(i)=Real_Flights_Final(i);
    %     elseif strcmp(Real_Flights_Final(i).Header.opsType,'D') == 1
    %         Real_Flights_Departures(i)=Real_Flights_Final(i);
    %     else
    %         Real_Flights_Others(i)=Real_Flights_Final(i);
    %     end
    %     counter2=counter2+1;
    % end
    %
    % %Removing the empty cells
    % empty_cells2=arrayfun(@(s) any(structfun(@isempty,s)),Real_Flights_Arrivals);
    % Real_Flights_Arrivals=Real_Flights_Arrivals(~empty_cells2);
    %
    % empty_cells3=arrayfun(@(s) any(structfun(@isempty,s)),Real_Flights_Departures);
    % Real_Flights_Departures=Real_Flights_Departures(~empty_cells3);
    %
    % empty_cells4=arrayfun(@(s) any(structfun(@isempty,s)),Real_Flights_Others);
    % Real_Flights_Others=Real_Flights_Others(~empty_cells4);
    %
    
    % % Compute speed between two track points
    % disp('Calculate Speed Between Points...');
    % for i = 1:FlightCounter
    %
    %     if mod(i, 100) == 0
    %         disp(['Number of flights processed: ', num2str(i), '/', num2str(FlightCounter)]);
    %     end
    %
    %     Number_Of_TrackPoints = length(PDARS(i).Track.latitude);
    %     for j = 1:Number_Of_TrackPoints - 1
    %
    %         TimeElapsed = PDARS(i).Track.recTime(j + 1) - PDARS(i).Track.recTime(j); % Elapsed Time in seconds
    %         Dist_nm = deg2nm(distance(PDARS(i).Track.latitude(j), PDARS(i).Track.longitude(j), PDARS(i).Track.latitude(j + 1), PDARS(i).Track.longitude(j + 1)));
    %         Speed_knots = round(Dist_nm / (TimeElapsed / 3600)); % speed in knots (nautical mph)
    %         PDARS(i).Track.Speed_knots(j) = Speed_knots;
    %
    %     end %  for j = 1:Number_Of_TrackPoints - 1
    % end % for i = 1:FlightCounter
    
    %Test for running the event extraction model
    %Airport_Report_File = Main_PDARS_Reader(Real_Flights_Final,AirportName);
    %% Saving the Output
    % Output_Dir = input_directory;
    % save([Output_Dir,'\' Airport_Name '_One_day.mat'],'Real_Flights_Final')
    % save([input_directory,'\' Airport_Name '_One_day_Arrivals.mat'],'Real_Flights_Arrivals')
    % save([input_directory,'\' Airport_Name '_One_day_Departures.mat'],'Real_Flights_Departures')
    % save([input_directory,'\' Airport_Name '_One_day_Others.mat'],'Real_Flights_Others')
    % save testone
    
    
    Output_Dir      = handles.Output_folder_name;
    
    Result          = Main_PDARS_Reader(First_Output,Airport_Name,Output_Dir,Output_Name,Batch_Mode);
    
else %if isempty(handles.Batch_Mode)==0
    
    Batch_Mode  = 1;
    Batch_Path  = handles.Batch_Mode_Files;
    Input_Dir   = handles.Batch_Mode_Path;
    
    for BL=1:length(Batch_Path)
        
        input_directory = Batch_Path(BL).name;
        
        Output_Name     = Batch_Path(BL).name;
        
        Airport_Name    = handles.Airport_Name;
        
        
        
        warning off;
        
        % input_directory='C:\Users\Navid\Documents\DATA for Individual Runs\ASDEX\IAH+ASDEX\2015\201507\20150716';
        % Open input file
        % input_directory = handles.pathname;
        % Input_File_ID = fopen([input_directory,'\IFF_IAH+ASDEX_20150716_060000_86350_FILTERED.csv'],'r'); %filePointer
        Input_File_ID   = fopen([Input_Dir,'\' input_directory],'r');
        
        Airport_Name    = Airport_Name;
        
        % Define variables
        FlightCounter = 0;
        Base_Date_Number = datenum('01/01/1970'); % In number of days since 01/01/0000
        
        % Pre allocating
        
        
        
        % Read file
        while(feof(Input_File_ID) == 0)
            
            % Do not read next line if current line is Header
            if FlightCounter == 0 || Record_Type ~= '2'
                aline = fgetl(Input_File_ID); % Get line
                Record_Type = aline(1);
            end
            
            if Record_Type == '2' % New Flight detected
                
                % FLight Counter
                %         if mod(FlightCounter, 100) == 0
                %             disp(['Number of flights processed: ', num2str(FlightCounter)]);
                %         end
                FlightCounter = FlightCounter + 1; % Counts the number of flights
                %handles.staticText1= FlightCounter;
                %edit2_Callback(hObject, eventdata, handles)
                %         handles.Counter = FlightCounter;
                h = hObject;
                % set(h , 'Units' , 'Normalized' , 'position' , [0.4 0.4 0.2 0.2]);
                % h1 = uicontrol(h , 'style' , 'text' , 'Units' , 'Normalized'...
                %                , 'position' , [0.4 0.4 0.2 0.2] , 'string' , 'Output');
                
                set(h , 'string' , ['Processed Flight:' num2str(FlightCounter)]);
                %pause(0.5)
                drawnow;
                
                guidata(hObject,handles)
                %         waitbar(handles.Counter);
                % ------------------------------------------------------
                % Header Record: Record Type 2
                % ------------------------------------------------------
                aline_split = textscan(aline, '%d%f%d%d%s%*s%*s%s%*d%s%*s%*s%s\n', 'delimiter', ',');
                
                Header.recType    = aline_split{1};
                Header.recTime    = aline_split{2};
                Header.fltKey     = aline_split{3};
                Header.bcnCode    = aline_split{4};
                Header.cid        = char(aline_split{5});
                %Header.source     = char(aline_split{6});
                %Header.msgType    = char(aline_split{7});
                Header.acId       = char(aline_split{6});
                %Header.recTypeCat = aline_split{9};
                Header.acType     = char(aline_split{7});
                %Header.orig       = char(aline_split{11});
                %Header.dest       = char(aline_split{12});
                Header.opsType    = char(aline_split{8});
                
                % ------------------------------------------------------
                % FlightPlan Record: Record Type 4
                % ------------------------------------------------------
                aline = fgetl(Input_File_ID); % Read line
                Record_Type = aline(1);
                if Record_Type ~= '4'
                    disp(['Error: Record Type 4 Expected. FlightKey: ', num2str(Header.fltKey)]);
                    pause;
                end
                %         aline_split = textscan(aline, '%d%f%d%d%s%s%s%s%d%s%s%s%c%f%f%s%s%s%d%c%c%c%s%d%c%d%s\n', 'delimiter', ',');
                
                %         FlightPlan.recType              = aline_split{1};
                %         FlightPlan.recTime              = aline_split{2};
                %         %FlightPlan.fltKey               = aline_split{3};
                %         %FlightPlan.bcnCode              = aline_split{4};
                %         %FlightPlan.cid                  = char(aline_split{5});
                %         %FlightPlan.source               = char(aline_split{6});
                %         %FlightPlan.msgType              = char(aline_split{7});
                %         FlightPlan.acId                 = char(aline_split{3});
                %         %FlightPlan.recTypeCat           = aline_split{9};
                %         FlightPlan.acType               = char(aline_split{4});
                %         %FlightPlan.orig                 = char(aline_split{11});
                %         %FlightPlan.dest                 = char(aline_split{12});
                %         %FlightPlan.altCode              = char(aline_split{13});
                %        %FlightPlan.alt                  = aline_split{14};
                %        %FlightPlan.maxAlt               = aline_split{15};
                %         %FlightPlan.altString            = char(aline_split{16});
                %         %FlightPlan.requestedAltString   = char(aline_split{17});
                %         %FlightPlan.route                = char(aline_split{18});
                %         %FlightPlan.estTime              = aline_split{19};
                %         %FlightPlan.fltCat               = char(aline_split{20});
                %         %FlightPlan.perfCat              = char(aline_split{21});
                %         FlightPlan.opsType              = char(aline_split{5});
                %         %FlightPlan.equipList            = char(aline_split{23});
                %         %FlightPlan.coordinationTime     = aline_split{24};
                %         %FlightPlan.coordinationTimeType = char(aline_split{25});
                %         %FlightPlan.leaderDir            = aline_split{26};
                %         %FlightPlan.scratchPad           = char(aline_split{27});
                
                % ------------------------------------------------------
                % Header Record: Record Type 2
                % ------------------------------------------------------
                PDARS(FlightCounter).Header = Header;
                
                % Change time format from seconds from 01/01/1970 to actual
                % date and time
                %         Number_Of_Days = PDARS(FlightCounter).Header.recTime / (24 * 3600); % Number of days since 01/01/1970 for track point
                %         Actual_Date_In_Days = Base_Date_Number + Number_Of_Days;
                %         Actual_Date_Formatted = datestr(Actual_Date_In_Days, 'yyyy-mm-dd'); % Date formatted yyyy-mm-dd
                %         Actual_Hours_Formatted = datestr(Actual_Date_In_Days, 'HH:MM:SS'); % Time formatted HH:MM:SS
                %         PDARS(FlightCounter).Header.recTime_Formatted_Date = Actual_Date_Formatted;
                %         PDARS(FlightCounter).Header.recTime_Formatted_Time = Actual_Hours_Formatted;
                
                % ------------------------------------------------------
                % FlightPlan Record: Record Type 4
                % ------------------------------------------------------
                %         PDARS(FlightCounter).FlightPlan = FlightPlan;
                
                % Change time format from seconds from 01/01/1970 to actual
                % date and time
                %         Number_Of_Days = PDARS(FlightCounter).FlightPlan.recTime / (24 * 3600); % Number of days since 01/01/1970 for track point
                %         Actual_Date_In_Days = Base_Date_Number + Number_Of_Days;
                %         Actual_Date_Formatted = datestr(Actual_Date_In_Days, 'yyyy-mm-dd'); % Date formatted yyyy-mm-dd
                %         Actual_Hours_Formatted = datestr(Actual_Date_In_Days, 'HH:MM:SS'); % Time formatted HH:MM:SS
                %         PDARS(FlightCounter).FlightPlan.recTime_Formatted_Date = Actual_Date_Formatted;
                %         PDARS(FlightCounter).FlightPlan.recTime_Formatted_Time = Actual_Hours_Formatted;
                
                % ------------------------------------------------------
                % Track Record: Record Type 3
                % ------------------------------------------------------
                % Sometimes there are more than 1 flight plan record. The first one
                % is recorded and the following ones are skipped.
                while Record_Type == '4'
                    aline = fgetl(Input_File_ID); % Get next Record Type
                    Record_Type = aline(1);
                end
                TrackRecord = 0;
                while Record_Type == '3' % Loop through the position records of that flight
                    
                    % ------------------------------------------------------
                    % Track Record: Record Type 3
                    % ------------------------------------------------------
                    TrackRecord = TrackRecord + 1;
                    aline_split = textscan(aline, '%*d%f%*d%*d%*s%*s%*s%*s%*d%f%f%f%*s%*d%*f%*f%f%f%*f%*f%*c%*c%*s%*c%*d%*s%*d\n', 'delimiter', ',');
                    
                    %PDARS(FlightCounter).Track.recType(TrackRecord)        = aline_split{1};
                    PDARS(FlightCounter).Track.recTime(TrackRecord)        = aline_split{1};
                    %PDARS(FlightCounter).Track.fltKey(TrackRecord)         = aline_split{3};
                    %PDARS(FlightCounter).Track.bcnCode(TrackRecord)        = aline_split{4};
                    %PDARS(FlightCounter).Track.cid(TrackRecord)            = aline_split{5};
                    %PDARS(FlightCounter).Track.source(TrackRecord)         = aline_split{6};
                    %PDARS(FlightCounter).Track.msgType(TrackRecord)        = aline_split{7};
                    %PDARS(FlightCounter).Track.acId(TrackRecord)           = aline_split{2};
                    %PDARS(FlightCounter).Track.recTypeCat(TrackRecord)     = aline_split{9};
                    PDARS(FlightCounter).Track.latitude(TrackRecord)       = aline_split{2};
                    PDARS(FlightCounter).Track.longitude(TrackRecord)      = aline_split{3};
                    PDARS(FlightCounter).Track.alt(TrackRecord)            = aline_split{4};
                    %PDARS(FlightCounter).Track.posCode(TrackRecord)        = aline_split{13};
                    %PDARS(FlightCounter).Track.significance(TrackRecord)   = aline_split{14};
                    %PDARS(FlightCounter).Track.latitudeAccur(TrackRecord)  = aline_split{15};
                    %PDARS(FlightCounter).Track.longitudeAccur(TrackRecord) = aline_split{16};
                    PDARS(FlightCounter).Track.altAccur(TrackRecord)       = aline_split{5};
                    PDARS(FlightCounter).Track.groundSpeed(TrackRecord)    = aline_split{6};
                    %PDARS(FlightCounter).Track.course(TrackRecord)         = aline_split{19};
                    %PDARS(FlightCounter).Track.rateOfClimb(TrackRecord)    = aline_split{20};
                    %
                    %             PDARS(FlightCounter).Track.leaderDir(TrackRecord)      = aline_split{25};
                    %             PDARS(FlightCounter).Track.scratchpad(TrackRecord)     = aline_split{26};
                    %             PDARS(FlightCounter).Track.msawInhibitInd(TrackRecord) = aline_split{27};
                    
                    % Change time format from seconds from 01/01/1970 to actual
                    % date and time
                    %             Number_Of_Days = aline_split{2} / (24 * 3600); % Number of days since 01/01/1970 for track point
                    %             Actual_Date_In_Days = Base_Date_Number + Number_Of_Days;
                    %             Actual_Date_Formatted = datestr(Actual_Date_In_Days, 'yyyy-mm-dd'); % Date formatted yyyy-mm-dd
                    %             Actual_Hours_Formatted = datestr(Actual_Date_In_Days, 'HH:MM:SS'); % Time formatted HH:MM:SS
                    %             PDARS(FlightCounter).Track.recTime_Formatted_Date(TrackRecord) = {Actual_Date_Formatted};
                    %             PDARS(FlightCounter).Track.recTime_Formatted_Time(TrackRecord) = {Actual_Hours_Formatted};
                    
                    % Read Line
                    aline = fgetl(Input_File_ID); % Get Record Type 3
                    Record_Type = aline(1);
                    
                    % Extracting Real Flights
                    Average_alt = mean(PDARS(FlightCounter).Track.alt);
                    if abs(PDARS(FlightCounter).Track.alt(1)-Average_alt)<= 0.2%0.1*PDARS(FlightCounter).Track.alt(1)
                        PDARS(FlightCounter).RealFlights=[];
                    else
                        PDARS(FlightCounter).RealFlights=PDARS(FlightCounter).Track;
                    end
                    
                end % while Record_Type == 3
            end % if Record_Type == 2 % New Flight detected
        end % while fid ~= eofPDATS
        
        %% Making a new file just for actual flights
        Length_PDARS=length(PDARS);
        
        for lp=1:Length_PDARS
            if isempty(PDARS(lp).RealFlights)==1
                RealFlights(lp).Header=[];
                %RealFlights(lp).FlightPlan=[];
                RealFlights(lp).Track=[];
            else
                RealFlights(lp).Header=PDARS(lp).Header;
                %RealFlights(lp).FlightPlan=PDARS(lp).FlightPlan;
                RealFlights(lp).Track=PDARS(lp).Track;
            end
        end
        % % % % % % empty_elems = arrayfun(@(s) all(structfun(@isempty,s)), A.B);
        empty_cells=arrayfun(@(s) any(structfun(@isempty,s)),RealFlights);
        Real_Flights_Final=RealFlights(~empty_cells);
        % Close open files
        fclose('all');
        
        First_Output(BL).First_Output = Real_Flights_Final;
        %This Scetion will separate arrivals and departures
        % RFL= length(Real_Flights_Final);
        %
        % counter2=0;
        %
        % for i=1:RFL
        %     if mod(counter2,100) == 0
        %         disp(['Number of Categorized Flights:' num2str(counter2)]);
        %     end
        %
        %     if strcmp(Real_Flights_Final(i).Header.opsType,'A') == 1
        %         Real_Flights_Arrivals(i)=Real_Flights_Final(i);
        %     elseif strcmp(Real_Flights_Final(i).Header.opsType,'D') == 1
        %         Real_Flights_Departures(i)=Real_Flights_Final(i);
        %     else
        %         Real_Flights_Others(i)=Real_Flights_Final(i);
        %     end
        %     counter2=counter2+1;
        % end
        %
        % %Removing the empty cells
        % empty_cells2=arrayfun(@(s) any(structfun(@isempty,s)),Real_Flights_Arrivals);
        % Real_Flights_Arrivals=Real_Flights_Arrivals(~empty_cells2);
        %
        % empty_cells3=arrayfun(@(s) any(structfun(@isempty,s)),Real_Flights_Departures);
        % Real_Flights_Departures=Real_Flights_Departures(~empty_cells3);
        %
        % empty_cells4=arrayfun(@(s) any(structfun(@isempty,s)),Real_Flights_Others);
        % Real_Flights_Others=Real_Flights_Others(~empty_cells4);
        %
        
        % % Compute speed between two track points
        % disp('Calculate Speed Between Points...');
        % for i = 1:FlightCounter
        %
        %     if mod(i, 100) == 0
        %         disp(['Number of flights processed: ', num2str(i), '/', num2str(FlightCounter)]);
        %     end
        %
        %     Number_Of_TrackPoints = length(PDARS(i).Track.latitude);
        %     for j = 1:Number_Of_TrackPoints - 1
        %
        %         TimeElapsed = PDARS(i).Track.recTime(j + 1) - PDARS(i).Track.recTime(j); % Elapsed Time in seconds
        %         Dist_nm = deg2nm(distance(PDARS(i).Track.latitude(j), PDARS(i).Track.longitude(j), PDARS(i).Track.latitude(j + 1), PDARS(i).Track.longitude(j + 1)));
        %         Speed_knots = round(Dist_nm / (TimeElapsed / 3600)); % speed in knots (nautical mph)
        %         PDARS(i).Track.Speed_knots(j) = Speed_knots;
        %
        %     end %  for j = 1:Number_Of_TrackPoints - 1
        % end % for i = 1:FlightCounter
        
        %Test for running the event extraction model
        %Airport_Report_File = Main_PDARS_Reader(Real_Flights_Final,AirportName);
        %% Saving the Output
        % Output_Dir = input_directory;
        % save([Output_Dir,'\' Airport_Name '_One_day.mat'],'Real_Flights_Final')
        % save([input_directory,'\' Airport_Name '_One_day_Arrivals.mat'],'Real_Flights_Arrivals')
        % save([input_directory,'\' Airport_Name '_One_day_Departures.mat'],'Real_Flights_Departures')
        % save([input_directory,'\' Airport_Name '_One_day_Others.mat'],'Real_Flights_Others')
        % save testone
        
        
        Output_Dir                 = handles.Output_folder_name;
        
        Result(BL).result          = Main_PDARS_Reader(Real_Flights_Final,Airport_Name,Output_Dir,Output_Name,Batch_Mode);
        
        clear  Real_Flights_Final empty_cells RealFlights PDARS
    end
end
handles.Batch_File_Number = [];

% handles.Flight_Key        = [Result.Flight_Key];

handles.Results           = Result;

handles.Real_Flights      = First_Output;

guidata(hObject,handles)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
File_Path = uigetdir();
Files     = dir(File_Path);
Non_Desired = [Files.isdir] ==1;
Files(Non_Desired) = [];
handles.Batch_Mode_Files = Files;
handles.Batch_Mode_Path  = File_Path;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6
% axes(handles.axes6);
% Imshow(image);



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
File_Number = str2double(get(hObject,'String'));

handles.Batch_File_Number = File_Number;

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
