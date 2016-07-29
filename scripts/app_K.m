function v= app_K(u,X,Y,dist_fun,gamma,maxMatrixSize,transposeFlag)
% function designed to compute
% K u where K = [d(x_i,y_j)] where P=[x_1 ... x_n] and Q=[y_1.. y_m]
% but are too big to fit in memory. Hence Q needs to be split.

[~,n]=size(X);
[~,m]=size(Y);

if nargin<7,
    transposeFlag=0;
end

stepSize= ceil(maxMatrixSize/n); % how many columns of Q we can take at a time

if stepSize<m,
    I=1:stepSize:m;
    if I(end)~=m
        I(end+1)=m+1;
    else
        I(end)=m+1;
    end
else
    I=[1,m+1];
end


for i=1:length(I)-1,
    try
        %disp(['loading kernel ',num2str(I(i)),'-',num2str((I(i+1)-1))]);
        if ~transposeFlag,
            K=exp(-dist_fun(X,Y(:,I(i):(I(i+1)-1)))/gamma); K(K<1e-200)=1e-200;
        else
            K=exp(-dist_fun(Y(:,I(i):(I(i+1)-1)),X)/gamma); K(K<1e-200)=1e-200;
        end
        %disp(['--loaded kernel ',num2str(I(i)),'-',num2str((I(i+1)-1))]);
    catch ME
        ME
        size(X)
        size(Y)
        length(u)
        gpuDevice()
        whos
        break
    end
    if i==1, % this avoids testing if data needs to go on gpu...
        if ~transposeFlag
            v=K*u(I(i):(I(i+1)-1));
        else
            v=K*u;
        end
    else
        if ~transposeFlag
            v=v+K*u(I(i):(I(i+1)-1));
        else
            v(end+(1:(I(i+1)-I(i))))=K*u;
        end
    end
    K=0;
end