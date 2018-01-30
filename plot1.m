function [] = plot1( data, W)
%UNTITLED Plot the separation curve for a 1 layer perceptron
%   Detailed explanation goes here
gscatter(data(1,:),data(2,:),data(3,:))   %plot the data
xplot=-5:5;
yplot=-W(1)/W(2).*xplot-(W(3)/W(2));
plot(xplot,yplot);    %plot the learning curve
end

