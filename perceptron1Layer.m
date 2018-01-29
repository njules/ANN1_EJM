function [W] = perceptron1Layer(patterns,targets,epochs,eta,seed)
%PERCEPTRON Do crazy shit man
%   function [W] = perceptron1Layer(patterns,targets,epochs,eta)
rng(seed);
data=[patterns; targets];

%initialization
nData=size(patterns,2);
patterns=[patterns; ones(1,nData)];

W=randn(size(targets,1), size(patterns,1));
error=zeros(epochs,1);

%update the weigths
for ii=1:epochs
    Delta_W=-eta*(sign(W*patterns)-targets)*patterns'./2;
    W=W+Delta_W;
    
%     %plot (can be commented)
%     clf
%     hold on
%     plot1(data,W);
%     pause(0.5)
%     hold off
    
    error(ii)= sum(sum(abs(sign(W*patterns) - targets)./2));
end


% error(ii)= sum(abs(sign(W*patterns) - targets));

figure(7)
plot(error)
end

