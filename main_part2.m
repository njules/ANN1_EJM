%% Creation of the data
%creation of the data
x=zeros(1,1600);
x(1)=1.5;
for ii=1:1599
    if ii<26
        x(ii+1) = 0.9*x(ii);
    else
        x(ii+1) = 0.9 * x(ii) +(0.2*x(ii-25))/(1+(x(ii-25))^10);
    end
end


%plotting
% figure(1)
% hold on
% plot(x)

%% 2-layer neural network
% t = 301:1500;
% input = [x(t-20); x(t-15); x(t-10); x(t-5); x(t)];
% output = x(t+5);
% error_v=zeros(8,11);    %value of the error validation after the training for diff parameters
% %creation of the neural network
% for ii=1:8   %number of nodes
%     r_ind=1;     %index for error
%     ii
%     for rr=0:0.1:1   %strength of regularization
%         net = feedforwardnet(ii, 'trainbfg');
%         net.trainParam.mu=1;
%         net.trainParam.mu_dec=0.8;
%         net.trainParam.mu_inc=1.5;
%         net.trainParam.showWindow = false;   %no window
%         net.divideFcn='divideblock';
%         net.divideParam.trainRatio=700/1200;
%         net.divideParam.valRatio=300/1200;
%         net.divideParam.testRatio=200/1200;   %set 200 last values in the test set
%         net.performParam.regularization = rr;   %strength of the regularization
%         %net.trainParam.max_fail=10;             %max of validation fail before stopping
%         
%         %training of the network
%         [net,tr] = train(net,input,output);
%         error_v(ii, r_ind)=tr.best_vperf;
%         r_ind=r_ind+1;
%     end
% end
% figure(2)
% hold on
% for ii =1:8
%     plot(0:0.1:1,error_v(ii,:))
% end
% legend('1','2','3','4','5','6','7','8')
% %plotting
% %a=net(input(:,1001:1200));
% %plot(1306:1505,a);

%% 3-layer neural network

%for the question 4.4, add some noise
sigma = 0.18;  %change this value from time to time
z = randn(1,1600)*sigma*sigma;

figure(1)
hold on
plot(x(:,1306:1505))
x=x+z;
plot(x(:,1306:1505))
%input output
t = 301:1500;
input = [x(t-20); x(t-15); x(t-10); x(t-5); x(t)];
output = x(t+5);

error_v=zeros(8,10);    %value of the error validation after the training for diff parameters
%creation of the neural network
for ii=1:8   %number of nodes
    r_ind=1;     %index for error
    ii
    for rr=0:0.1:0.9   %strength of regularization
        net = feedforwardnet([8 ii], 'trainbfg');
%         net.trainParam.mu=1;
%         net.trainParam.mu_dec=0.8;
%         net.trainParam.mu_inc=1.5;
        net.trainParam.showWindow = false;   %no window
        net.divideFcn='divideblock';
        net.divideParam.trainRatio=700/1200;
        net.divideParam.valRatio=300/1200;
        net.divideParam.testRatio=200/1200;   %set 200 last values in the test set
        net.performParam.regularization = rr;   %strength of the regularization
        %net.trainParam.max_fail=10;             %max of validation fail before stopping
        
        %training of the network
        [net,tr] = train(net,input,output);
        error_v(ii, r_ind)=tr.best_vperf;
        r_ind=r_ind+1;
    end
end
figure(2)
hold on
for ii =1:8
    plot(0:0.1:0.9,error_v(ii,:))
end
legend('1','2','3','4','5','6','7','8')

% net = feedforwardnet([8 3], 'trainbfg');
% net.trainParam.mu=1;
% net.trainParam.mu_dec=0.8;
% net.trainParam.mu_inc=1.5;
% net.trainParam.showWindow = false;   %no window
% net.divideFcn='divideblock';
% net.divideParam.trainRatio=700/1200;
% net.divideParam.valRatio=300/1200;
% net.divideParam.testRatio=200/1200;   %set 200 last values in the test set
% net.performParam.regularization = 0.1;   %strength of the regularization
% %net.trainParam.max_fail=10;             %max of validation fail before stopping
% 
% %training of the network
% [net,tr] = train(net,input,output);
% a=net(input(:,1001:1200));
% plot(a);