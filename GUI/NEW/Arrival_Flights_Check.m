%%% Function for extracting arrivals information
%%% Writen By: Navid Mirmohammadsadeghi
function Airport_Report_File=Arrival_Flights_Check(Real_Flights,AirportsCoordinates,AirportName,~,rws,Airport,Counter)

Base_Date_Number = datenum('01/01/1970'); % In number of days since 01/01/0000

ACANRL=length(AirportsCoordinates.(AirportName).Runway);

Gate_File=AirportsCoordinates.ATL.GateAreas;

Runway_Names={rws.num};

Airport_Report_File.Enter_Rwy_Lat=[];
Airport_Report_File.Enter_Rwy_Long=[];
Airport_Report_File.Operational_Runway=[];
% Airport_Report_File.Error1='No Error';
%     First_Point_Passing_Threshold.LatitudeExiting=[];

for k=1:4:ACANRL-3
    rwy(k).in = inpolygon(Real_Flights.Track.longitude,Real_Flights.Track.latitude,AirportsCoordinates.(AirportName).Runway{1,k},AirportsCoordinates.(AirportName).Runway{1,k+1});
end

for j=1:length(Real_Flights.Track.latitude)
    %sp=j+1;
    if isempty(Airport_Report_File.Enter_Rwy_Lat) == 1
        for k=1:4:ACANRL-3
            try
                
                %                 if inpolygon(Real_Flights.Track.longitude(j),Real_Flights.Track.latitude(j),AirportsCoordinates.(AirportName).Runway{1,k},AirportsCoordinates.(AirportName).Runway{1,k+1}) == 1 && ...
                %                         inpolygon(Real_Flights.Track.longitude(j+1),Real_Flights.Track.latitude(j+1),AirportsCoordinates.(AirportName).Runway{1,k},AirportsCoordinates.(AirportName).Runway{1,k+1}) == 1 && ...
                %                         inpolygon(Real_Flights.Track.longitude(j+2),Real_Flights.Track.latitude(j+2),AirportsCoordinates.(AirportName).Runway{1,k},AirportsCoordinates.(AirportName).Runway{1,k+1}) == 1
                
                if all(rwy(k).in(j:j+2))
                    
                    Index_Runway=find(ismember(Runway_Names,AirportsCoordinates.(AirportName).Runway{1,k+2}));
                    Azimuth=rws(Index_Runway).dat(Index_Runway,4);
                    
                    if abs(azimuth(Real_Flights.Track.latitude(j),Real_Flights.Track.longitude(j),Real_Flights.Track.latitude(j+3),Real_Flights.Track.longitude(j+3))-Azimuth)<45 %abs(AirportsCoordinates.(AirportName).Runway{1,k}(1)-Real_Flights.Track.longitude(j))<0.002
                        Airport_Report_File.Operational_Runway=AirportsCoordinates.(AirportName).Runway{1,k+2};
                        Middle_Point_Threshold=[0.5*(AirportsCoordinates.(AirportName).Runway{1,k}(1)+AirportsCoordinates.(AirportName).Runway{1,k}(2))...
                            0.5*(AirportsCoordinates.(AirportName).Runway{1,k+1}(1)+AirportsCoordinates.(AirportName).Runway{1,k+1}(2))];
                        Index_Runway_Polygon=k;
                    else
                        Airport_Report_File.Operational_Runway=AirportsCoordinates.(AirportName).Runway{1,k+3};
                        Middle_Point_Threshold=[0.5*(AirportsCoordinates.(AirportName).Runway{1,k}(3)+AirportsCoordinates.(AirportName).Runway{1,k}(4))...
                            0.5*(AirportsCoordinates.(AirportName).Runway{1,k+1}(3)+AirportsCoordinates.(AirportName).Runway{1,k+1}(4))];
                        Index_Runway_Polygon=k;
                    end
                end
            catch ME
                %                 Airport_Report_File.Error1=ME.message;
            end
            
        end
        
        %Length of The Track file for each flight
        RFATLL=length(Real_Flights.Track.latitude);
        
        if isempty(Airport_Report_File.Operational_Runway) == 0
            Index_Altitude=find(ismember(Runway_Names,Airport_Report_File.Operational_Runway)==1);
            Airport_Default_Altitude=rws(Index_Altitude).dat(Index_Altitude,10)/100;
            Airport_Report_File.Airport=AirportName;
            Airport_Report_File.Enter_Rwy_Lat=Real_Flights.Track.latitude(j);
            Airport_Report_File.Enter_Rwy_Long=Real_Flights.Track.longitude(j);
            %Calculating the Real Threshold passing time
            Locations_Before_After_Threshold=[Real_Flights.Track.longitude(j-1) Real_Flights.Track.longitude(j)];
            Times_Before_After_Threshold=[Real_Flights.Track.recTime(j-1) Real_Flights.Track.recTime(j)];
            if Real_Flights.Track.longitude(j-1)== Real_Flights.Track.longitude(j)
                Real_Time_Threshold_Pass=[];
            else
                Real_Time_Threshold_Pass=interp1(Locations_Before_After_Threshold,Times_Before_After_Threshold,Middle_Point_Threshold(1));
            end
            Time_Profile=Real_Flights.Track.recTime;
            Altitude_Profile=Real_Flights.Track.alt;
            Latitude_Profile=Real_Flights.Track.latitude;
            Longitude_Profile=Real_Flights.Track.longitude;
            if isnan(Real_Time_Threshold_Pass) == 1 %Sometimes the passing point can not be on a linear line to have the interpolation answer
                Real_Time_Threshold_Pass=Real_Flights.Track.recTime(j);
            elseif isempty(Real_Time_Threshold_Pass) == 1
                Real_Time_Threshold_Pass=Real_Flights.Track.recTime(j);
            end
            
            Distance = zeros(length(Real_Flights.Track.latitude),1);
            
            %             for js=2:length(Real_Flights.Track.latitude)
            %                 Distance(js)=distance(Real_Flights.Track.latitude(js-1),Real_Flights.Track.longitude(js-1),...
            %                     Real_Flights.Track.latitude(js),Real_Flights.Track.longitude(js));
            %                 %     Speed_Profiles.SpeedKnot(js)=1.94384*Speed_Profiles.distance(js)/(Real_Flights.Track.recTime(js)-Real_Flights.Track.recTime(js-1));
            %             end
            
            Lat1  = Real_Flights.Track.latitude(1:end-1);
            
            Lat2  = Real_Flights.Track.latitude(2:end);
            
            Long1 = Real_Flights.Track.longitude(1:end-1);
            
            Long2 = Real_Flights.Track.longitude(2:end);
            
            
            Length_Distance=length(Distance);
            
            %             for js=2:Length_Distance
            %
            %                 %Speed_Profiles.distance(js) = distdim(Distance(js),'deg','m');
            %                 Speed_Profiles.distance(js) = deg2km(Distance(js))*1000;
            %             end
            
            Speed_Profiles.distance = [0, deg2km(distance(Lat1,Long1,Lat2,Long2))*1000];
            
            for sp=2:Length_Distance
                
                Speed_Profiles.SpeedMs(sp) = Speed_Profiles.distance(sp)/(Real_Flights.Track.recTime(sp)-Real_Flights.Track.recTime(sp-1));
            end
            
            %             Speed_Profiles.SpeedMs = zeros(1,Length_Distance);
            %             Speed_Profiles.SpeedMs(2:Length_Distance) = Speed_Profiles.distance(2:Length_Distance) ./ (Real_Flights.Track.recTime(2:Length_Distance) - Real_Flights.Track.recTime(1:Length_Distance-1));
            %
            Speed_Profiles.SmoothSpeedMs=smooth(smooth(Speed_Profiles.SpeedMs));
            
            
            
            for a=2:length(Real_Flights.Track.latitude)
                
                Speed_Profiles.acceleration(a)=(Speed_Profiles.SmoothSpeedMs(a)-Speed_Profiles.SmoothSpeedMs(a-1))/(Real_Flights.Track.recTime(a)-Real_Flights.Track.recTime(a-1));
                
            end
            
            %             Speed_Profiles.acceleration = zeros(1,RFATLL);
            %             Speed_Profiles.acceleration(2:RFATLL) = (Speed_Profiles.SmoothSpeedMs(2:RFATLL) - Speed_Profiles.SmoothSpeedMs(1:RFATLL-1)) ./ (Real_Flights.Track.recTime(2:RFATLL) - Real_Flights.Track.recTime(1:RFATLL-1));
            
            Index_of_entry_Runway=j;
            
            %             Index_Approach_Speed = find(deg2nm(distance(Latitude_Profile,Longitude_Profile,Middle_Point_Threshold(2),Middle_Point_Threshold(1)))<=8);
            %
            %             Approach_Speed = mean(Speed_Profiles.SmoothSpeedMs(Index_Approach_Speed(2:Index_of_entry_Runway)))*1.94384;
            
            
            Touchdown=TouchDownLocationTime(Altitude_Profile,Airport_Default_Altitude,Real_Time_Threshold_Pass,Time_Profile,Latitude_Profile,Longitude_Profile,Middle_Point_Threshold,Speed_Profiles,Index_Runway_Polygon,...
                AirportsCoordinates,AirportName,Real_Flights,Index_of_entry_Runway);
            Airport_Report_File.EnterRwy_On_Off_Dur       = Touchdown.Time;
            Airport_Report_File.On_Off_Lat    = Touchdown.Location.Latitude;
            Airport_Report_File.On_Off_Long   = Touchdown.Location.Longitude;
            Airport_Report_File.EnterRwy_On_Off_Dist = Touchdown.TouchdownDistance;
            %             Airport_Report_File.Touchdown_Altitude        = Touchdown.altitude;
            %             Airport_Report_File.Touchdown_Index           = Touchdown.MomentOfTouchDown;
            
            Number_Of_Days =Real_Time_Threshold_Pass/ (24 * 3600); % Number of days since 01/01/1970 for track point
            Actual_Date_In_Days = Base_Date_Number + Number_Of_Days;
            Actual_Date_Formatted = datestr(Actual_Date_In_Days, 'yyyy-mm-dd  HH:MM:SS'); % Date formatted yyyy-mm-dd
            %             Actual_Hours_Formatted = datestr(Actual_Date_In_Days, 'HH:MM:SS'); % Time formatted HH:MM:SS
            %             Airport_Report_File.Index_of_the_Entry_Runway=Index_of_entry_Runway;
            %             Airport_Report_File.Time_at_threshold_Seconds_A_D=Real_Time_Threshold_Pass;
            %             Airport_Report_File.Time_at_threshold_Hour_Minute_A_D=Actual_Hours_Formatted;
            Airport_Report_File.Enter_Rwy_Time=Actual_Date_Formatted;
            
            
            
            %                 if isempty(First_Point_Passing_Threshold.LatitudeExiting) == 1
            %                 [LatitudeExiting,LongitudeExiting,Index_Of_Entry_Exiting,Time_of_Exiting,Time_Exiting_Hour]=ExitPointsFinder(Latitude_Profile,Longitude_Profile,Taxiways,Time_Profile);
            %                 First_Point_Passing_Threshold.LatitudeExiting=LatitudeExiting;
            %                 First_Point_Passing_Threshold.LongitudeExiting=LongitudeExiting;
            %                 First_Point_Passing_Threshold.Number_Of_Entry_Exiting=Index_Of_Entry_Exiting;
            %                 First_Point_Passing_Threshold.Time_of_Exiting=Time_of_Exiting;
            %                 First_Point_Passing_Threshold.Time_Exiting_Hour=Time_Exiting_Hour;
            %                 end
            %Function for recognizing the Gate Area:
            
            GateArea=GateAreaFinder(RFATLL,Gate_File,Latitude_Profile,Longitude_Profile,Airport,AirportName);
            Airport_Report_File.Near_Gate_Lat  = Latitude_Profile(RFATLL);
            Airport_Report_File.Near_Gate_Long = Longitude_Profile(RFATLL);
            
            if length(GateArea)>2
                Airport_Report_File.Gate_Label = GateArea;
            else
                Airport_Report_File.Gate_Label = 'Not Found';
                
            end
            
            
            Airport_Report_File.Operation=Real_Flights.Header.opsType;
            Airport_Report_File.Flight_ID=Real_Flights.Header.acId;
            Airport_Report_File.Flight_Key=Real_Flights.Header.fltKey;
            Airport_Report_File.Aircraft_Type=Real_Flights.Header.acType;
            %             Airport_Report_File.Error={};
            %             if isempty(Airport_Report_File.Touchdown_WheelsOff_Struct) == 0
            %                 Airport_Report_File.Taxi_In_Out_Dur=Real_Flights.Track.recTime(RFATLL)-Real_Flights.Track.recTime(Touchdown.MomentOfTouchDown);
            %             else
            %                 Airport_Report_File.Taxi_In_Out_Dur=[];
            %             end
            
            %             Airport_Report_File.Altitude_By_Passing_Time_ART_DRT=(Real_Flights.Track.alt(j)-mode(Altitude_Profile))*100; %(Real_Flights.Track.alt(j)-Airport_Default_Altitude+(Airport_Default_Altitude-mode(Altitude_Profile)))*100;
            
            
            
            
        end
        
    end %if isempty(First_Point_Passing_Threshold.Latitude) == 1
end %for j=1:length(Latitude)
if isempty(Airport_Report_File.Enter_Rwy_Lat)==0
    [latExit,longExit,TimeExit,IndexExit]=ExitingRunwayArrival(Index_Runway_Polygon,Index_of_entry_Runway,Time_Profile,Latitude_Profile,Longitude_Profile,AirportsCoordinates,AirportName);
    Airport_Report_File.Exit_Rwy_Lat=latExit;
    Airport_Report_File.Exit_Rwy_Long=longExit;
    %     Airport_Report_File.Exit_Rwy_Time=TimeExit;
    Airport_Report_File.Taxi_In_Out_Dur = Real_Flights.Track.recTime(RFATLL)-Real_Flights.Track.recTime(IndexExit);
    Airport_Report_File.Avg_Taxi_Speed = mean(Speed_Profiles.SmoothSpeedMs(IndexExit:RFATLL));
    if Airport_Report_File.Avg_Taxi_Speed > 30
        
        Go_Around =1;
        
    else
        
        Go_Around =0;
        
        
    end
    
    Number_Of_Days2 =TimeExit/ (24 * 3600); % Number of days since 01/01/1970 for track point
    Actual_Date_In_Days2 = Base_Date_Number + Number_Of_Days2;
    Airport_Report_File.Exit_Rwy_Time = datestr(Actual_Date_In_Days2, 'yyyy-mm-dd  HH:MM:SS'); % Time formatted HH:MM:SS
    %Airport_Report_File.IndexExit=IndexExit;
    Airport_Report_File.EnterRwy_ExitRwy_Dur=TimeExit-Real_Time_Threshold_Pass;
    
    if Airport_Report_File.EnterRwy_ExitRwy_Dur<10
        
        ROT_Less_Than_10 = 1;
        
    end
    %     for js=2:length(Real_Flights.Track.latitude)
    %         Speed_Profiles.distance(js)=distdim(distance(Real_Flights.Track.latitude(js-1),Real_Flights.Track.longitude(js-1),...
    %             Real_Flights.Track.latitude(js),Real_Flights.Track.longitude(js)),'deg','m');
    %         Speed_Profiles.Speed(js)=1.94384*Speed_Profiles.distance(js)/(Real_Flights.Track.recTime(js)-Real_Flights.Track.recTime(js-1));
    %     end
    if isempty(Speed_Profiles) ==0
        SPDL=length(Speed_Profiles.distance);
        Taxiing_Distance=sum(Speed_Profiles.distance(IndexExit:SPDL));
        Airport_Report_File.Taxi_Dist=Taxiing_Distance;
    end
    
    a                            = find(Speed_Profiles.distance<3);
    TimesSlowerThanAverageTaxing = find(Speed_Profiles.SmoothSpeedMs<3);
    TypicalSlowFlights           = find(Speed_Profiles.SmoothSpeedMs<7); %Typical Taxiing speed is between 8.7m/s to 9.3 m/s
    waiting_time_initial         = zeros(length(a));
    if length(a)>1
        for kw=2:length(a)
            waiting_time_initial(kw)=Real_Flights.Track.recTime(a(kw))-Real_Flights.Track.recTime(a(kw)-1);
        end
        waiting_time=sum(waiting_time_initial);
    else
        waiting_time=0;
    end
    %     Airport_Report_File.waiting_time_zeroDist = waiting_time(1);    % length(a)-1;
    waiting_time_Based_on_TaxiSpeed                         = waitingtimefinder(TimesSlowerThanAverageTaxing,TypicalSlowFlights,Time_Profile);
    
    Airport_Report_File.Wait_Time_Under_3                   = waiting_time_Based_on_TaxiSpeed(1);
    %     Airport_Report_File.waiting_time_lowerThanTypicalTaxiSp = waiting_time_Based_on_TaxiSpeed(2);
    %     Airport_Report_File.Estimated_AverageTaxiTime           = Airport_Report_File.Taxi_Dist/Airport_Report_File.Avg_Taxi_Speed;
    Airport_Report_File.Taxi_Time_Minus_Wait                = Airport_Report_File.Taxi_In_Out_Dur-Airport_Report_File.Wait_Time_Under_3;
    %     Airport_Report_File.Estimated_UnimpededTime_Second      = Airport_Report_File.Taxi_In_Out_Dur- Airport_Report_File.waiting_time_lowerThanTypicalTaxiSp;
    Airport_Report_File.Index_Main_File = Counter;
    %     Airport_Report_File.Approach_Speed  = Approach_Speed;
    %
    %     Airport_Report_File.Speed_Profile   = Speed_Profiles.SmoothSpeedMs(Index_Approach_Speed(1:Index_of_entry_Runway))*1.94384;
    
    
end

if exist('Go_Around','var')
    
    %Go_Around=1;
else
    Go_Around=0;
end %if exist('Go_Around','var')

if exist('ROT_Less_Than_10','var')
    
    %Go_Around=1;
else
    ROT_Less_Than_10=0;
end %if exist('Go_Around','var')


if isempty(Airport_Report_File.Enter_Rwy_Lat)==1 || Go_Around==1 || ROT_Less_Than_10==1
    Airport_Report_File.Enter_Rwy_Lat                 = [];
    Airport_Report_File.Enter_Rwy_Long                = [];
    if Go_Around==0
        Airport_Report_File.Operational_Runway            = 'No Lat/Long Found';
    end
    %     Airport_Report_File.Error1                      ='Not lat/Long found!';
    Airport_Report_File.Airport                       = AirportName;
    %Airport_Report_File.Touchdown_WheelsOff_Struct   =[];
    Airport_Report_File.EnterRwy_On_Off_Dur           = [];
    Airport_Report_File.On_Off_Lat                    = [];
    Airport_Report_File.On_Off_Long                   = [];
    Airport_Report_File.EnterRwy_On_Off_Dist          = [];
    %     Airport_Report_File.Touchdown_Altitude      = [];
    %     Airport_Report_File.Touchdown_Index             = [];
    %     Airport_Report_File.Index_of_the_Entry_Runway     = [];
    %     Airport_Report_File.Time_at_threshold_Seconds_A_D = [];
    %     Airport_Report_File.Time_at_threshold_Hour_Minute_A_D=[];
    Airport_Report_File.Enter_Rwy_Time                = [];
    Airport_Report_File.Near_Gate_Lat                 = [];
    Airport_Report_File.Near_Gate_Long                = [];
    Airport_Report_File.Gate_Label                    = [];
    if Go_Around ==1
        Airport_Report_File.Operation                  = 'Go Around';
    else
        Airport_Report_File.Operation                 = Real_Flights.Header.opsType;
    end
    
    Airport_Report_File.Flight_ID                     = Real_Flights.Header.acId;
    Airport_Report_File.Flight_Key                    = Real_Flights.Header.fltKey;
    Airport_Report_File.Aircraft_Type                 = Real_Flights.Header.acType;
    Airport_Report_File.Taxi_In_Out_Dur               = [];
    Airport_Report_File.Avg_Taxi_Speed                = [];
    %     Airport_Report_File.Altitude_By_Passing_Time_ART_DRT=[];
    Airport_Report_File.Exit_Rwy_Lat                  = [];
    Airport_Report_File.Exit_Rwy_Long                 = [];
    Airport_Report_File.Exit_Rwy_Time                 = [];
    %     Airport_Report_File.Exit_Rwy_Time                 = [];
    %Airport_Report_File.IndexExit                 = [];
    Airport_Report_File.Taxi_Dist                     = [];
    %     Airport_Report_File.waiting_time_zeroDist         = [];
    Airport_Report_File.EnterRwy_ExitRwy_Dur          = [];
    Airport_Report_File.Wait_Time_Under_3             = [];
    %     Airport_Report_File.waiting_time_lowerThanTypicalTaxiSp = [];
    %     Airport_Report_File.Estimated_AverageTaxiTime     = [];
    Airport_Report_File.Taxi_Time_Minus_Wait          = [];
    %     Airport_Report_File.Estimated_UnimpededTime_Second      = [];
    Airport_Report_File.Index_Main_File                     = Counter;
    %     Airport_Report_File.Approach_Speed  = NaN;
    %     Airport_Report_File.Speed_Profile                 = [];
    %     Airport_Report_File.Error='Not lat/Long found!';
    
end

% if strcmp(Airport_Report_File.Error1,'No Error')==0
%     Airport_Report_File.Error1=Airport_Report_File.Error1.message;
% end

end