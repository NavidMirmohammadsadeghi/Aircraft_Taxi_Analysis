
function waiting_time_Based_on_TaxiSpeed = waitingtimefinder(TimesSlowerThanAverageTaxing,TypicalSlowFlights,Time_Profile)

waiting_time_initial         = zeros(length(TimesSlowerThanAverageTaxing));
if length(TimesSlowerThanAverageTaxing)>1
    for kw=2:length(TimesSlowerThanAverageTaxing)
        waiting_time_initial(kw)=Time_Profile(TimesSlowerThanAverageTaxing(kw))-Time_Profile(TimesSlowerThanAverageTaxing(kw)-1);
    end
    waiting_time_Based_on_TaxiSpeed_First=sum(waiting_time_initial);
else
    waiting_time_Based_on_TaxiSpeed_First=0;
end
waiting_time_second         = zeros(length(TypicalSlowFlights));
if length(TypicalSlowFlights)>1
    for kw=2:length(TypicalSlowFlights)
        waiting_time_second (kw)=Time_Profile(TypicalSlowFlights(kw))-Time_Profile(TypicalSlowFlights(kw)-1);
    end
    waiting_time_Based_on_TaxiSpeed_Second=sum(waiting_time_second);
else
    waiting_time_Based_on_TaxiSpeed_Second=0;
end
waiting_time_Based_on_TaxiSpeed(1) = waiting_time_Based_on_TaxiSpeed_First(1);
waiting_time_Based_on_TaxiSpeed(2) = waiting_time_Based_on_TaxiSpeed_Second(1);
end
