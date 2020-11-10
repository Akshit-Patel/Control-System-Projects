q = (M+m)*(I+m*l^2)-(m*l)^2;
s = tf('s');
P_pend = (m*l*s/q)/(s^3 + (b*(I + m*l^2))*s^2/q - ((M + m)*m*g*l)*s/q - b*m*g*l/q)

%PID
Kp = 478.929755135173;%Proportional gain
Ki = 2436.99995313297; %Integral gain
Kd = 23.1174208067384;%Derivative gain
N = 587.1417669785;
C = Kp + Ki/s + ((Kd*s*N)/(s+N)); %PID Controller as implemented in simulink block
T = feedback(P_pend,C);

%Impulse response of Pendulum
t=0:0.001:10;
impulseplot(T,t);
title({'Response of Pendulum Position to an Impulse Disturbance';'under PID Control: Kp =478.92, Ki = 2436.9, Kd =587.141'});