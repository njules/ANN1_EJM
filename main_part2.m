x=zeros(1,2500);
x(1)=1.5;
for ii=1:2499
    if ii<26
        x(ii+1) = 0.9*x(ii);
    else 
        x(ii+1) = 0.9 * x(ii) +(0.2*x(ii-25))/(1+(x(ii-25))^10);
    end
end
t = 301:1500;
input = [x(t-20); x(t-15); x(t-10); x(t-5); x(t)];
output = x(t+5);

%for the question 4.4, add some noise
sigma = 0.3;  %change this value from time to time
z = randn(1,2500)*sigma*sigma;