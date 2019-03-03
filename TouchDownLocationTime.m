%%% Written by: Navid Mirmohammadsadeghi
%%% 1/20/17

%THis script shows the touchdown location and calculates the distance from
%runway threshold and also the time it took for the plane to touch down the
%runway

function Touchdown=TouchDownLocationTime(Altitude_Profile,Airport_Default_Altitude,Real_Time_Threshold_Pass,Time_Profile,Latitude_Profile,Longitude_Profile,Middle_Point_Threshold,Speed_Profiles,Index_Runway_Polygon,...
    AirportsCoordinates,AirportName,Real_Flights,Index_of_entry_Runway)


LSPA = length(Speed_Profiles.acceleration);

Acceleration = sort(Speed_Profiles.acceleration,'ascend');


APL = length(Acceleration);

for i=1:APL
    
    %s = i+1;
    
    Touchdown(i).Time=[];
    
    Index_Acceleration=find(Speed_Profiles.acceleration==Acceleration(i));
    
    
    %else
    if inpolygon(Real_Flights.Track.longitude(Index_Acceleration(1)),Real_Flights.Track.latitude(Index_Acceleration(1)),AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon},AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon+1}) == 1
        Touchdown(i).Time=Time_Profile(Index_Acceleration(1)-10)-Real_Time_Threshold_Pass;
        if Touchdown(i).Time<3
            Touchdown(i).Time =3;
        elseif Touchdown(i).Time>12
            Touchdown(i).Time =12;
        end %if Touchdown(i).Time<3
        
        if Touchdown(i).Time==3
            Touchdown(i).Location.Latitude=Latitude_Profile(Index_of_entry_Runway+3);
            Touchdown(i).Location.Longitude=Longitude_Profile(Index_of_entry_Runway+3);
            Touchdown(i).TouchdownDistance=distdim(distance(Touchdown(i).Location.Latitude,Touchdown(i).Location.Longitude,Middle_Point_Threshold(2),Middle_Point_Threshold(1)),'deg','m');
            
            %         Touchdown(i).altitude=Altitude_Profile(Index_Acceleration(1)-10);
            Touchdown(i).MomentOfTouchDown=Index_of_entry_Runway+3;
            
        elseif Touchdown(i).Time==12
            
            Touchdown(i).Location.Latitude=Latitude_Profile(Index_of_entry_Runway+9);
            Touchdown(i).Location.Longitude=Longitude_Profile(Index_of_entry_Runway+9);
            Touchdown(i).TouchdownDistance=distdim(distance(Touchdown(i).Location.Latitude,Touchdown(i).Location.Longitude,Middle_Point_Threshold(2),Middle_Point_Threshold(1)),'deg','m');
            
            %         Touchdown(i).altitude=Altitude_Profile(Index_Acceleration(1)-10);
            Touchdown(i).MomentOfTouchDown=Index_of_entry_Runway+12;
            
        else
            Touchdown(i).Location.Latitude=Latitude_Profile(Index_Acceleration(1)-10);
            Touchdown(i).Location.Longitude=Longitude_Profile(Index_Acceleration(1)-10);
            Touchdown(i).TouchdownDistance=distdim(distance(Touchdown(i).Location.Latitude,Touchdown(i).Location.Longitude,Middle_Point_Threshold(2),Middle_Point_Threshold(1)),'deg','m');
            
            %         Touchdown(i).altitude=Altitude_Profile(Index_Acceleration(1)-10);
            Touchdown(i).MomentOfTouchDown=Index_Acceleration(1)-10;
            
        end %if Touchdown(i).Time==3
        
    end %if inpolygon(Real_Flights.Track.l...
    if isempty(Touchdown(i).Time)==0
        break
    end
    
end %for i=1:APL
Touchdown=Touchdown(~arrayfun(@(s) any(structfun(@isempty,s)),Touchdown));
end


