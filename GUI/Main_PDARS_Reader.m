
% The main script running for both arrivals and departures
%%% Writen By: Navid Mirmohammadsadeghi

function Result=Main_PDARS_Reader(Real_Flights_Final,Airport_Name,Output_Dir,Output_Name,Batch_Mode)


AirportName=Airport_Name;

ChangeOfAltitudeCoef=0.2; %For Departures there is a requirement of changing altitude from a maximum acceleration point on runway to 20 points later,DEN is very high therefore it gets a lower coeff. (For rest of airports 20%)



load([ AirportName '.mat']);

load('AirportsLayoutFile.mat');

load(['runways_' AirportName '.mat']);

Airport_Default_Altitude=6.68;



RFFL=length(Real_Flights_Final);



Counter=0;

h=waitbar(0,'Please wait...');

for rf=1:RFFL
    
    
    
    Counter=Counter+1;
    
    Real_Flights=Real_Flights_Final(rf);
    
    if strcmp(Real_Flights.Header.opsType,'A')==1
        Airport_Report_File(rf)=Arrival_Flights_Check(Real_Flights,AirportsCoordinates,AirportName,Airport_Default_Altitude,rws,Airport,Counter);
    elseif strcmp(Real_Flights.Header.opsType,'D')==1
        Airport_Report_File(rf)=Departure_Flights_Check(Real_Flights,AirportsCoordinates,AirportName,Airport_Default_Altitude,rws,ChangeOfAltitudeCoef,Airport,Counter);
        
    end
    
    waitbar(Counter/RFFL,h, 'Extracting Events');
end
waitbar(1,h,'Event Extraction is Complete');
pause(0.5);

%% Don't Uncomment the following part for the time that you want to check the flights in main Real_FLights_Final file
empty_cells=arrayfun(@(s) all(structfun(@ isempty,s)),Airport_Report_File);
Airport_Report_File_Pure=Airport_Report_File(~empty_cells);
Result=Airport_Report_File_Pure;
Airport_Report_File_Pure = rmfield(Airport_Report_File_Pure,'Index_Main_File');
Order_File = [14;15;13;16;4;3;9;1;2;5;6;7;8;22;21;17;18;10;11;12;19;20;23;24;25];
Airport_Report_File_Pure = orderfields(Airport_Report_File_Pure,Order_File);
Table                    = struct2table(Airport_Report_File_Pure);

if Batch_Mode==0
    writetable(Table,[Output_Dir,'\' Output_Name '.csv']);
    waitbar(1,h,'Output Saved!');
    % close(h);
else
    writetable(Table,[Output_Dir,'\Results_' Output_Name '.csv']);
    waitbar(1,h,'Output Saved!');
    close(h);
end
