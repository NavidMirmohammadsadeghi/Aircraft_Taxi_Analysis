
% The main script running for both arrivals and departures
%%% Writen By: Navid Mirmohammadsadeghi


% clc;
% 
% clear;
% 
% close all;

Input_Dir='C:\Users\Navid\Documents\DATA for Individual Runs\ASDEX\All the airports_Real FLights';

Output_Dir= 'C:\Users\Navid\Documents\DATA for Individual Runs\ASDEX\All the airports_Real FLights\Final Outputs';

AirportName='DEN';

ChangeOfAltitudeCoef=0.2; %For Departures there is a requirement of changing altitude from a maximum acceleration point on runway to 20 points later,DEN is very high therefore it gets a lower coeff. (For rest of airports 20%)

% load([Input_Dir,'\' AirportName '_Flights_04_13_2017.mat']);
% Real_Flights_Final = Flights;
% clear Flights;
load([Input_Dir,'\' AirportName '_One_day.mat']);

load([Input_Dir,'\' AirportName '.mat']);

load([Input_Dir,'\AirportsLayoutFile.mat']);

load([Input_Dir,'\runways_' AirportName '.mat']);

Airport_Default_Altitude=6.68;

RFFL=length(Real_Flights_Final);

Counter=0;

for rf=1:RFFL 
    
    if mod(Counter,100) ==0
        disp(['Number of flights parsed:' num2str(Counter)]);
    end
    
    Counter=Counter+1;
    
    Real_Flights=Real_Flights_Final(rf);
    
    if strcmp(Real_Flights.Header.opsType,'A')==1
        Airport_Report_File(rf)=Arrival_Flights_Check(Real_Flights,AirportsCoordinates,AirportName,Airport_Default_Altitude,rws,Airport,Counter);
    elseif strcmp(Real_Flights.Header.opsType,'D')==1
        Airport_Report_File(rf)=Departure_Flights_Check(Real_Flights,AirportsCoordinates,AirportName,Airport_Default_Altitude,rws,ChangeOfAltitudeCoef,Airport,Counter);
%     else 
%         Airport_Report_Others(rf)=Real_Flights;
    end
end

%% Don't Uncomment the following part for the time that you want to check the flights in main Real_FLights_Final file
empty_cells=arrayfun(@(s) all(structfun(@ isempty,s)),Airport_Report_File);
Airport_Report_File_Pure=Airport_Report_File(~empty_cells);
% Airport_Report_File_Pure = rmfield(Airport_Report_File_Pure,'Index_Main_File');
% % empty_cells2=arrayfun(@(s) all(structfun(@ isempty,s)), Airport_Report_Others);
% % Flights_with_NFamiliar_opsType=Airport_Report_Others(~empty_cells2);
% Order_File = [14;15;13;16;4;3;9;1;2;5;6;7;8;22;21;17;18;10;11;12;19;20;23;24;25];
% Airport_Report_File_Pure = orderfields(Airport_Report_File_Pure,Order_File);
% % %% Saving The Files
% % save([Input_Dir,'\Flights_with_NFamiliar_opsType_' AirportName '.mat'],'Flights_with_NFamiliar_opsType');
% % save([Input_Dir,'\Airport_Report_File_' AirportName '.mat'],'Airport_Report_File');
% % Distance_below_3m=[Airport_Report_File.waiting_time_zeroDist];
% % Speed_below_3m = [Airport_Report_File.Wait_Time_Under_3];
% % Difference_Dist_Spd=Distance_below_3m-Speed_below_3m;
% % h=histogram(Difference_Dist_Spd);
% % Bins = h.BinEdges;
% % Value = h.Values;
% % Bins(1)=[];
% % hold on
% % plot(Bins,Value,'-r','MarkerSize',30)
% table= struct2table(Airport_Report_File_Pure);
% writetable(table,[Output_Dir,'\' AirportName '_Report.csv']);