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

rng(5);

%useless
input=ones(5);

% Size of one of the datasets (before merging them)
N=20;  
LearngRate=0.001;

% Properties of the datasets (multivariate normal distribution)
mu = [3,2];
sigma = [1,1.5;1.5,3];

% dataset 1
data = mvnrnd(mu,sigma,N);
data(:,3)=ones(size(data,1),1);

mu=[1,-2];
% dataset 2 (temporary)
data2 = mvnrnd(mu,sigma,N);
data2(:,3)=-ones(size(data,1),1);

% merge the two datasets
data=[data ; data2];
clear data2;

% Shuffle the dataset
data=data(randperm(size(data,1)),:)';
figure(1)
hold on
gscatter(data(1,:),data(2,:),data(3,:))
W=perceptron2layer(data(1:2,:), data(3,:), 20, 0.001, 25, 0.9);
% W=perceptron1Layer(data(1:2,:),data(3,:),20,0.001);
% for i=1:1:20
%     W=perceptron1Layer(data(1:2,:),data(3,:),i,0.001);
%     
%     figure(1)
%     clf
%     hold on
%     Plot that wonder
% 
%     gscatter(data(1,:),data(2,:),data(3,:))
%     xplot=-5:5;
%     yplot=-W(1)/W(2).*xplot-W(3);
%     plot(xplot,yplot);
%     pause(0.5)
%     hold off
% end

%give the proper names
% patterns=data(:,1:2);
% targets=data(:,3);
% data=([0 0;0 1;1 -1]);

for i=1:1:20
    W=perceptron1Layer(data(1:2,:),data(3,:),i,LearngRate);
    W_delta=deltaRule1layer(data(1:2,:),data(3,:),i,LearngRate);
 
    figure(1)
    clf
    hold on
    title(sprintf("epoch=%d",i))
    % Plot that wonder
    ylim([-10 10])
    gscatter(data(1,:),data(2,:),data(3,:))
    xplot=-5:5;
    yplot=-W(1)/W(2).*xplot-W(3);
    yplot_delta=-W_delta(1)/W_delta(2).*xplot+W_delta(3);
    plot(xplot,yplot);
    plot(xplot,yplot_delta);
    legend('-1','1','perceptron','delta');
    pause(0.2)
    
    hold off
end


