function plotperceptron_2( data, W , V, XGrid, mode,fig )
%PLOTPERCEPTRON_2 []=plotperceptron_2( data, W , V, XGrid, mode,fig )
%   mode=1 for the part 3.1 of the exercise
%   mode=3 for the part 3.3
%   fig is the number of the figure to use (default=1)

if ~exist('mode', 'var')
    mode = 1;
end
if ~exist('fig', 'var')
    fig = 1;
end
%computation of the curve
patGrid=[XGrid' ; ones(1,size(XGrid,1))];
hin = W * patGrid;
hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,size(XGrid,1))];
oin = V * hout;
out = 2 ./ (1+exp(-oin)) - 1; 



xx=XGrid(:,1);
yy=XGrid(:,2);

% If you still don't know what's that, just read the doc of this very function...
if mode==1
    %plot the curve
    figure(1)
    hold on
    Y = sign(out);
    gscatter(xx(:), yy(:), Y, [ 0.75 0 0;0 0 0.75]);
    gscatter(data(1,:),data(2,:),data(3,:));
    pause(0.1)

    
elseif mode==3
    
   
%     hold on
    gridsize=sqrt(size(data,2));
    XX = reshape(xx, gridsize, gridsize);
    YY = reshape(yy, gridsize, gridsize);
    ZZ = reshape(out, gridsize, gridsize);
    figure(fig)
    clf
    grid on
    surf(XX,YY,ZZ);
%     axis([-5 5 -5 5 -0.7 0.7]);
    
end

pause(0.1)
hold off
end

