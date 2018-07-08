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
u_in1 = rand(num_of_elements_in_s,1);
u_in = u_in1';

for sample = 1:100
   c(1) = 0.005; 
   c(sample+1) = c(sample) + 0.005*(sample);  
end    


while( i<=54)
     %while(error_action > 0.0002)
     states(1) = c(i);
     lambda_k_start(1) = c(i);
     u_in(1) = c(i);
     lambda_k(1) = c(i);
              
            for j = 1:2
              states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
              lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
              u_in(j+1) = -(lambda_k_start(j+1));
              lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2);
              
            end
            
            for j = 3:23
             states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
             lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
             u_in(j+1) = -(lambda_k_start(j+1));
             lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2); 
            end
          
          for j = 24:26
             states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
             lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
             u_in(j+1) = -(lambda_k_start(j+1));
             lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2); 
             
          end
          
          for j = 27:43
             states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
             lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
             u_in(j+1) = -(lambda_k_start(j+1));
             lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2); 
          end
          
          for j = 44:46
             states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
             lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
             u_in(j+1) = -(lambda_k_start(j+1));
             lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2); 
          end
          
          for j = 47:63
             states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
             lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
             u_in(j+1) = -(lambda_k_start(j+1));
             lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2); 
          end
          
          for j = 64:66
              states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
              lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
              u_in(j+1) = -(lambda_k_start(j+1));
              lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2); 
          end
          
          for j = 67:85
             states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
             lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
             u_in(j+1) = -(lambda_k_start(j+1));
             lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2); 
          end
          
          for j = 86:97
             states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
             lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
             u_in(j+1) = -(lambda_k_start(j+1));
             lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2); 
          end 
          
          for j = 98:100
             states(j+1) = states(j) + delta_t * (u_in(j) + states(j) - states(j)^3);
             lambda_k_start(j+1) = lambda_k_start(j) + delta_t * states(j) + delta_t * lambda_k_start(j) * (1 - 3 * states(j)^2);
             u_in(j+1) = -(lambda_k_start(j+1));
             lambda_k(j+1) = lambda_k(j) + delta_t * states(j) + delta_t * lambda_k(j) * (1 - 3 * states(j)^2); 
          end
          
         
           net_action=feedforwardnet(4,'trainlm');                          %ACTION NN TRAINING
           net_action=train(net_action,states,u_in);                        %ACTION NN TRAINING
           u_in_first = net_action(states);                                 %ACTION NN TRAINING
           net_critic1=feedforwardnet(4,'trainlm');                          %CRITIC NN TRAINING 
           net_critic1 = train(net_critic1,states,lambda_k);
           lambda_k_action = net_critic1(states);                                   % LAMBDA_K_A
           error_action = perform(net_action,u_in,u_in_first);              %ERROR OF ACTION NN TRAINING
           error_critic1 = perform(net_critic1,lambda_k,lambda_k_action);     % ERROR OF CRITIC NETWORK
           x_states = states + delta_t * (u_in_first + states - states.^3);       %X(K+1) STATES DERIVED 
           net_critic2=feedforwardnet(4,'trainlm');                          %CRITIC NN TRAINING 
           net_critic2=train(net_critic2,x_states,lambda_k_start);            %CRITIC NN TRAINING
           lambda_k_plus_one = net_critic2(x_states);                                 %CRITIC NN TRAINING
          
           u_k_star = -(lambda_k_plus_one / 1);                             %OPTIMAL CONTROL EQUATION
           lambda_k_target = lambda_k_plus_one + delta_t * x_states + delta_t * lambda_k_plus_one' * (1 - 3 * x_states.^2);   %COSTATE EQUATION
            
           error_critic2 = perform(net_critic2,lambda_k_start,lambda_k_plus_one);
           converge = (lambda_k_target - lambda_k);
           converge1 = (u_k_star - u_in);
           plot(x_states);
           i= i+1; 
     % end
         
      %end
     
end    
                
                
               
                
       
        
    
    
    

    
    