function [out,hout] = evalNet(data,w,v)
%TESTNET Summary of this function goes here
%   Detailed explanation goes here
    
    ndata=(size(data,2));
    patterns=data(1:2,:);
    patterns=[patterns; ones(1,ndata)];
    
    hin = w * patterns;
    hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata)];
    oin = v * hout;
    out = 2 ./ (1+exp(-oin)) - 1;
end

