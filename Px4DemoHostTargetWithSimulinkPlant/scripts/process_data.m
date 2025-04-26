n=30; %number of increments
begin_extraction=[8:5:163]+20;
end_extraction=[9:5:164]+20;
speed_range=[0:0.25:3.5, 3.65];
data=zeros(n, 3);
final_data=zeros(length(speed_range), 3);
for i=1:n
    lower_index=find(out.tout==begin_extraction(i));
    upper_index=find(out.tout==end_extraction(i));
    data(i, 1)=mean(out.Vxe(lower_index:upper_index));
    data(i, 2)=mean(out.endurance(lower_index:upper_index));
    data(i, 3)=data(i, 1)*data(i, 2)*60;
end


final_data(:, 1)=speed_range; %velocities tested
final_data(:, 2)=interp1(data(:, 1), data(:, 2), speed_range); %endurance
final_data(:, 3)=interp1(data(:, 1), data(:, 3), speed_range); %range