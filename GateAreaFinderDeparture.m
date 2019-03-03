

%This Function will identify the Gate area of each registered Arrival

function GateArea=GateAreaFinderDeparture(RFATLL,Gate_File,Latitude_Profile,Longitude_Profile,Airport,AirportName)

GFL=length(Gate_File);

GateArea=[];

if strcmp(AirportName,'ATL') == 1
    
    for i=1:3:GFL-2
        if isempty(GateArea) == 0
            break
        else
            
            if inpolygon(Longitude_Profile(1),Latitude_Profile(1),Gate_File{i},Gate_File{i+1})== 1
                GateArea=Gate_File{i+2};
            end
        end
    end
else
    Gate_File_real = Airport(find(ismember([Airport.element_feature_type],'aixm_ApronElement') ==1));
    
    for i=1:length(Gate_File_real)
        if isempty(GateArea) == 0
            break
        else
            
            if inpolygon(Longitude_Profile(1),Latitude_Profile(1),Gate_File_real(i, 1).extent{1,1}(:,1),Gate_File_real(i,1).extent{1,1}(:,2))== 1
                GATE     = Gate_File_real(i).label ;
                GateArea = GATE{1};
            end
        end
    end
    
end %if strcmp(AirportName,'ATL') == 1


if isempty(GateArea) == 1
    GateArea{1,1}=Longitude_Profile(1);
    GateArea{1,2}=Latitude_Profile(1);
end

end




