% %% 1-layer perceptron
% % to use the 1-layer perceptron
% rng(1);   %set the seed to always have the same results
% 
% 
% % Size of one of the datasets (before merging them)
% N=100;  
% 
% % Properties of the datasets (multivariate normal distribution)
% mu = [3,2];
% sigma = [3,1.5;1.5,1];
% 
% % dataset 1
% data = mvnrnd(mu,sigma,N);
% data(:,3)=ones(size(data,1),1);
% 
% mu=[-3,2];
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
% 
% %give the proper names
% %patterns=data(:,1:2);
% %targets=data(:,3);
% 
% figure(3)
% hold on
% W=perceptron1Layer(data(1:2,:),data(3,:),200,0.001);
% 
% % figure(4)
% % hold on
% % W2=deltaRule1layer(data(1:2,:),data(3,:),20,0.0001);
%% 2-layers perceptron
% to use the 2 layers perceptron
% 

rng(320);


%Size of one of the datasets (before merging them)
N=100;  
LearngRate=0.001;

%Properties of the datasets (multivariate normal distribution)
mu = [3,2];
sigma = [3,1.5;1.5,1];

%dataset 1
data = mvnrnd(mu,sigma,N);
data(:,3)=ones(size(data,1),1);

mu=[7,2];
sigma2=[2,1.25;1.25,1.2];
%dataset 2 (temporary)
data2 = mvnrnd(mu,sigma2,N);
data2(:,3)=-ones(size(data,1),1);

%merge the two datasets
data=[data ; data2];
clear data2;

%Shuffle the dataset
data=data(randperm(size(data,1)),:)';

%definition of the grid
x1range = min(data(1,:)):.01:max(data(1,:));
x2range = min(data(2,:)):.01:max(data(2,:));
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];

%output of the perceptron
figure(1)
[W,V] = perceptron2layer(data(1:2,:), data(3,:), 100, 0.01, 50, 0.9);

