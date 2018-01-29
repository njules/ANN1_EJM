function [ W ] = deltaRule1_sequential( patterns,targets,epochs,eta, seed)
%UNTITLED2 sequential version of the delta rule
%   Detailed explanation goes here
rng(seed);

data=[patterns; targets];

error=zeros(epochs,1);

%initialization
nData=size(patterns,2);
patterns=[patterns; ones(1,nData)];
W=randn(size(targets,1), size(patterns,1));

%update the weights
for ii=1:epochs
    for jj=1:nData
        Delta_W = -eta*(W*patterns(:,jj)-targets(:,jj))*patterns(:,jj)';
        W=W+Delta_W;
    end
    
    %     %plot (can be commented)
    %     clf
    %     hold on
    %     plot1(data,W);
    %     pause(0.5)
    %     hold off
    
    % error
    error(ii)= sum(abs(sign(W*patterns) - targets))./2;
end
figure(7)
hold on
plot(error)
end


