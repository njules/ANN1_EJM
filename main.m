seed=rng(1);

%useless
input=ones(5);

% Size of one of the datasets (before merging them)
N=100;  

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
data=data(randperm(size(data,1)),:);

% Plot that wonder
figure
hold on
gscatter(data(:,1),data(:,2),data(:,3))
