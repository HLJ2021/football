function [index]=indexsegementation1(Y,norm1,norm2)
    %n=size(Y,1);
    da=0.15;
    dw=150;
    %找到满足条件的所有点
    index=find(Y(:,1)>(norm1-da) & Y(:,1)<(norm1+da) & Y(:,2)>(norm2-dw) & Y(:,2)<(norm2+dw));
    %yw=Y(:,2);
    %取前100个点
    %if size(index,1)>100
        %index=index(1:100,1);
    %end
    nnn=size(index,1)-1;
    sub=zeros(nnn,1);
    %找到邻近的点
    for k=1:nnn
        sub(k,1)=index(k+1,1)-index(k,1);
    end
    index1=find(sub<=20);
    index2=find(sub>20);
    %删除满足触地条件的点
    r=index(index2,1);
    index(index1+1,:)=[];
    index=[index;r];
    index=sort(index);
    index=unique(index);
end