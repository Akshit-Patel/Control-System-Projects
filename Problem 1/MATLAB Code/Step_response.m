Ra = 0.45;                 %Per phase stator resistance
La = 0.035;              %Per phase stator inductance
B = 2e-4;              %Damping coefficient
J = 0.022;             %Moment of Inertia
Ke = 0.5;                %Torque c0nstant
Kt = 0.5;                %Back EMF constant

Kp =  4.19652540503482;
Ki =  35.8889727302617;
Kd =  0.1197446984208;
N = 905.389232075555;

a = J*La;
b = (J*Ra + B*La);
c = (B*Ra + Ke*Kt);

s=tf('s');

G = tf([0 0 Kt],[a b c])

[w,zeta] = damp(G)  % zeta calculation for transfer function
C = Kp + Ki/s + ((Kd*s*N)/(s+N)); %PID Controller 

H = feedback(C*G,1);
step(H) 