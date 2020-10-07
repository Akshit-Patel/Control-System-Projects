% 2018A8PS0094P
% Akshit Patel

s = tf('s');
% lets take a following system
sys = (s+7)/((s)*(s+5)*(s+15)*(s+20)); 

figure();
title('Step Response');
step(feedback(sys,1));
%to plot rlocus of the system
figure();
title('Root Locus of the system');
rlocus(sys);
axis([-8 8 -10 10]);
% to find k and pole values at particular point this can be used
[k, poles] = rlocfind(sys);

% to have overshoot less than 50% and rise time to be less than 1s we need
% to look for points outside the circle and within two angled dotted lines
zeta = 0.7;
wn = 1.8;
sgrid(zeta,wn);
% now we will use k to and find the step response of the system
figure();
title('Tuned Response');
step(feedback(k*sys,1));

% For using control system designer tool use following
% controlSystemDesigner(sys)
