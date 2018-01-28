% rng(1);
% 
% %useless
% input=ones(5);
% 
% % Size of one of the datasets (before merging them)
% N=100;  
% 
% % Properties of the datasets (multivariate normal distribution)
% mu = [3,2];
% sigma = [1,1.5;1.5,3];
% 
% % dataset 1
% data = mvnrnd(mu,sigma,N);
% data(:,3)=ones(size(data,1),1);
% 
% mu=[-3,-2];
% % dataset 2 (temporary)
% data2 = mvnrnd(mu,sigma,N);
% data2(:,3)=-ones(size(data,1),1);
% 
% % merge the two datasets
% data=[data ; data2];
% clear data2;
% 
% % Shuffle the dataset
% data=data(randperm(size(data,1)),:)';

%give the proper names
% patterns=data(:,1:2);
% targets=data(:,3);
% data=([0 0;0 1;1 -1])

%% 2-layers perceptron
% to use the 2 layers perceptron

%useless
rng(200);
input=ones(5);

% Size of one of the datasets (before merging them)
N=100;  
LearngRate=0.001;

% Properties of the datasets (multivariate normal distribution)
mu = [3,2];
sigma = [3,1.5;1.5,1];

% dataset 1
data = mvnrnd(mu,sigma,N);
data(:,3)=ones(size(data,1),1);

mu=[7,2];
% dataset 2 (temporary)
data2 = mvnrnd(mu,sigma,N);
data2(:,3)=-ones(size(data,1),1);

% merge the two datasets
data=[data ; data2];
clear data2;

% Shuffle the dataset
data=data(randperm(size(data,1)),:)';
% figure(1)
% hold on
% gscatter(data(1,:),data(2,:),data(3,:))

[W,V] = perceptron2layer(data(1:2,:), data(3,:), 100, 0.001, 20, 0.9);
x1range = min(data(1,:)):.01:max(data(1,:));
x2range = min(data(2,:)):.01:max(data(2,:));
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];

%output of the perceptron 2-layers
ndata=size(XGrid,1);
patGrid=[XGrid'; ones(1,ndata)];
hin = W * patGrid;
hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata)];
oin = V * hout;
out = 2 ./ (1+exp(-oin)) - 1;
Y=sign(out);

figure(3)
hold on
gscatter(xx1(:), xx2(:), Y, [ 0.75 0 0;0 0 0.75]);
gscatter(data(1,:),data(2,:),data(3,:))
% W=perceptron1Layer(data(1:2,:),data(3,:),20,0.001);
% for i=2:2:20
%     %W=perceptron1Layer(data(1:2,:),data(3,:),i,0.001);
%     W=deltaRule1layer(data(1:2,:),data(3,:),i,0.0001);
%     figure(1)
%     clf
%     hold on
% %     Plot that wonder
% 
%     gscatter(data(1,:),data(2,:),data(3,:))
%     xplot=-5:5;
%     yplot=-W(1)/W(2).*xplot-(W(3)/W(2));
%     plot(xplot,yplot);
%     pause(0.5)
%     hold off
% end
% patterns = [data(1:2, :) ; ones(1,size(data, 2))];
% targets=data(3,:);
% error = sum(sum(abs(sign(W*patterns) - targets)./2))
