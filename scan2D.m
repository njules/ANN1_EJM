%% Gaussian approximation

rng(666)
clear all
% Parameters
LearningRate=0.01;
NbHiddenNodes=1:25;
epochs=100;
alpha=0.5;

TrainSetSize=0.5; %Percent
nSamples=1:100;

param=NbHiddenNodes;
paramName='NbHiddenNodes';

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

error=zeros(size(nSamples,2),size(NbHiddenNodes,2));
for j=NbHiddenNodes
%     e=zeros(1,size(nSamples,2));
    for i=nSamples

        % Split the data
        TrainSet=dataShuffle(:,1:i);

        % It's getting serious, man
        [W,V,outTrain]=perceptron2layer(TrainSet(1:2,:),TrainSet(3,:),epochs,...
            LearningRate, j,alpha,3,false);

        outTot=evalNet(data,W,V);
    %     out = reshape(out, gridsize, gridsize);

%         e(i)=sum((outTot-targets).^2)/size(targets,2);
         error(i,j)=sum((outTot-targets).^2)/size(targets,2);
    %      errorTrain(i,j)=sum((outTrain-TrainSet(3,:)).^2)/size(TrainSet(3,:),2);
    %     error(ii)= sum(sum(abs(sign(out) - targets)));
    end
%     error(:,j)=e
end

[I,J]=meshgrid(NbHiddenNodes,nSamples);
figure(7)
clf
contourf(I,J,log(error))
xlabel('NbHiddenNodes')
ylabel('nSamples')
zlabel('log(Error)')