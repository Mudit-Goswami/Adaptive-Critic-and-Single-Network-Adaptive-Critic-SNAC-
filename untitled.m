p = [-1 -1 2 2;0 5 0 5];
t = [-1 -1 1 0.5];
minmax(p)
net=newff(minmax(p),[3,1],{'tansig','purelin'},'trainlm');
net.trainParam.show = 5;
net.trainParam.epochs = 300;
net.trainParam.goal = 1e-5;
[net,tr]=train(net,p,t);
%error = perform(
a = sim(net,p)
