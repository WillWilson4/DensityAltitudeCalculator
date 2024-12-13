clear, clc

%{

William Wilson, AERE 161 Project 1, Question 2
Calculate the air density at the local Ames airport given whether specifics
from openweathermaps API and field elevation given to us. 

%}

key = '7cab1fcaf444883263bc48dd983e6018';
options = weboptions('ContentType','json');
url=['https://api.openweathermap.org/data/2.5/weather?q=','Ames','&APPID=',key];
CurrentData = webread(url, options);
%All the above code retreived the whether data from the openweathermaps API

tempK = CurrentData.main.temp; %Current temp in Kelvin stored in tempK obtained from openwhether maps API
pressure = CurrentData.main.pressure; %Current pressure in Milibar stored in pressure obtained from openwhether maps API
humidity = CurrentData.main.humidity; %Current humidity stored in humidity obtained from openwhether maps API

fieldelv = 955.6; %Field elevation of Ames Airport (KAMW) in ft

[tempC] = tempKtoC(tempK); %Calls a function that calculates the temp in C from the temp given in K

Dewpt = tempC-((100-humidity)/5); %Calculates dewpoint temp in C
Vaporpressure = (6.11*(10^((7.5*Dewpt)/(237.7+Dewpt)))); %Calculates Vapor Pressure in millibar

Virtualtemp = tempK/(1-((Vaporpressure/pressure)*(1-0.622))); %Calculated the virtual temperature in Kelvin
VirtualtempR = ((((9/5)*(Virtualtemp-273.15))+32)+459.69); %Takes the Virtual temp and converts it to Rankine

PressureinHG = (pressure*0.02953); %Calculates the pressure from Milibars to inches of Mercury

DensityAlt = fieldelv + (145366*(1-(((17.326*PressureinHG)/VirtualtempR)^0.235))); %Calculates the density altitude

fprintf('The density Alttitude of Ames Iowa is approximatley %0.4f ft.', DensityAlt) %Prints to the user what teh density altitude is in Ames Iowa from the airport








