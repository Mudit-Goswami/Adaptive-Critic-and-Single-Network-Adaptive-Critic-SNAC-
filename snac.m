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
delta_t = 0.038;
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
%lambda_k_generate = rand(num_of_elements_in_s,1);
%lambda_first_input = lambda_k_generate';

for sample = 1:100
   c(1) = 0.005; 
   c(sample+1) = c(sample) + 0.005*(sample);  
end    


while( i<=54)
     %while(error_action > 0.0002)
     states(1) = c(i);
     lambda_k_start(1) = c(i);
     u_in(1) = c(i);
              
            
          
          for j = 1:100
             states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
             lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
             u_in(j+1) = -(lambda_k_start(j+1));
          end
          
                   
           net_critic1=feedforwardnet(4,'trainlm');                          %CRITIC NN TRAINING 
           net_critic1 = train(net_critic1,states,lambda_k_start);
           lambda_k_plus_one = net_critic1(states);                                   % LAMBDA_K_A
           u_k_star = -(lambda_k_plus_one / 1);                             %OPTIMAL CONTROL EQUATION
           x_states = states + delta_t * (u_k_star + states - states.^3);       %X(K+1) STATES DERIVED 
           net_critic1 = train(net_critic1,x_states,lambda_k_plus_one);
           lambda_k_plus_one = net_critic1(x_states);
           lambda_k_target = lambda_k_plus_one + delta_t * x_states + delta_t * lambda_k_plus_one' * (1 - 3 * x_states.^2);   %COSTATE EQUATION
           plot(x_states);
           i= i+1; 
     % end
         
      %end
     
end    