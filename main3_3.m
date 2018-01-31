%% Gaussian approximation

rng(666)
clear all
% Parameters
LearningRate=0.01;
NbHiddenNodes=10;
epochs=70;
alpha=0.5;

TrainSetSize=0.5; %Percent
nSamples=441;


% Build data grid
x=[-5:0.5:5]';
y=[-5:0.5:5]';
z=exp(-x.*x*0.1) * exp(-y.*y*0.1)' - 0.5;

% Number of element in z (the whole grid)
ndata=numel(z);
gridsize=numel(x);

% Fromat the data in a really fancy and convenient way, 
%   pretty much exactly as suggested by our admired professor.
%   We would like to thank him warmly for his precious help, 
%   as well as all the people without whom, we would not be there today.
targets = reshape (z, 1, ndata);
[xx, yy] = meshgrid (x, y);
patterns = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];
data=[patterns;targets];
% It feels so much better right now...

% Ok, let's shuffle it now, that's much more fun
dataShuffle=data(:,randperm(size(data,2)));


% endset=floor(size(data,2)*TrainSetSize);

% TestSet=dataShuffle(:,nSamples+1:end);

% Split the data
TrainSet=dataShuffle(:,1:nSamples);

% It's getting serious, man
[W,V,outTrain]=perceptron2layer(TrainSet(1:2,:),TrainSet(3,:),epochs,...
    LearningRate, NbHiddenNodes,alpha,3,false);

outTot=evalNet(data,W,V);
%     out = reshape(out, gridsize, gridsize);
% Just a nice plot to conclude
% It's not efficient but fuck it, nothing is optimised anyway

%     if i==param(end)
%     name=sprintf('./plots/3_3-%s_scan-%d',paramName,i);
    figure(3)
    set(gca,'fontsize',14)
    plotperceptron_2(data, W, V,data(1:2,:)',3,3);
    hold on
    mesh(x, y, z,'EdgeColor','red','FaceColor','none');
%     savefig(name)
%     saveas(gcf,name,'epsc')
    hold off
%     end
 error=log(sum((outTot-targets).^2)/size(targets,2))

%% Simple scan
%{
N=1;
for i=param
    
      NbHiddenNodes=i;
    % Split the data
    TrainSet=dataShuffle(:,1:nSamples);
    
    % It's getting serious, man
    [W,V,outTrain]=perceptron2layer(TrainSet(1:2,:),TrainSet(3,:),epochs,...
        LearningRate, NbHiddenNodes,alpha,3,false);
    
    outTot=evalNet(data,W,V);
%     out = reshape(out, gridsize, gridsize);
    % Just a nice plot to conclude
    % It's not efficient but fuck it, nothing is optimised anyway
    
%     if i==param(end)
        name=sprintf('./plots/3_3-%s_scan-%d',paramName,i);
        figure(3)
        set(gca,'fontsize',14)
        plotperceptron_2(data, W, V,data(1:2,:)',3,3);
        hold on
        mesh(x, y, z,'EdgeColor','red','FaceColor','none');
    %     savefig(name)
    %     saveas(gcf,name,'epsc')
        hold off
%     end
     error(N)=sum((outTot-targets).^2)/size(targets,2);
%      errorTrain(i,j)=sum((outTrain-TrainSet(3,:)).^2)/size(TrainSet(3,:),2);
    pause(2)
    N=N+1;
end

figure(5)
clf
set(gca,'fontsize',14)
hold on
% plot(param,errorTrain)
plot(param,log(error))
xlabel(paramName)
ylabel('Mean Squarred Error')
% legend('Training set','Total set')
hold off
%}



%% Double Scan
%{
error=zeros(size(nSamples,2),size(NbHiddenNodes,2));
parfor j=NbHiddenNodes
    e=zeros(1,size(nSamples,2));
    for i=nSamples

        % Split the data
        TrainSet=dataShuffle(:,1:i);

        % It's getting serious, man
        [W,V,outTrain]=perceptron2layer(TrainSet(1:2,:),TrainSet(3,:),epochs,...
            LearningRate, j,alpha,3,false);

        outTot=evalNet(data,W,V);
    %     out = reshape(out, gridsize, gridsize);

        e(i)=sum((outTot-targets).^2)/size(targets,2);
    % %      error(N)=sum((outTot-targets).^2)/size(targets,2);
    %      errorTrain(i,j)=sum((outTrain-TrainSet(3,:)).^2)/size(TrainSet(3,:),2);
    %     error(ii)= sum(sum(abs(sign(out) - targets)));
    end
    error(:,j)=e
end

[I,J]=meshgrid(NbHiddenNodes,nSamples);
figure(7)
clf
contourf(I,J,log(error))
%}


