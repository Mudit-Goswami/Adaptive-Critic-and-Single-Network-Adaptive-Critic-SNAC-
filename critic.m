clc;
clear all;
close all;
states = [];
states1 = [];
lambda_k = [];
lambda_k_start = [];
lambda_k_target = [];
delta_lambda_k=[];
u_k = [];
x_states = [];
u_in_first = [];
delta_t = 0.01;
error = 1;
u_in_action=[];
delta_u_k = 1;
converge = 1;
converge1 = 1;
error_action =1;
error_critic1 = 1;
error_critic2 = 1;
i = 1;
j = 1;
lambda_k_plus_one = [];
lambda_plus_one = [];
num_of_elements_in_s = 101;
u_k_action = rand(num_of_elements_in_s,1);
c = [];
u_in1 = rand(num_of_elements_in_s,1);
u_in = u_in1';

for sample = 1:10
   c(1) = 0.05; 
   c(sample+1) = c(sample) + 0.05*(sample);  
end    


while( i<=11)
      %fprintf('here');
      %while(error_action >0.0002 && error_critic2 >0.0002 )
          fprintf('here1');
          
          for j = 1:2
              
              states(j+1) = 0.05*rand(1,1);
              
              lambda_k_start(j+1) = 0.05*rand(1,1);
              
              u_in(j+1) = 0.05*rand(1,1);
              
              lambda_k(j+1) = 0.05*rand(1,1);
          end
          
          for j = 24:26
              
              states(j+1) = 0.05*rand(1,1);
              
              lambda_k_start(j+1) = 0.05*rand(1,1);
              
              u_in(j+1) = 0.05*rand(1,1);
              
              lambda_k(j+1) = 0.05*rand(1,1);
          end
          
          for j = 44:46
              
              states(j+1) = 0.05*rand(1,1);
              
              lambda_k_start(j+1) = 0.05*rand(1,1);
              
              u_in(j+1) = 0.05*rand(1,1);
              
              lambda_k(j+1) = 0.05*rand(1,1);
          end
          
          for j = 64:66
              
              states(j+1) = 0.05*rand(1,1);
              
              lambda_k_start(j+1) = 0.05*rand(1,1);
              
              u_in(j+1) = 0.05*rand(1,1);
              
              lambda_k(j+1) = 0.05*rand(1,1);
          end
          
          for j = 86:89
              
              states(j+1) = 0.05*rand(1,1);
              
              lambda_k_start(j+1) = 0.05*rand(1,1);
              
              u_in(j+1) = 0.05*rand(1,1);
              
              lambda_k(j+1) = 0.05*rand(1,1);
          end
          
          for j = 3:23
              
              states(j+1) = c(i)*rand(1,1); 
              
              lambda_k_start(j+1) = c(i)*rand(1,1);
              
              u_in(j+1) = c(i)*rand(1,1);
              
              lambda_k(j+1) = c(i)*rand(1,1);
          end
          
          for j = 27:43
              
              states(j+1) = c(i)*rand(1,1); 
              
              lambda_k_start(j+1) = c(i)*rand(1,1);
              
              u_in(j+1) = c(i)*rand(1,1);
              
              lambda_k(j+1) = c(i)*rand(1,1);
          end
          
          for j = 47:63
              
              states(j+1) = c(i)*rand(1,1); 
              
              lambda_k_start(j+1) = c(i)*rand(1,1);
              
              u_in(j+1) = c(i)*rand(1,1);
              
              lambda_k(j+1) = c(i)*rand(1,1);
          end
          
          for j = 67:85
              
              states(j+1) = c(i)*rand(1,1); 
              
              lambda_k_start(j+1) = c(i)*rand(1,1);
              
              u_in(j+1) = c(i)*rand(1,1);
              
              lambda_k(j+1) = c(i)*rand(1,1);
          end
          
          for j = 90:100
              
              states(j+1) = c(i)*rand(1,1); 
              
              lambda_k_start(j+1) = c(i)*rand(1,1);
              
              u_in(j+1) = c(i)*rand(1,1);
              
              lambda_k(j+1) = c(i)*rand(1,1);
          end
          
          
          %converge = 1;
          while(error_action > 0.0002)
              
           net_action=feedforwardnet(4,'trainlm');                          %ACTION NN TRAINING
           net_action=train(net_action,states,u_in);                        %ACTION NN TRAINING
           u_in_first = net_action(states);                                 %ACTION NN TRAINING
           net_critic=feedforwardnet(4,'trainlm');                          %CRITIC NN TRAINING 
           %net_critic = train(net_critic,states,lambda_k);
           %lambda_k_action = net_critic(states);                                   % LAMBDA_K_A
           error_action = perform(net_action,u_in,u_in_first);              %ERROR OF ACTION NN TRAINING
          % error_critic1 = perform(net_critic,lambda_k,lambda_k_action);     % ERROR OF CRITIC NETWORK
           x_states = states + delta_t * (u_in_first + states - states.^3);       %X(K+1) STATES DERIVED 
           
           net_critic=train(net_critic,x_states,lambda_k_start);            %CRITIC NN TRAINING
           lambda_k_plus_one = net_critic(x_states);                                 %CRITIC NN TRAINING
          
           u_k_star = -(lambda_k_plus_one / 1);                             %OPTIMAL CONTROL EQUATION
           lambda_k_target = lambda_k_plus_one + delta_t * x_states + delta_t * lambda_k_plus_one' * (1 - 3 * x_states.^2);   %COSTATE EQUATION
            
           error_critic2 = perform(net_action,lambda_k_start,lambda_k_plus_one);
           %converge = (lambda_k_target - lambda_k_action);
           converge1 = (u_k_star - u_in_first);
           plot(x_states);
          end
           
          
      %end
      i = i+1
end    