%%% Function for extracting departures information
%%% Writen By: Navid Mirmohammadsadeghi

function Airport_Report_File=Departure_Flights_Check(Real_Flights,AirportsCoordinates,AirportName,Airport_Default_Altitude,rws,ChangeOfAltitudeCoef,Airport,Counter)

Base_Date_Number = datenum('01/01/1970'); % In number of days since 01/01/0000

ACANRL=length(AirportsCoordinates.(AirportName).Runway);

Gate_File=AirportsCoordinates.ATL.GateAreas;

Runway_Names={rws.num};

Airport_Report_File.Enter_Rwy_Lat=[];
Airport_Report_File.Enter_Rwy_Long=[];
Airport_Report_File.Operational_Runway=[];
% Airport_Report_File.Error1='No Error';
%     First_Point_Passing_Threshold.LatitudeExiting=[];

Distance = zeros(length(Real_Flights.Track.latitude),1);

% for js=2:length(Real_Flights.Track.latitude)
%     Distance(js)=distance(Real_Flights.Track.latitude(js-1),Real_Flights.Track.longitude(js-1),...
%         Real_Flights.Track.latitude(js),Real_Flights.Track.longitude(js));
%     %     Speed_Profiles.SpeedKnot(js)=1.94384*Speed_Profiles.distance(js)/(Real_Flights.Track.recTime(js)-Real_Flights.Track.recTime(js-1));
% end

Lat1  = Real_Flights.Track.latitude(1:end-1);

Lat2  = Real_Flights.Track.latitude(2:end);

Long1 = Real_Flights.Track.longitude(1:end-1);

Long2 = Real_Flights.Track.longitude(2:end);

Length_Distance=length(Distance);

% for js=2:Length_Distance
%
%     %Speed_Profiles.distance(js) = distdim(Distance(js),'deg','m');
%     Speed_Profiles.distance(js) = deg2km(Distance(js))*1000;
% end

Speed_Profiles.distance = [0, deg2km(distance(Lat1,Long1,Lat2,Long2))*1000];

for sp=2:Length_Distance
    
    Speed_Profiles.SpeedMs(sp) = Speed_Profiles.distance(sp)/(Real_Flights.Track.recTime(sp)-Real_Flights.Track.recTime(sp-1));
end



Speed_Profiles.SmoothSpeedMs=smooth(smooth(Speed_Profiles.SpeedMs));

for a=2:length(Real_Flights.Track.latitude)
    
    Speed_Profiles.acceleration(a)=(Speed_Profiles.SmoothSpeedMs(a)-Speed_Profiles.SmoothSpeedMs(a-1))/(Real_Flights.Track.recTime(a)-Real_Flights.Track.recTime(a-1));
    
end

%Sorting the acceleration file to have the maximum ones

LSPA=length(Speed_Profiles.acceleration);

Acceleration= sort(Speed_Profiles.acceleration(3:LSPA),'descend');

Index_Departure_Runway=[];

for ac=1:length(Acceleration)
    if isempty(Index_Departure_Runway)==1
        Index_Acceleration=find(Speed_Profiles.acceleration==Acceleration(ac)); %2 is added becasue the first acceleration point is zero and usually we have a high value for the second one as it contains a bigger speed than zero which is the first speed
        for k=1:4:ACANRL-3
            try
                if abs(Real_Flights.Track.alt(Index_Acceleration(1))-Real_Flights.Track.alt(1))<= 1.5 && inpolygon(Real_Flights.Track.longitude(Index_Acceleration(1)+10),Real_Flights.Track.latitude(Index_Acceleration(1)+10),AirportsCoordinates.(AirportName).Runway{1,k},AirportsCoordinates.(AirportName).Runway{1,k+1}) == 1 && ...
                        inpolygon(Real_Flights.Track.longitude(Index_Acceleration(1)-6),Real_Flights.Track.latitude(Index_Acceleration(1)-6),AirportsCoordinates.(AirportName).Runway{1,k},AirportsCoordinates.(AirportName).Runway{1,k+1}) == 1 && Real_Flights.Track.alt(Index_Acceleration(1)+20)-Real_Flights.Track.alt(Index_Acceleration(1))> 2
                    
                    Index_Departure_Runway=Index_Acceleration;
                    
                end
            catch
            end
        end
    end
    
end



%Checking whether the maximum acceleration is happening on the ground
%(which is the case for take-off roll)





for j=Index_Departure_Runway-4:Index_Departure_Runway %1:length(Real_Flights.Track.latitude)
    
    %sp=j+1;
    
    if isempty(Airport_Report_File.Enter_Rwy_Lat) == 1
        for k=1:4:ACANRL-3
            try
                if inpolygon(Real_Flights.Track.longitude(j),Real_Flights.Track.latitude(j),AirportsCoordinates.(AirportName).Runway{1,k},AirportsCoordinates.(AirportName).Runway{1,k+1}) == 1 && ...
                        inpolygon(Real_Flights.Track.longitude(j+1),Real_Flights.Track.latitude(j+1),AirportsCoordinates.(AirportName).Runway{1,k},AirportsCoordinates.(AirportName).Runway{1,k+1}) == 1 && ...
                        inpolygon(Real_Flights.Track.longitude(j+2),Real_Flights.Track.latitude(j+2),AirportsCoordinates.(AirportName).Runway{1,k},AirportsCoordinates.(AirportName).Runway{1,k+1}) == 1
                    
                    if abs(AirportsCoordinates.(AirportName).Runway{1,k}(1)-Real_Flights.Track.longitude(j))<0.01
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
                end %if inpolygon(Real_Flight...
            catch ME
                %                 Airport_Report_File.Error1=ME;
            end %try
            
        end %for k=1:4:ACANRL-3
        
        
        
        %Length of The Track file for each flight
        RFATLL=length(Real_Flights.Track.latitude);
        
        
        
        if isempty(Airport_Report_File.Operational_Runway) == 0
            
            PointsInsidePolygon=find(inpolygon(Real_Flights.Track.longitude,Real_Flights.Track.latitude,AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon},AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon+1})==1);
            
            
            Diff=diff(PointsInsidePolygon);
            
            %For very complicated paths:
            
            Gaps_On_Runway = (diff(Diff)>1);
            
            Points_Of_Entrance = find(Gaps_On_Runway==1);
            
            if mean(Diff)<1.7 || (length(Diff)-find(Diff==max(Diff)))<5
                IndexEnteredRunway=PointsInsidePolygon(1);
            elseif  length(Gaps_On_Runway)-Points_Of_Entrance(length(Points_Of_Entrance))>25
                IndexEnteredRunway=PointsInsidePolygon(Points_Of_Entrance(length(Points_Of_Entrance))+2);
            else
                IndexEnteredRunway=PointsInsidePolygon(find(Diff==max(Diff))+1);
                IndexEnteredRunway = IndexEnteredRunway(1);
            end %mean(Diff)==1
            
            Index_Runway=find(ismember(Runway_Names,AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon+2})==1);
            Azimuth=rws(Index_Runway).dat(Index_Runway,4);
            
            if abs(azimuth(Real_Flights.Track.latitude(IndexEnteredRunway+4),Real_Flights.Track.longitude(IndexEnteredRunway+4),Real_Flights.Track.latitude(IndexEnteredRunway+15),Real_Flights.Track.longitude(IndexEnteredRunway+15))-Azimuth)<45%abs(AirportsCoordinates.(AirportName).Runway{1,k}(1)-Real_Flights.Track.longitude(j))<0.002
                Airport_Report_File.Operational_Runway=AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon+2};
                %                 Middle_Point_Threshold=[0.5*(AirportsCoordinates.(AirportName).Runway{1,k}(1)+AirportsCoordinates.(AirportName).Runway{1,k}(2))...
                %                     0.5*(AirportsCoordinates.(AirportName).Runway{1,k+1}(1)+AirportsCoordinates.(AirportName).Runway{1,k+1}(2))];
                %Index_Runway_Polygon=k;
            else
                Airport_Report_File.Operational_Runway=AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon+3};
                %                 Middle_Point_Threshold=[0.5*(AirportsCoordinates.(AirportName).Runway{1,k}(3)+AirportsCoordinates.(AirportName).Runway{1,k}(4))...
                %                     0.5*(AirportsCoordinates.(AirportName).Runway{1,k+1}(3)+AirportsCoordinates.(AirportName).Runway{1,k+1}(4))];
                %Index_Runway_Polygon=Index_Runway_Polygon+1;
            end
            
            
            Airport_Report_File.Airport=AirportName;
            % The Location the plane got into the runway
            %try
            Airport_Report_File.Enter_Rwy_Lat=Real_Flights.Track.latitude(IndexEnteredRunway);
            Airport_Report_File.Enter_Rwy_Long=Real_Flights.Track.longitude(IndexEnteredRunway);
            %                 Airport_Report_File.Entering_Latitude=Real_Flights.Track.latitude(j-1);
            %Calculating the Real Threshold passing time
            if IndexEnteredRunway==1
                s=IndexEnteredRunway+1;
                Locations_Before_After_Threshold=[Real_Flights.Track.longitude(s) Real_Flights.Track.longitude(s+1)];
                Times_Before_After_Threshold=[Real_Flights.Track.recTime(s) Real_Flights.Track.recTime(s+1)];
                if Real_Flights.Track.longitude(s)== Real_Flights.Track.longitude(s+1)
                    Real_Time_Threshold_Pass=[];
                else
                    Real_Time_Threshold_Pass=interp1(Locations_Before_After_Threshold,Times_Before_After_Threshold,Middle_Point_Threshold(1));
                end %if Real_Flights.Track.longitude(j-1)== Real_Flights.Track.longitude(j)
                
            else %if IndexEnteredRunway==1
                Locations_Before_After_Threshold=[Real_Flights.Track.longitude(IndexEnteredRunway-1) Real_Flights.Track.longitude(IndexEnteredRunway)];
                Times_Before_After_Threshold=[Real_Flights.Track.recTime(IndexEnteredRunway-1) Real_Flights.Track.recTime(IndexEnteredRunway)];
                if Real_Flights.Track.longitude(IndexEnteredRunway-1)== Real_Flights.Track.longitude(IndexEnteredRunway)
                    Real_Time_Threshold_Pass=[];
                else
                    Real_Time_Threshold_Pass=interp1(Locations_Before_After_Threshold,Times_Before_After_Threshold,Middle_Point_Threshold(1));
                end %if Real_Flights.Track.longitude(j-1)== Real_Flights.Track.longitude(j)
                %catch ME
                %                 Airport_Report_File.Error1=ME;
                %end
                
            end %if IndexEnteredRunway==1
            Time_Profile=Real_Flights.Track.recTime;
            Altitude_Profile=Real_Flights.Track.alt;
            Latitude_Profile=Real_Flights.Track.latitude;
            Longitude_Profile=Real_Flights.Track.longitude;
            if isnan(Real_Time_Threshold_Pass) == 1 %Sometimes the passing point can not be on a linear line to have the interpolation answer
                Real_Time_Threshold_Pass=Real_Flights.Track.recTime(IndexEnteredRunway);
            elseif isempty(Real_Time_Threshold_Pass) == 1
                Real_Time_Threshold_Pass=Real_Flights.Track.recTime(IndexEnteredRunway);
            end %if isnan(Real_Time_Threshold_Pass) == 1
            
            Touchdown=WheelsOff(Altitude_Profile,Airport_Default_Altitude,Real_Time_Threshold_Pass,Time_Profile,Latitude_Profile,Longitude_Profile,Middle_Point_Threshold,...
                IndexEnteredRunway,Index_Departure_Runway);
            %             Airport_Report_File.Touchdown_WheelsOff_Struct=Touchdown;
            
            Airport_Report_File.EnterRwy_On_Off_Dur = Touchdown.Time;
            Airport_Report_File.On_Off_Lat    = Touchdown.Location.Latitude;
            Airport_Report_File.On_Off_Long   = Touchdown.Location.Longitude;
            Airport_Report_File.EnterRwy_On_Off_Dist = Touchdown.TouchdownDistance;
            %             Airport_Report_File.Touchdown_Altitude        = Touchdown.altitude;
            %             Airport_Report_File.Touchdown_Index           = Touchdown.MomentOfTouchDown;
            
            Number_Of_Days =Real_Time_Threshold_Pass/ (24 * 3600); % Number of days since 01/01/1970 for track point
            Actual_Date_In_Days = Base_Date_Number + Number_Of_Days;
            Actual_Date_Formatted = datestr(Actual_Date_In_Days, 'yyyy-mm-dd  HH:MM:SS'); % Date formatted yyyy-mm-dd
            %             Actual_Hours_Formatted = datestr(Actual_Date_In_Days, 'HH:MM:SS'); % Time formatted HH:MM:SS
%             Airport_Report_File.Index_of_the_Entry_Runway=IndexEnteredRunway;
            %             Airport_Report_File.Time_at_threshold_Seconds_A_D=Real_Time_Threshold_Pass;
            %             Airport_Report_File.Time_at_threshold_Hour_Minute_A_D=Actual_Hours_Formatted;
            Airport_Report_File.Enter_Rwy_Time=Actual_Date_Formatted;
            %             Airport_Report_File.Latitude=Real_Flights.Track.latitude(j);
            %             Airport_Report_File.Longitude=Real_Flights.Track.longitude(j);
            
            %                 if isempty(First_Point_Passing_Threshold.LatitudeExiting) == 1
            %                 [LatitudeExiting,LongitudeExiting,Index_Of_Entry_Exiting,Time_of_Exiting,Time_Exiting_Hour]=ExitPointsFinder(Latitude_Profile,Longitude_Profile,Taxiways,Time_Profile);
            %                 First_Point_Passing_Threshold.LatitudeExiting=LatitudeExiting;
            %                 First_Point_Passing_Threshold.LongitudeExiting=LongitudeExiting;
            %                 First_Point_Passing_Threshold.Number_Of_Entry_Exiting=Index_Of_Entry_Exiting;
            %                 First_Point_Passing_Threshold.Time_of_Exiting=Time_of_Exiting;
            %                 First_Point_Passing_Threshold.Time_Exiting_Hour=Time_Exiting_Hour;
            %                 end
            %Function for recognizing the Gate Area:
            
            GateArea=GateAreaFinderDeparture(RFATLL,Gate_File,Latitude_Profile,Longitude_Profile,Airport,AirportName);
            Airport_Report_File.Near_Gate_Lat  = Latitude_Profile(1);
            Airport_Report_File.Near_Gate_Long = Longitude_Profile(1);
            
            if length(GateArea)>2
                Airport_Report_File.Gate_Label = GateArea;
            else
                Airport_Report_File.Gate_Label = 'Not Found';
                
            end
            
            Airport_Report_File.Operation=Real_Flights.Header.opsType;
            Airport_Report_File.Flight_ID=Real_Flights.Header.acId;
            Airport_Report_File.Flight_Key=Real_Flights.Header.fltKey;
            Airport_Report_File.Aircraft_Type=Real_Flights.Header.acType;
            [latExit,longExit,TimeExit,IndexExit]=LeavingMoment(Index_Runway_Polygon,IndexEnteredRunway,Latitude_Profile,Longitude_Profile,Time_Profile,AirportsCoordinates,AirportName);
            Index=IndexExit;
            %             Airport_Report_File.Error={};
            %             if isempty(Airport_Report_File.Touchdown_WheelsOff_Struct) == 0
            
            %             else
            %                 Airport_Report_File.Taxi_In_Out_Dur=[];
            %             end
            
            %             Airport_Report_File.Altitude_By_Passing_Time_ART_DRT=(Real_Flights.Track.alt(Index)-Airport_Default_Altitude)*100;
            
            %             Airport_Report_File.Error='Departure Starts in the middle of runway!';
            
            Airport_Report_File.Exit_Rwy_Lat=latExit;
            Airport_Report_File.Exit_Rwy_Long =longExit;
            %             Airport_Report_File.TimeExitRunway=TimeExit;
            Airport_Report_File.Taxi_In_Out_Dur=Real_Flights.Track.recTime(IndexEnteredRunway)-Real_Flights.Track.recTime(1);
            Airport_Report_File.Avg_Taxi_Speed = mean(Speed_Profiles.SmoothSpeedMs(1:IndexEnteredRunway));
            Number_Of_Days2 =TimeExit/ (24 * 3600); % Number of days since 01/01/1970 for track point
            Actual_Date_In_Days2 = Base_Date_Number + Number_Of_Days2;
            Airport_Report_File.Exit_Rwy_Time = datestr(Actual_Date_In_Days2, 'yyyy-mm-dd  HH:MM:SS'); % Time formatted HH:MM:SS
%             Airport_Report_File.IndexExit=IndexExit;
            Airport_Report_File.EnterRwy_ExitRwy_Dur=TimeExit-Time_Profile(IndexEnteredRunway);
        end %if isempty(Airport_Report_File.Operational_Runway) == 0
        
    end %if isempty(First_Point_Passing_Threshold.Latitude) == 1
end %for j=1:length(Latitude)

% for js=2:length(Real_Flights.Track.latitude)
%     Speed_Profiles.distance(js)=distdim(distance(Real_Flights.Track.latitude(js-1),Real_Flights.Track.longitude(js-1),...
%         Real_Flights.Track.latitude(js),Real_Flights.Track.longitude(js)),'deg','m');
%     Speed_Profiles.Speed(js)=1.94384*Speed_Profiles.distance(js)/(Real_Flights.Track.recTime(js)-Real_Flights.Track.recTime(js-1));
% end

if isempty(Airport_Report_File.Enter_Rwy_Lat)==0
    Airport_Report_File.Taxi_Dist=sum(Speed_Profiles.distance(1:IndexEnteredRunway));
    
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
    waiting_time_Based_on_TaxiSpeed           = waitingtimefinder(TimesSlowerThanAverageTaxing,TypicalSlowFlights,Real_Flights.Track.recTime);
    
    Airport_Report_File.Wait_Time_Under_3                   = waiting_time_Based_on_TaxiSpeed(1);
    %     Airport_Report_File.waiting_time_lowerThanTypicalTaxiSp = waiting_time_Based_on_TaxiSpeed(2);
    %     Airport_Report_File.Estimated_AverageTaxiTime           = Airport_Report_File.Taxi_Dist/Airport_Report_File.Avg_Taxi_Speed;
    Airport_Report_File.Taxi_Time_Minus_Wait                = Airport_Report_File.Taxi_In_Out_Dur-Airport_Report_File.Wait_Time_Under_3;
    %     Airport_Report_File.Estimated_UnimpededTime_Second      = Airport_Report_File.Taxi_In_Out_Dur- Airport_Report_File.waiting_time_lowerThanTypicalTaxiSp;
    Airport_Report_File.Index_Main_File = Counter;
end %if isempty(Airport_Report_File.Enter_Rwy_Lat)==0

if isempty(Airport_Report_File.Enter_Rwy_Lat)==1
    Airport_Report_File.Enter_Rwy_Lat                 = [];
    Airport_Report_File.Enter_Rwy_Long                = [];
    Airport_Report_File.Operational_Runway            = 'No Lat/Long Found';
    %     Airport_Report_File.Error1                      ='Not lat/Long found!';
    Airport_Report_File.Airport                       = AirportName;
    %Airport_Report_File.Touchdown_WheelsOff_Struct   =[];
    Airport_Report_File.EnterRwy_On_Off_Dur           = [];
    Airport_Report_File.On_Off_Lat                    = [];
    Airport_Report_File.On_Off_Long                   = [];
    Airport_Report_File.EnterRwy_On_Off_Dist          = [];
    %     Airport_Report_File.Touchdown_Altitude      = [];
    %     Airport_Report_File.Touchdown_Index             = [];
%     Airport_Report_File.Index_of_the_Entry_Runway   = [];
    %     Airport_Report_File.Time_at_threshold_Seconds_A_D = [];
    %     Airport_Report_File.Time_at_threshold_Hour_Minute_A_D=[];
    Airport_Report_File.Enter_Rwy_Time                = [];
    Airport_Report_File.Near_Gate_Lat                 = [];
    Airport_Report_File.Near_Gate_Long                = [];
    Airport_Report_File.Gate_Label                    = [];
    Airport_Report_File.Operation                     = Real_Flights.Header.opsType;
    Airport_Report_File.Flight_Key                    = Real_Flights.Header.fltKey;
    Airport_Report_File.Flight_ID                     = Real_Flights.Header.acId;
    Airport_Report_File.Aircraft_Type                 = Real_Flights.Header.acType;
    Airport_Report_File.Taxi_In_Out_Dur               = [];
    Airport_Report_File.Avg_Taxi_Speed                = [];
    %     Airport_Report_File.Altitude_By_Passing_Time_ART_DRT=[];
    Airport_Report_File.Exit_Rwy_Lat                  = [];
    Airport_Report_File.Exit_Rwy_Long                 = [];
    Airport_Report_File.Exit_Rwy_Time                 = [];
    %     Airport_Report_File.Exit_Rwy_Time                 = [];
%     Airport_Report_File.IndexExit                 = [];
    Airport_Report_File.Taxi_Dist                     = [];
    %     Airport_Report_File.waiting_time_zeroDist         = [];
    Airport_Report_File.EnterRwy_ExitRwy_Dur          = [];
    Airport_Report_File.Wait_Time_Under_3             = [];
    %     Airport_Report_File.waiting_time_lowerThanTypicalTaxiSp = [];
    %     Airport_Report_File.Estimated_AverageTaxiTime     = [];
    Airport_Report_File.Taxi_Time_Minus_Wait          = [];
    %     Airport_Report_File.Estimated_UnimpededTime_Second      = [];
    Airport_Report_File.Index_Main_File                     = Counter;
    %     Airport_Report_File.Error='Not lat/Long found!';
    
    
    
end %if isempty(Airport_Report_File.Enter_Rwy_Lat)==1
end%for i:1:RFL

