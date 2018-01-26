rng(1);

%useless
input=ones(5);

% Size of one of the datasets (before merging them)
N=2;  

% Properties of the datasets (multivariate normal distribution)
mu = [3,2];
sigma = [1,1.5;1.5,3];

% dataset 1
data = mvnrnd(mu,sigma,N);
data(:,3)=ones(size(data,1),1);

mu=[-3,-2];
% dataset 2 (temporary)
data2 = mvnrnd(mu,sigma,N);
data2(:,3)=-ones(size(data,1),1);

% merge the two datasets
data=[data ; data2];
clear data2;

% Shuffle the dataset
data=data(randperm(size(data,1)),:)'

%give the proper names
% patterns=data(:,1:2);
% targets=data(:,3);
data=([0 0;0 1;1 -1])

for i=20:2:20
    W=perceptron1Layer(data(1:2,:),data(3,:),i,0.001);
    
    figure(1)
    clf
    hold on
    % Plot that wonder

    gscatter(data(1,:),data(2,:),data(3,:))
    xplot=-5:5;
    yplot=-W(1)/W(2).*xplot+W(3);
    plot(xplot,yplot);
    pause(0.5)
    hold off
end


