function [] = plot1( data, W)
%UNTITLED Plot the separation curve for a 1 layer perceptron
%   Detailed explanation goes here
% % 
% % definition of the outputs
% % ndata=size(XGrid,1);
% % patGrid=[XGrid'; ones(1,ndata)];
% % out=sign(W*patGrid);
% % Y=sign(out);
% % 
% % plot
% % xx1=XGrid(:,1);
% % xx2=XGrid(:,2);
% % gscatter(xx1(:), xx2(:), Y, [ 0.75 0 0;0 0 0.75]);
% % gscatter(data(1,:),data(2,:),data(3,:));
% % pause(0.1);
clf
hold on
gscatter(data(1,:),data(2,:),data(3,:))
xplot=-5:5;
yplot=-W(1)/W(2).*xplot-(W(3)/W(2));
plot(xplot,yplot);
pause(0.5)
hold off
end

