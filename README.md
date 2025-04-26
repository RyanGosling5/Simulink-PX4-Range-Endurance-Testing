# Simulink-PX4-Range-Endurance-Testing
SIL PX4 + quadcopter model in simulink originally meant for controller tuning modified to test range and endurance

*Files Located in the master branch*

Link to original Model: 
https://www.mathworks.com/help/uav/px4/ref/simulator-plant-model-example.html

Modifications made:

-Implemented velocity commands through sliders as well as an automated test run
-Implemented a dynamically scaling controller keeping the UAV steady in lateral wind
-Overhauled the thrust and torque modelling- replaced linear scaling with throttle with a Blade Element Theory model that reads propeller geometry stored in an xlsx file
-Added power draw calculations that account for motor efficiency (endurance is generated as a timeseries and calculated as a ratio of specified battery capacity and power draw at a given time)
-Switched the state-space model to the global coordinate system

How to use
1. Go to scripts and run InitVars.m This contains settings for quadcopter parameters as well as wind conditions
2. Open Models>QuadcopterSimulation.xlsx
3. To run the automated test, set Direct Velocity Command switch to on and all the sliders to 0
4. Run the simulation
5. Run Scripts>process_data.m to extract the data for desired velocities

How the automated test works
The UAV initially hovers for 30 seconds, then every 30 seconds the commanded velocity is increased by a specified amount. The post processing script extracts the velocity and endurance data for each time period and averages them out. Using a long time period for each velocity prevents the time accelerating from significantly altering the results

Notes:
-The PID controller for velocity will need re-tuning if the UAV parameters are changed. It can be found in QuadcopterSimulation/Controller>Controller Model>/Controller>Position & Altitude controller>PID_vx
-Velocity increments need to be modified within the model (QuadcopterSimulation>Commands>MATLAB function fcn)
-The only velocity slider currently working is the X-velocity, the other two can be reconnected to the output in QuadcopterSimulation>Commands
-The x-velocity command has some steady state error, particularly at higher velocities. This can be accounted for by commanding higher speeds and interpolating for the ones of interest
-Running InitVArs.m is essential as the model will not receive the correct UAV parameters otherwise
