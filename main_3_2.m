%% linearly non seperable classification
% Uses 2 layer perceptron to classify linearly non seperable data.
% Training is done using backpropagation.
% 

rng(69);

% number of samples from each distribution
N=50;

%Properties of the datasets (multivariate normal distribution)
mu = [3,2];
sigma = [3,1.5;1.5,1];
data = [mvnrnd(mu,sigma,2*N),ones(2*N,1)];
testData = [mvnrnd(mu,sigma,50),ones(50,1)];
mu=[7,2];
sigma=[2,1.25;1.25,1.2];
data = [data;[mvnrnd(mu,sigma,N),-ones(N,1)]];
testData = [testData;[mvnrnd(mu,sigma,25),-ones(25,1)]];
mu=[2,6];
sigma=[2,.5;.5,1];
data = [data;[mvnrnd(mu,sigma,N),-ones(N,1)]];
testData = [testData;[mvnrnd(mu,sigma,25),-ones(25,1)]];

%Shuffle the dataset
data=data(randperm(size(data,1)),:)';
testData = testData(randperm(size(testData,1)),:)';

%definition of the grid
x1range = min(data(1,:)):.01:max(data(1,:));
x2range = min(data(2,:)):.01:max(data(2,:));
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];

%output of the perceptron
figure(1)
hold on
[W,V] = perceptron2layer_3_2(data(1:2,:), data(3,:), testData(1:2,:), testData(3,:), 100, 0.01, 3, 0.9);

