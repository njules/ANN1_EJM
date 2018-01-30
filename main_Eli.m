%% 1-layer perceptron
% to use the 1-layer perceptron
% clf
% 
% % rng(7);   %set the seed to always have the same results
% 
% 
% % Size of one of the datasets (before merging them)
% N=100;  
% 
% % Properties of the datasets (multivariate normal distribution)
% mu = [3,0];
% sigma = [3,1.5;1.5,1];
% 
% % dataset 1
% data = mvnrnd(mu,sigma,N);
% data(:,3)=ones(size(data,1),1);
% 
% %mu=[-3,0];   %for linearly separable
% % mu=[-0.2,0];   %non-linearly small overlap
% mu= [1,0]; %big overlap
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
% % seed=2504; linearly
% seed=3532;
% epochs = 150;
% % Perceptron rule
% % figure(3)
% % hold on
% W=perceptron1Layer(data(1:2,:),data(3,:),epochs,0.0005,seed);
% 
% %deltaRule with batch learning
% % figure(4)
% % hold on
% W2=deltaRule1layer(data(1:2,:),data(3,:),epochs,0.0005,seed);
% 
% %delta Rule with sequential learning
% % figure(5)
% % hold on
% W3=deltaRule1_sequential(data(1:2,:),data(3,:),epochs,0.0005,seed);
% 
% %plot the different errors
% figure(7)
% legend('perceptron rule','batch learning error DR', 'sequential learning error DR')
% 
% %plot the different learning curves
% xplot=-5:5;
% yplot1=-W(1)/W(2).*xplot-(W(3)/W(2));
% yplot2=-W2(1)/W2(2).*xplot-(W2(3)/W2(2));
% yplot3=-W3(1)/W3(2).*xplot-(W3(3)/W3(2));
% 
% figure(8)
% hold on
% gscatter(data(1,:),data(2,:),data(3,:));
% plot(xplot,yplot1);
% plot(xplot,yplot2);
% plot(xplot,yplot3);
% 
% title('Different learning curves')
% legend('-1','1','perceptron rule','batch learning error DR', 'sequential learning error DR')

%% 2-layers perceptron
% to use the 2 layers perceptron
% % 
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
hold on
[W,V] = perceptron2layer(data(1:2,:), data(3,:), 100, 0.01, 50, 0.9);

