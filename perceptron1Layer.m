function [W] = perceptron1Layer(patterns,targets,epochs,eta)
%PERCEPTRON Do crazy shit man
%   function [W] = perceptron1Layer(patterns,targets,epochs,eta)
    rng(1);
    
    nData=size(patterns,2);
    patterns=[patterns; ones(1,nData)];
    
    W=randn(size(targets,1), size(patterns,1));
    error=zeros(epochs,1);
    for ii=1:epochs
%         (W*patterns-targets)*(W*patterns-targets)'
%         Delta_W = -eta*(W*patterns-targets)*patterns';
        Delta_W=-eta*(sign(W*patterns)-targets)*patterns'./2;
        W=W+Delta_W;
        error(ii)= sum(sum(abs(sign(W*patterns) - targets)./2));
    end

% figure(2)
% plot(error)
end

