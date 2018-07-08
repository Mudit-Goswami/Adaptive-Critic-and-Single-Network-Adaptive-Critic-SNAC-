clc;
clear all;
close all;
states = [];
max_iter = 10;
num_of_elements_in_s = 100;
for store = 1:num_of_elements_in_s
   states = rand(num_of_elements_in_s,1); 
end
%S = 2 * rand(num_of_elements_in_s,1)-1;
w_a = rand*0.01;
w_c = rand*0.01;
%x = zeros(num_of_elements_in_s+1,1);
delta_t = 0.01;
lambda = zeros(num_of_elements_in_s, 1);
eta_a = 0.2;
eta_c = 0.2;
delta_u = 1;
delta_l = 1;

for iter = 1:max_iter
    for k = 1:length(S)
    i = 1; j = 1;
    while delta_u > 0.01
        x(i) = S(k);
        u(i) = w_a * x(i);
        x(i+1) = x(i) + delta_t * (u(i) + x(i) -x(i)^3);
        lambda_next = w_c * x(i+1);
        u_d = -(lambda_next)/delta_t;
        w_a = w_a + eta_a * (u(i)- u_d) * x(i);
        lambda(i) = lambda_next;
        delta_u = abs(u(i)-u_d)
        i = i+1;
    end
    
    while delta_l > 0.01
        x(j) = S(k);
        u(j) = w_a *x(j);
        x(j+1) = x(j) + delta_t * (u(j) + x(j) -x(j)^3);
        lambda_pred = w_c * x(j+1);
        lambda_des = lambda_pred + delta_t * (x(j) + lambda_pred*(1-3*x(j)^2));
        w_c = w_c + eta_c * (lambda_pred - lambda_des) * x(j+1);
        lambda(j) = lambda_pred;
        delta_l = abs(lambda_des - lambda_pred)
        j = j+1;
    end
    end
end
plot(x)