function [ w,v ] = perceptron2layer_3_2( patterns, targets, testPatterns, testTargets, epochs,...
    eta, nbhidden, alpha,mode,PlotIt )
%PERCEPTRON2LAYER function [ w,v ] = perceptron2layer( patterns, targets, epochs, eta, nbhidden, alpha,PlotIt,mode )
%   inputs:
%       patterns
%       targets
%       epochs
%       learning rate
%       number of nodes in the hidden layer
%       alpha
%       mode    (default=1)
%       PlotIt  (bool, default=true)

%
%   mode=1 for the part 3.1 of the exercise (defalut value)
%   mode=3 for the part 3.3
%   PlotIt is to say if you want the evolution ploted at every epoch

if ~exist('mode', 'var')
    mode = 1;
end
if ~exist('PlotIt', 'var')
    PlotIt = true;
end

rng(10)
data=[patterns;targets];
ndata=size(patterns,2);

patterns=[patterns; ones(1,ndata)];
w=randn(nbhidden, size(patterns,1));
v=randn(size(targets,1), nbhidden+1);

dw=zeros(size(w));
dv=zeros(size(v));
error=zeros(epochs,1);
msqerror = zeros(epochs,1);
testPatterns=[testPatterns; ones(1,100)];
testError = zeros(epochs,1);
testMsqerror = zeros(epochs,1);

%definition of the grid
if mode==1
    x1range = min(data(1,:)):.03:max(data(1,:));
    x2range = min(data(2,:)):.03:max(data(2,:));
    [xx1, xx2] = meshgrid(x1range,x2range);
    XGrid = [xx1(:) xx2(:)];
elseif mode==3
    XGrid=data(1:2,:)';
end

clear error

for ii=1:epochs
    %forward
    hin = w * patterns;
    hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata)];
    oin = v * hout;
    out = 2 ./ (1+exp(-oin)) - 1;
    temp = [2 ./ (1+exp(-w*testPatterns)) - 1 ; ones(1,100)];
    testPrediction = 2 ./ (1+exp(-v*temp)) - 1;
    error(ii)= sum(sum(abs(sign(out) - targets)./2));
    msqerror(ii) = goodnessOfFit(out,targets,'MSE')/200;
    testError(ii) = sum(sum(abs(sign(testPrediction) - testTargets)./2));
    testMsqerror(ii) = goodnessOfFit(testPrediction,testTargets,'MSE')/100;
    if PlotIt
        plotperceptron_2(data, w, v, XGrid,mode);
    end
    
    %backward
    delta_o = (out - targets) .* ((1 + out) .* (1 - out)) * 0.5;
    delta_h = (v' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
    delta_h = delta_h(1:nbhidden, :);
    
    %changing of weights
    dw = (dw .* alpha) - (delta_h * patterns') .* (1-alpha);
    dv = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    

end
figure(2)
plot(error)
hold off
figure(10);
plot(msqerror);
hold off
figure(11);
plot(testError);
hold off
figure(12);
plot(testMsqerror);
if PlotIt
    figure(3)
    hold on
    plotperceptron_2(data, w, v, XGrid,mode,3);
end
end
