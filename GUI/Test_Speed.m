
function First_Output = Test_Speed(input_directory,Airport_Name)



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
%         handles.Counter = FlightCounter;
%         guidata(hObject,handles)
%         waitbar(handles.Counter);
        % ------------------------------------------------------
        % Header Record: Record Type 2
        % ------------------------------------------------------
        aline_split = textscan(aline, '%d%f%*d%d%s%*s%*s%s%*d%s%*s%*s%s\n', 'delimiter', ',');

        Header.recType    = aline_split{1};
        Header.recTime    = aline_split{2};
%         Header.fltKey     = aline_split{3};
        Header.bcnCode    = aline_split{3};
        Header.cid        = char(aline_split{4});
        %Header.source     = char(aline_split{6});
        %Header.msgType    = char(aline_split{7});
        Header.acId       = char(aline_split{5});
        %Header.recTypeCat = aline_split{9};
        Header.acType     = char(aline_split{6});
        %Header.orig       = char(aline_split{11});
        %Header.dest       = char(aline_split{12});
        Header.opsType    = char(aline_split{7});
        
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
%             Average_alt = mean(PDARS(FlightCounter).Track.alt);
            if abs(PDARS(FlightCounter).Track.alt(1)-PDARS(FlightCounter).Track.alt(end))<= 0.2%0.1*PDARS(FlightCounter).Track.alt(1)
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
end