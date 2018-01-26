function [W] = deltaRule1layer(patterns,targets,epochs,eta)
%deltaRule1layer Do crazy shit man
%   function [W] = perceptron1Layer(patterns,targets,epochs,eta)
%     rng(4);
    
    nData=size(patterns,2);
    patterns=[patterns; ones(1,nData)]
    
    W=randn(size(targets,1), size(patterns,1));
%     bla=W*patterns;
    for ii=1:epochs
%         (W*patterns-targets)*(W*patterns-targets)';
        Delta_W = -eta*(W*patterns-targets)*patterns';
        W=W+Delta_W;
        
%         W=W./norm(W);

%         delta_w=zeros(size(targets,1));
%         for jj=1:size(targets,1)
%             for kk=1:nData
%                 delta_w(jj)=delta_w(jj)-eta*patterns(jj,kk)*(W*patterns(:,kk)-targets(jj));
%                 
%             end
%         end
%         W=W+delta_w;

        error(ii)= sum(abs(sign(W*patterns) - targets))./2;
%     
    end
    figure(6)
    plot(error)
    title('error')
end

