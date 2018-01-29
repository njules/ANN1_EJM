function [ output_args ] = plotperceptron_2( data, W , V, XGrid )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%computation of the curve
patGrid=[XGrid' ; ones(1,size(XGrid,1))];
hin = W * patGrid;
hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,size(XGrid,1))];
oin = V * hout;
out = 2 ./ (1+exp(-oin)) - 1; 
Y = sign(out);

%plot the curve
clf
hold on
xx1=XGrid(:,1);
xx2=XGrid(:,2);
gscatter(xx1(:), xx2(:), Y, [ 0.75 0 0;0 0 0.75]);
gscatter(data(1,:),data(2,:),data(3,:));
pause(0.1)
hold off
end

