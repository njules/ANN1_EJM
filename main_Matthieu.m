%seed
% rng(1);

% Size of one of the datasets (before merging them)
N=200;  
% if LearningRate > 0.0001 the delta rule is not converging
LearngRate=0.0001;

% Properties of the datasets (multivariate normal distribution)
mu = [3,2];
sigma = [3,1.5;1.5,1];

% dataset 1
data = mvnrnd(mu,sigma,N);
data(:,3)=ones(size(data,1),1);

mu=[-3,2];
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


for i=1:10:150
    W=perceptron1Layer(data(1:2,:),data(3,:),i,LearngRate);
    W_delta=deltaRule1layer(data(1:2,:),data(3,:),i,LearngRate);
 
    figure(3)
    clf
    hold on
    title(sprintf("epoch=%d",i))
    % Plot that wonder
    ylim([-10 10])
    gscatter(data(1,:),data(2,:),data(3,:))
    xplot=-5:5;
    yplot=-W(1)/W(2).*xplot-W(3)/W(2);
    yplot_delta=-W_delta(1)/W_delta(2).*xplot-W_delta(3)/W_delta(2);
    plot(xplot,yplot);
    plot(xplot,yplot_delta);
    legend('-1','1','perceptron','delta');
    pause(0.5)
    
    hold off
end
