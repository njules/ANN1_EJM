function [W] = deltaRule1layer(patterns,targets,epochs,eta,seed)
%deltaRule1layer Do crazy shit man
rng(seed);

data=[patterns; targets];

error=zeros(epochs,1);

%initialization
nData=size(patterns,2);
patterns=[patterns; ones(1,nData)];
W=randn(size(targets,1), size(patterns,1));

%update the weights
for ii=1:epochs
    %         (W*patterns-targets)*(W*patterns-targets)';
    Delta_W = -eta*(W*patterns-targets)*patterns';
    W=W+Delta_W;
    
%     %plot (can be commented)
%     clf
%     hold on
%     plot1(data,W);
%     pause(0.5)
%     hold off
%     
    %error (misclassification)
    error(ii)= sum(abs(sign(W*patterns) - targets))./2;
end
figure(7)
hold on
plot(error)
end

