
%% New script for extracting the locations of waiting times 
% this script calculates the speed profiles and distances taken but based
% on the indices it tells us where in airport they were waiting.

counter=0;

for i=1:length(Real_Flights_Final)
    if mod(counter,100) ==0
        disp(['Number of Flights Read:' num2str(counter)]);
    end
    counter=counter+1;
    
    for j=2:length(Real_Flights_Final(i).Track.latitude)
        Speed_Profiles(i).distance(j)=distdim(distance(Real_Flights_Final(i).Track.latitude(j-1),Real_Flights_Final(i).Track.longitude(j-1),...
            Real_Flights_Final(i).Track.latitude(j),Real_Flights_Final(i).Track.longitude(j)),'deg','m');
%         Speed_Profiles(i).Speed(j)=1.94384*Speed_Profiles(i).distance(j)/(Real_Flights_Final(i).Track.recTime(j)-Real_Flights_Final(i).Track.recTime(j-1));
    end
end

for i=1:length(Speed_Profiles)
    
    Stop_Moments_Index(i).Index=find(Speed_Profiles(i).distance==0);
    
end


counter2=0;

for wt=1:SPL
    if mod(counter2,100)== 0
        disp(['Numbers of Flights Analyzed:' num2str(counter2)]);
    end
    counter2=counter2+1;
    
    a=find(Speed_Profiles(wt).distance==0);
    if length(a)>1
        for k=2:length(a)
            waiting_time_initial(k)=Real_Flights_Final(wt).Track.recTime(a(k))-Real_Flights_Final(wt).Track.recTime(a(k)-1);
        end
        waiting_time(wt,1)=sum(waiting_time_initial);
    else
        waiting_time(wt,1)=0;
    end
   First_Point_Passing_Threshold(wt).waiting_time=waiting_time(wt); 
end