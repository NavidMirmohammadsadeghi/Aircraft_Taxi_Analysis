
function [latExit,longExit,TimeExit,IndexExit]=LeavingMoment(Index_Runway_Polygon,IndexEnteredRunway,Latitude_Profile,Longitude_Profile,Time_Profile,AirportsCoordinates,AirportName)

[in,~] = inpolygon(Longitude_Profile(IndexEnteredRunway+2:end),Latitude_Profile(IndexEnteredRunway+2:end),AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon},AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon+1});

IndexExit = find(in ~= 1 , 1, 'first') + IndexEnteredRunway;

latExit  = Latitude_Profile(IndexExit);
longExit = Longitude_Profile(IndexExit);
TimeExit = Time_Profile(IndexExit);

% LPL=length(Latitude_Profile);
% 
% latExit=[];
% 
% for i=IndexEnteredRunway:LPL
%     
%     if isempty(latExit) == 1
%             [in,~]= inpolygon(Longitude_Profile(i),Latitude_Profile(i),AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon},AirportsCoordinates.(AirportName).Runway{1,Index_Runway_Polygon+1});
%             if (in~=1)
%                 TimeExit=Time_Profile(i);
%                 IndexExit=i;
%                 latExit=Latitude_Profile(i);
%                 longExit=Longitude_Profile(i);
%             end
%     end
% %     if isempty(Leaving_Moment(i).Time)==0
% %         Leaving_Moment=Leaving_Moment(~arrayfun(@(s) any(structfun(@isempty,s)),Leaving_Moment));
% %         return
% %     end
% %     TimeExit=Leaving_Moment
% end

end


    