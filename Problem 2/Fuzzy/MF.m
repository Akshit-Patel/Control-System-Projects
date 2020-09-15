clc;
clearvars;

% Defining Fuzzy inference System here 
IP = mamfis('Name', "Fuzzy_Controller", "AndMethod", "prod", "DefuzzificationMethod", "centroid");

% Add your inputs here
num_inputs  = 2;
IP = addInput(IP, [-1 1], 'Name', "Error");
IP = addInput(IP,[-1 1],'Name', "Rate_of_error");

% Add Outputs 
IP = addOutput(IP,[-1 1], 'Name', "OP");

num_input_MFs  = 3;
input_mf_names = ["N";"Z";"P"];
params_inputs_MF(:,:,1) = [-1000 -1 0;
                            -1 0 1;
                            0 1 1000];
                       
params_inputs_MF(:,:,2) = [-1000 -1 0;
                            -1 0 1;
                            0 1 1000];
                        
for i=1:num_inputs
    for j=1:num_input_MFs
        IP = addMF(IP,IP.Input(i).name,"trimf", params_inputs_MF(j,:,1),'Name',input_mf_names(j));
    end
end

  IP = addMF(IP,IP.Output(1).name,"trimf", [-1 -1 -0.75],'Name',"NB");
  IP = addMF(IP,IP.Output(1).name,"trimf", [-1 -0.5 0],'Name',"N");
  IP = addMF(IP,IP.Output(1).name,"trimf", [-0.5 0 0.5],'Name',"Z");
  IP = addMF(IP,IP.Output(1).name,"trimf", [0 0.5 1],'Name',"P");
  IP = addMF(IP,IP.Output(1).name,"trimf", [0.5 1 1],'Name',"PB");
  
 IP = addRule(IP,["Error == N & Rate_of_error == N => OP = NB"...
     "Error == N & Rate_of_error == Z => OP = N"...
     "Error == N & Rate_of_error == P => OP = Z"...
     "Error == Z & Rate_of_error == N => OP = N"...
     "Error == Z & Rate_of_error == Z => OP = Z"...
     "Error == Z & Rate_of_error == P => OP = P"...
     "Error == P & Rate_of_error == N => OP = Z"...
     "Error == P & Rate_of_error == Z => OP = P"...
     "Error == P & Rate_of_error == P => OP = PB"...
     ]);
 
% plotmf(IP,'output',1);
% gensurf(IP);

% evalfis(IP,[0.5 -0.3]);

writeFIS(IP,"IP_InferenceSystem");
