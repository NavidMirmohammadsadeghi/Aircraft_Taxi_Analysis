
function [latExit,longExit,TimeExit,IndexExit]=ExitingRunwayArrival(Index_Runway_Polygon,Index_of_entry_Runway,Time_Profile,Latitude_Profile,Longitude_Profile,AirportsCoordinates,AirportName)

[in,on] = inpolygon(Longitude_Profile(Index_of_entry_Runway+1:end),Latitude_Profile(Index_of_entry_Runway+1:end),AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon},AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon+1});

IndexExit = find(in ~= 1 | on == 1, 1, 'first') + Index_of_entry_Runway;

latExit  = Latitude_Profile(IndexExit);
longExit = Longitude_Profile(IndexExit);
TimeExit = Time_Profile(IndexExit);

% latExit=[];
% longExit=[];
% TimeExit=[];
% IndexExit=[];
% 
% 
% 
% for j=Index_of_entry_Runway+1:length(Latitude_Profile)
%     
%     
%     if isempty(latExit) == 1
%         [in,on]= inpolygon(Longitude_Profile(j),Latitude_Profile(j),AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon},AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon+1});
%         if (in~=1 || on ==1)
%             
%             latExit=Latitude_Profile(j);
%             longExit=Longitude_Profile(j);
%             IndexExit=j;
%             %                     Exits_Happened(i).Name_Of_Runway=AirportsCoordinates.(AirportName).Runway{k+2};
%             TimeExit=Time_Profile(j);
%             
%             
%         end
%         
%     end
% end

return;