function DAQ_aquire
%%ABOUT THIS FUNCTION

%This is a general function for aquiring data from a DAQ created by Amberle 
%McKee. To modify this code for your particular application, follow these 
%steps:
%1)Run this line of code (d = daqlist("ni")) and look in the first 
%  column of the output to determine your device's ID
%2)Scroll to the section marked "Aquisition" and adjust the value for
%dq.Rate to the acquisition rate of your choice.
%3)Change the addinput functions in the following ways
%    -replace the second input with your device's ID in ""
%    -replace the third input with the analog channel you want to aquire
%    data from in ""
%    -replace the fourth input with they type of data you are looking for.
%    The options include, "Audio","Bridge","Current","Digital","EdgeCount",
%    "Frequency","IEPE","Microphone","Position","PulseWidth","RTD",
%    "Thermocouple","Voltage"
%4)Repeat step 3 adding as many addinput functions as you require until you
%  have one function per input you wish to read from.
%5)Find the line that reads "data = read(dq, seconds(1));"
%6)Adjust the second input in this read function to either the duration you
%  would like to record for by changing the number in seconds() or change 
%  this input to a number to specify the number of scans you would like to
%  record.
%7)Scroll to the section marked "Analysis" and adjust the figures to plot
%  the data that you are interested in.
%8)Scroll to the section marked "Save your data". If you do not wish to
%  save your data, comment these lines out. Otherwise, change the path to the 
%  destination you'd like your data to end up in. Then change the filename
%  (which is currently DataFromDAQ) to your preferred filename. This
%  filename will be followed by the date and time of saving, to ensure that
%  your files are not overwritten during subsequent trials.


%%
%%Find DAQ
d = daqlist("ni")
dq = daq("ni");

datetime
%%Acquisition
dq.Rate = 1000;%this is in scans per second
addinput(dq, "Dev3", "ai0", "Voltage");
addinput(dq, "Dev3", "ai1", "Voltage");
addinput(dq, "Dev3", "ai2", "Voltage");
addinput(dq, "Dev3", "ai3", "Voltage");
addinput(dq, "Dev3", "ai4", "Voltage");
addinput(dq, "Dev3", "ai5", "Voltage");
addinput(dq, "Dev3", "ai6", "Voltage");
addinput(dq, "Dev3", "ai7", "Voltage");
%addinput(dq, "Dev3", "ai8", "Voltage");


start(dq,"Continuous")
prompt = 'press 0 to stop';
x = input(prompt)
data = read(dq, "all");

%Conversion
new.ai0=(1725.3*(data.Dev3_ai0-0.0351))-255.37;
new.ai1=(1711.3*(data.Dev3_ai1-0.0206))-967.03;
new.ai2=(1787.7*(data.Dev3_ai2-0.0341))-681.5;
new.ai3=(1899*(data.Dev3_ai3-0.0105))-693.06;
new.ai4=(1803.5*(data.Dev3_ai4-0.0341))-676.53;
new.ai5=(1814.4*(data.Dev3_ai5-0.0231))-470.68;
new.ai6=(1788.7*(data.Dev3_ai6-0.0479))-735.9;
new.ai7=(1869.7*(data.Dev3_ai7-0.0339))-760.87;

%% Plot raw

figure
plot(data.Time,data.Dev3_ai3)
hold on
plot(data.Time,data.Dev3_ai2)
% hold on
% plot(data.Time,data.Dev3_ai3)
% hold on
% plot(data.Time,data.Dev3_ai0)
xlabel('Time (s)')
ylabel('Pressure (voltage from sensors)')
legend('S4','S3')

%% Analysis
% figure
% plot(data.Time, data.Variables);
% ylabel("Voltage (V)")

if 1

figure
subplot(2,4,1)
plot(data.Time, new.ai0);
ylabel("Pascals")
title("Sensor 1")
ylim([-2000,2000])

subplot(2,4,2)
plot(data.Time, new.ai1);
ylabel("Pascals")
title("Sensor 2")
ylim([-2000,2000])

subplot(2,4,3)
plot(data.Time, new.ai2);
ylabel("Pascals")
title("Sensor 3")
ylim([-2000,2000])

subplot(2,4,4)
plot(data.Time, new.ai3);
ylabel("Pascals")
title("Sensor 4")
ylim([-2000,2000])

subplot(2,4,5)
plot(data.Time, new.ai4);
ylabel("Pascals")
title("Sensor 5")
ylim([-2000,2000])

subplot(2,4,6)
plot(data.Time, new.ai5);
ylabel("Pascals")
title("Sensor 6")
ylim([-2000,2000])

subplot(2,4,7)
plot(data.Time, new.ai6);
ylabel("Pascals")
title("Sensor 7")
ylim([-2000,2000])

subplot(2,4,8)
plot(data.Time, new.ai7);
ylabel("Pascals")
title("Sensor 8")
ylim([-2000,2000])

end

%%Save your data
path='G:\My Drive\Postdoc with Dorgan\Gait Change Project\DAQ_Acquisition\';
save([path datestr(now,'mm-dd-yyyy HH-MM') '.mat'],'data');

end
