
function Touchdown=WheelsOff(Altitude_Profile,~,Real_Time_Threshold_Pass,Time_Profile,Latitude_Profile,Longitude_Profile,Middle_Point_Threshold,IndexEnteredRunway,Index_Departure_Runway)

% APL=length(Altitude_Profile);
% 
% for i=IndexEnteredRunway:APL
%     
%     Touchdown(i).Time=[];
    
%     try
%         if Altitude_Profile(i+10)-Altitude_Profile(i)>=1
            
            Touchdown.Location.Latitude=Latitude_Profile(Index_Departure_Runway+5);
            Touchdown.Location.Longitude=Longitude_Profile(Index_Departure_Runway+5);
            Touchdown.TouchdownDistance=distdim(distance(Touchdown.Location.Latitude,Touchdown.Location.Longitude,Middle_Point_Threshold(2),Middle_Point_Threshold(1)),'deg','m');
            Touchdown.Time=Time_Profile(Index_Departure_Runway+5)-Real_Time_Threshold_Pass;
            Touchdown.altitude=Altitude_Profile(Index_Departure_Runway+5);
            Touchdown.MomentOfTouchDown=Index_Departure_Runway+5;
%         end
%         
%         
%     catch
%     end
%     if isempty(Touchdown(i).Time)==0
%         
%         break
%         
%     end
%     
% end
% Touchdown=Touchdown(~arrayfun(@(s) any(structfun(@isempty,s)),Touchdown));
end
