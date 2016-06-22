function [c,MVP] = wassersteinBarycenter(C,M,iterations,lambda,tolerance,weights)
%objectives=[];

n=size(C,2);
d=size(M,1);

if nargin<3
    iterations=100;
end

if nargin<5
    tolerance=1e-3;
end

if nargin<6
    weights=ones(n,1)/n;
else
    weights=reshape(weights,n,1);
end

K=exp(-lambda*M);
K(K<1e-300)=1e-300;

count=0;
diff=inf;
%objectives=[];
matrixVector=0;
MVP=[];

UKv=K*(bsxfun(@rdivide,C,(sum(K))'));
u=bsxfun(@ldivide,UKv,exp(log(UKv)*weights));

h = waitbar(0, 'Computing...');
step = 1/iterations;

while count<iterations && diff>tolerance
    waitbar(step*count, h, sprintf('%.2f%%...', step*count*100))
    Ukv=u.*(K*(C./(K'*u)));
    matrixVector=matrixVector+2;
    count=count+1;
    u=bsxfun(@times,u,exp(log(UKv)*weights))./UKv;
    matrixVector=matrixVector+1;
    MVP=[MVP,matrixVector];
end

close(h)

c=mean(UKv,2);