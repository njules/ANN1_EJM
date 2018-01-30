%% Gaussian approximation

LearningRate=0.001
NbHiddenNodes=60
epochs=500
alpha=0.3

% Build data grid
x=[-5:0.5:5]';
y=[-5:0.5:5]';
z=exp(-x.*x*0.1) * exp(-y.*y*0.1)' - 0.5;
% 

% Plot it
% colormap jet
% surf(x,y,z)
% xlabel('x')
% ylabel('y')
% zlabel('z')
% set(gca, 'FontSize', 14)

% Number of element in z (the whole grid)
ndata=numel(z);

% Fromat the data in a really fancy and convenient way, 
%   pretty much exactly as suggested by our admired professor.
%   We would like to thank him warmly for his precious help, 
%   as well as all the people without whom, we would not be there today.
targets = reshape (z, 1, ndata);
[xx, yy] = meshgrid (x, y);
patterns = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];
data=[patterns;targets];
% It feels so much better right now...


[W,V]=perceptron2layer(patterns,targets,epochs,LearningRate,...
    NbHiddenNodes,alpha,3,false);

figure(3)
plotperceptron_2(data, W, V,data(1:2,:)',3,3);
hold on
mesh(x, y, z,'EdgeColor','red','FaceColor','none');
hold off





