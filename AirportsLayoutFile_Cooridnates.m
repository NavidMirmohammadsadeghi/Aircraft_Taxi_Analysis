
% This Script should contain all the coordination infromation for all the
% surfaces at the six airports provided with ASDE-X data, It will produce a
% structure file containing the names of the airports, then runways,
% taxiways, and gate areas,
%%% gathered by: Navid Mirmohammadsadeghi
%%% Initial Date: 1/21/17
%%%% Note that these data must be updated untill each surface polygon can
%%%% be read by Matlab

clc;

clear;

output_directory='C:\OnGoing Projects\DATA for Individual Runs\ASDEX\All the airports_Real FLights';

Airport_Name='ATL';

load([output_directory,'\AirportsLayoutFile.mat'])

load([output_directory,'\Runway_Information_ORD.mat'])

load([output_directory,'\' Airport_Name '.mat'])

LA=length(Airport);

Runway_Label={};

Number_Of_Runways=9;

for i=1:LA-1
    

j=4*i-3;
    
    if strcmp(Airport(i).element_feature_type,'aixm_RunwayElement') == 1 && (strcmp(Airport(i).element_sub_type,'NORMAL') == 1 || strcmp(Airport(i).element_sub_type,'DISPLACED') == 1)
        
        match=find(strcmp(Airport(i).label,Runway_Label)==1);
        if isempty(match)==1
            
            Runway_Label(i)=Airport(i).label;
            
            Runway_File=PolygonMaker(Airport,Runway_Label(i));
            %         Index1=find(Airport(i).extent{1,1}(:,1)== max(Airport(i).extent{1,1}(:,1)));
            %         Index2=find(Airport(i).extent{1,1}(:,1)== min(Airport(i).extent{1,1}(:,1)));
            %         Index3=find(Airport(i).extent{1,1}(:,2)== max(Airport(i).extent{1,1}(:,2)));
            %         Index4=find(Airport(i).extent{1,1}(:,2)== min(Airport(i).extent{1,1}(:,2)));
            
            Index1=find(Runway_File{1}(:,1)== max(Runway_File{1}(:,1)));
            Index2=find(Runway_File{1}(:,1)== min(Runway_File{1}(:,1)));
            Index3=find(Runway_File{1}(:,2)== max(Runway_File{1}(:,2)));
            Index4=find(Runway_File{1}(:,2)== min(Runway_File{1}(:,2)));
            
            %         AirportsCoordinates.(Airport_Name).Runway{1,j}=[min(Airport(i).extent{1,1}(:,1))  Airport(i).extent{1,1}(Index4(1),1) max(Airport(i).extent{1,1}(:,1)) Airport(i).extent{1,1}(Index3(1),1)];
            %         AirportsCoordinates.(Airport_Name).Runway{1,j+1}=[Airport(i).extent{1,1}(Index2(1),2)  min(Airport(i).extent{1,1}(:,2))  Airport(i).extent{1,1}(Index1(1),2)  max(Airport(i).extent{1,1}(:,2))];
            %         if cellfun('length',Airport(i).label)== 11
            %         AirportsCoordinates.(Airport_Name).Runway{1,j+2}=cellfun(@(x) x(5:7),Airport(i).label(cellfun('length',Airport(i).label) > 1),'un',0);
            %         AirportsCoordinates.(Airport_Name).Runway{1,j+3}=cellfun(@(x) x(9:11),Airport(i).label(cellfun('length',Airport(i).label) > 1),'un',0);
            %         else
            %         AirportsCoordinates.(Airport_Name).Runway{1,j+2}=cellfun(@(x) x(5:6),Airport(i).label(cellfun('length',Airport(i).label) > 1),'un',0);
            %         AirportsCoordinates.(Airport_Name).Runway{1,j+3}=cellfun(@(x) x(8:9),Airport(i).label(cellfun('length',Airport(i).label) > 1),'un',0);
            %         end
            
            AirportsCoordinates.(Airport_Name).Runway{1,j}=[min(Runway_File{1}(:,1))  Runway_File{1}(Index4(1),1) max(Runway_File{1}(:,1)) Runway_File{1}(Index3(1),1)];
            AirportsCoordinates.(Airport_Name).Runway{1,j+1}=[Runway_File{1}(Index2(1),2)  min(Runway_File{1}(:,2))  Runway_File{1}(Index1(1),2)  max(Runway_File{1}(:,2))];
            if cellfun('length',Airport(i).label)== 11
                AirportsCoordinates.(Airport_Name).Runway{1,j+2}=cellfun(@(x) x(5:7),Airport(i).label(cellfun('length',Airport(i).label) > 1),'un',0);
                AirportsCoordinates.(Airport_Name).Runway{1,j+3}=cellfun(@(x) x(9:11),Airport(i).label(cellfun('length',Airport(i).label) > 1),'un',0);
            else
                AirportsCoordinates.(Airport_Name).Runway{1,j+2}=cellfun(@(x) x(5:6),Airport(i).label(cellfun('length',Airport(i).label) > 1),'un',0);
                AirportsCoordinates.(Airport_Name).Runway{1,j+3}=cellfun(@(x) x(8:9),Airport(i).label(cellfun('length',Airport(i).label) > 1),'un',0);
            end
        else
        end
    end
end

%% For ORD
%It seems that the the aixm files are not precisley reporting the correct
%coordinations, therefore for ORD I will replace with the the other source
%lat,long

AirportsCoordinates.ORD.Runway{1,1}=[-87.9334503000000,-87.9105196899999,-87.9099522449999,-87.9328843060000];
AirportsCoordinates.ORD.Runway{1,2}=[41.9902910910001,41.9699181870001,41.9702719580001,41.9906449820001];
AirportsCoordinates.ORD.Runway{1,3}='14R';
AirportsCoordinates.ORD.Runway{1,4}='32L';

AirportsCoordinates.ORD.Runway{1,5}=[-87.9141387399999,-87.9137079989999,-87.8961582040000,-87.8965879799999];
AirportsCoordinates.ORD.Runway{1,6}=[41.9818003980001,41.9815321110000,41.9974172050000,41.9976817460001];
AirportsCoordinates.ORD.Runway{1,7}='04L';
AirportsCoordinates.ORD.Runway{1,8}='22R';


AirportsCoordinates.ORD.Runway{1,9}=[-87.8996330310000,-87.8992139810000,-87.8795401210000,-87.8799570490000];
AirportsCoordinates.ORD.Runway{1,10}=[41.9534728280000,41.9531978620000,41.9697947610001,41.9700663120000];
AirportsCoordinates.ORD.Runway{1,11}='04R';
AirportsCoordinates.ORD.Runway{1,12}='22L';


AirportsCoordinates.ORD.Runway{1,13}=[-87.9155765050000,-87.8919285460000,-87.8915038130000,-87.9151497430000];
AirportsCoordinates.ORD.Runway{1,14}=[42.0023082280001,41.9812829710000,41.9815500650001,42.0025742390001];
AirportsCoordinates.ORD.Runway{1,15}='14L';
AirportsCoordinates.ORD.Runway{1,16}='32R';

AirportsCoordinates.ORD.Runway{1,17}=[-87.9266760833333,-87.9266760833333,-87.8990832500000,-87.8990832500000];
AirportsCoordinates.ORD.Runway{1,18}=[42.0030320555556,42.0026320555556,42.0026320555556,42.0030320555556];
AirportsCoordinates.ORD.Runway{1,19}='09L';
AirportsCoordinates.ORD.Runway{1,20}='27R';


AirportsCoordinates.ORD.Runway{1,21}=[-87.9183520000000,-87.9183520000000,-87.8890509444445,-87.8890509444445];
AirportsCoordinates.ORD.Runway{1,22}=[41.9840972777778,41.9836972777778,41.9836972777778,41.9840972777778];
AirportsCoordinates.ORD.Runway{1,23}='09R';
AirportsCoordinates.ORD.Runway{1,24}='27L';

AirportsCoordinates.ORD.Runway{1,25}=[-87.9315216111111,-87.9315216111111,-87.8918103055556,-87.8918103055556];
AirportsCoordinates.ORD.Runway{1,26}=[41.9659514166667,41.9654514166667,41.9654514166667,41.9659514166667];
AirportsCoordinates.ORD.Runway{1,27}='10C';
AirportsCoordinates.ORD.Runway{1,28}='28C';

AirportsCoordinates.ORD.Runway{1,29}=[-87.9315317222222,-87.9315317222222,-87.8837290000000,-87.8837290000000];
AirportsCoordinates.ORD.Runway{1,30}=[41.9691948888889,41.9687948888889,41.9687948888889,41.9691948888889];
AirportsCoordinates.ORD.Runway{1,31}='10L';
AirportsCoordinates.ORD.Runway{1,32}='28R';


AirportsCoordinates.ORD.Runway{1,33}=[-87.9278612222222,-87.9278612222222,-87.9002876388889,-87.9002876388889];
AirportsCoordinates.ORD.Runway{1,34}=[41.9574011111111,41.9570011111111,41.9570011111111,41.9574011111111];
AirportsCoordinates.ORD.Runway{1,35}='10R';
AirportsCoordinates.ORD.Runway{1,36}='28L';
%Deleting Empty Cells
AirportsCoordinates.(Airport_Name).Runway=AirportsCoordinates.(Airport_Name).Runway(~arrayfun(@(s) any(cellfun(@isempty,s)),AirportsCoordinates.(Airport_Name).Runway));


  



    
AirportsCoordinates.IAH.Runway{1,5}(2)=-95.3588;
%% For ATL:

%Runways:

% AirportsCoordinates.ATL.Runways.R10_28_x=[-84.447875 -84.447875 -84.4183 -84.4183];
% AirportsCoordinates.ATL.Runways.R10_28_y=[33.6205 33.6201 33.6201 33.6205];
% 
% AirportsCoordinates.ATL.Runways.R9R_27L_x=[-84.4480 -84.4480 -84.4184 -84.4184];
% AirportsCoordinates.ATL.Runways.R9R_27L_y=[33.6320 33.6316 33.6316 33.6320];
% 
% AirportsCoordinates.ATL.Runways.R9L_27R_x=[-84.4480 -84.4480 -84.4073 -84.4073];
% AirportsCoordinates.ATL.Runways.R9L_27R_y=[33.6349 33.6345 33.6345 33.6349];
% 
% AirportsCoordinates.ATL.Runways.R8R_26L_x=[-84.4384 -84.4384 -84.4055 -84.4055];
% AirportsCoordinates.ATL.Runways.R8R_26L_y=[33.6470 33.6466 33.6466 33.6470];
% 
% AirportsCoordinates.ATL.Runways.R8L_26R_x=[-84.4390 -84.4390 -84.4095 -84.4095];
% AirportsCoordinates.ATL.Runways.R8L_26R_y=[33.6498 33.6494 33.6494 33.6498];



%Temporary Naming
AirportsCoordinates.ATL.Runway{1,1}=[-84.447875 -84.447875 -84.4183 -84.4183];
AirportsCoordinates.ATL.Runway{1,2}=[33.6205 33.6201 33.6201 33.6205];
AirportsCoordinates.ATL.Runway{1,3}='10';
AirportsCoordinates.ATL.Runway{1,4}='28';

AirportsCoordinates.ATL.Runway{1,5}=[-84.4480 -84.4480 -84.4184 -84.4184];
AirportsCoordinates.ATL.Runway{1,6}=[33.6320 33.6316 33.6316 33.6320];
AirportsCoordinates.ATL.Runway{1,7}='09R';
AirportsCoordinates.ATL.Runway{1,8}='27L';

AirportsCoordinates.ATL.Runway{1,9}=[-84.4480 -84.4480 -84.4073 -84.4073];
AirportsCoordinates.ATL.Runway{1,10}=[33.6349 33.6345 33.6345 33.6349];
AirportsCoordinates.ATL.Runway{1,11}='09L';
AirportsCoordinates.ATL.Runway{1,12}='27R';

AirportsCoordinates.ATL.Runway{1,13}=[-84.4384 -84.4384 -84.4055 -84.4055];
AirportsCoordinates.ATL.Runway{1,14}=[33.6470 33.6466 33.6466 33.6470];
AirportsCoordinates.ATL.Runway{1,15}='08R';
AirportsCoordinates.ATL.Runway{1,16}='26L';

AirportsCoordinates.ATL.Runway{1,17}=[-84.4390 -84.4390 -84.4095 -84.4095];
AirportsCoordinates.ATL.Runway{1,18}=[33.6498 33.6494 33.6494 33.6498];
AirportsCoordinates.ATL.Runway{1,19}='08L';
AirportsCoordinates.ATL.Runway{1,20}='26R';

%Taxiways: % At the current moment I just draw parallel lines with the
%runways with possitive, negative buffers to have imaginary taxiway
%surfaces

for i=1:4:length(AirportsCoordinates.ATL.Runway)-3
    j=i+3;
    AirportsCoordinates.ATL.Parallel_Taxiway{1,i}=AirportsCoordinates.ATL.Runway{1,i};
    AirportsCoordinates.ATL.Parallel_Taxiway{1,i+1}=[AirportsCoordinates.ATL.Runway{1,i+1}(1)+(AirportsCoordinates.ATL.Runway{1,i+1}(1)-AirportsCoordinates.ATL.Runway{1,i+1}(2))...
        ,AirportsCoordinates.ATL.Runway{1,i+1}(1),AirportsCoordinates.ATL.Runway{1,i+1}(1),AirportsCoordinates.ATL.Runway{1,i+1}(1)+(AirportsCoordinates.ATL.Runway{1,i+1}(1)-AirportsCoordinates.ATL.Runway{1,i+1}(2))...
        ];
    AirportsCoordinates.ATL.Parallel_Taxiway{1,i+2}=[AirportsCoordinates.ATL.Runway{1,i+1}(2),AirportsCoordinates.ATL.Runway{1,i+1}(2)-(AirportsCoordinates.ATL.Runway{1,i+1}(1)-...
        AirportsCoordinates.ATL.Runway{1,i+1}(2)),AirportsCoordinates.ATL.Runway{1,i+1}(2)-(AirportsCoordinates.ATL.Runway{1,i+1}(1)-...
        AirportsCoordinates.ATL.Runway{1,i+1}(2)),AirportsCoordinates.ATL.Runway{1,i+1}(2)];
    %     AirportsCoordinates.ATL.Parallel_Taxiway{1,j}=AirportsCoordinates.ATL.Runway{1,i+2};
end



%Gate Areas:
%For Atlanta I categorized the Gate areas to 10 areas, A to J
AirportsCoordinates.ATL.GateAreas{1,1}=[-84.4425 -84.4393];
AirportsCoordinates.ATL.GateAreas{1,2}=[33.6370 33.6441];
AirportsCoordinates.ATL.GateAreas{1,3}='ZoneA';


AirportsCoordinates.ATL.GateAreas{1,4}=[-84.4391 -84.4359];
AirportsCoordinates.ATL.GateAreas{1,5}=[33.6441 33.6371];
AirportsCoordinates.ATL.GateAreas{1,6}='ZoneB';

AirportsCoordinates.ATL.GateAreas{1,7}=[-84.4357 -84.4326];
AirportsCoordinates.ATL.GateAreas{1,8}=[33.6441 33.6371];
AirportsCoordinates.ATL.GateAreas{1,9}='ZoneC';

AirportsCoordinates.ATL.GateAreas{1,10}=[-84.4326 -84.4293];
AirportsCoordinates.ATL.GateAreas{1,11}=[33.6441 33.6371];
AirportsCoordinates.ATL.GateAreas{1,12}='ZoneD';

AirportsCoordinates.ATL.GateAreas{1,13}=[-84.4293 -84.4259];
AirportsCoordinates.ATL.GateAreas{1,14}=[33.6441 33.6371];
AirportsCoordinates.ATL.GateAreas{1,15}='ZoneE';

AirportsCoordinates.ATL.GateAreas{1,16}=[-84.4256 -84.4225];
AirportsCoordinates.ATL.GateAreas{1,17}=[33.6443 33.6370];
AirportsCoordinates.ATL.GateAreas{1,18}='ZoneF';

AirportsCoordinates.ATL.GateAreas{1,19}=[-84.4223 -84.4199];
AirportsCoordinates.ATL.GateAreas{1,20}=[33.6412 33.6368];
AirportsCoordinates.ATL.GateAreas{1,21}='ZoneG';

AirportsCoordinates.ATL.GateAreas{1,22}=[-84.4199 -84.4167];
AirportsCoordinates.ATL.GateAreas{1,23}=[33.6402 33.6367];
AirportsCoordinates.ATL.GateAreas{1,24}='ZoneH';

AirportsCoordinates.ATL.GateAreas{1,25}=[-84.43 -84.4228];
AirportsCoordinates.ATL.GateAreas{1,26}=[33.6299 33.6254];
AirportsCoordinates.ATL.GateAreas{1,27}='ZoneI';

AirportsCoordinates.ATL.GateAreas{1,28}=[-84.4172 -84.4065];
AirportsCoordinates.ATL.GateAreas{1,29}=[33.6448 33.6423];
AirportsCoordinates.ATL.GateAreas{1,30}='ZoneJ';

AirportsCoordinates.ATL.GateAreas{1,31}=[-84.435 -84.4116];
AirportsCoordinates.ATL.GateAreas{1,32}=[33.657 33.65115];
AirportsCoordinates.ATL.GateAreas{1,33}='ZoneK';

%% For JFK:

%Runways:
%Gate Areas 
%They are from A to R

% AirportsCoordinates.JFK.Runway{1,1}=[-73.7707 -73.7552 -73.7546 -73.7701];
% AirportsCoordinates.JFK.Runway{1,2}=[40.6256  40.6454 40.6451 40.6253];
% AirportsCoordinates.JFK.Runway{1,3}='4R';
% AirportsCoordinates.JFK.Runway{1,4}='22L';
% 
% AirportsCoordinates.JFK.Runway{1,5}=[-73.7858 -73.7854 -73.7645 -73.7649 ];
% AirportsCoordinates.JFK.Runway{1,6}=[40.6221 40.6219 40.6487 40.6489];
% AirportsCoordinates.JFK.Runway{1,7}='4L';
% AirportsCoordinates.JFK.Runway{1,8}='22R';
% 
% AirportsCoordinates.JFK.Runway{1,9}=[-73.8166 -73.8169  -73.7720 -73.7716];
% AirportsCoordinates.JFK.Runway{1,10}=[40.6486 40.6481 40.6278 40.6282];
% AirportsCoordinates.JFK.Runway{1,11}='13R';
% AirportsCoordinates.JFK.Runway{1,12}='31L';
% 
% AirportsCoordinates.JFK.Runway{1,13}=[-73.7901 -73.7904  -73.7594  -73.7591];
% AirportsCoordinates.JFK.Runway{1,14}=[40.6580 40.6576 40.6435 40.6439];
% AirportsCoordinates.JFK.Runway{1,15}='13L';
% AirportsCoordinates.JFK.Runway{1,16}='31R';

%Gate_Areas (Zones)



%% Saving the Structure File

save([output_directory,'\AirportsLayoutFile.mat'],'AirportsCoordinates');

