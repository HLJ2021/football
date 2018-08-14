clc
clear
A=importdata('legacy1.csv');
%data=A(:,7:12);
%n=size(data,1);
f=96;
T=1/f;
%t=0:T:(n-1)*T;
%figure()
%subplot(2,1,1)
%plot(t,data(:,4)',t,data(:,5)',t,data(:,6)','LineWidth',2)
%legend('x','y','z')
%subplot(2,1,2)
%plot(t,data(:,1)',t,data(:,2)',t,data(:,3)','LineWidth',2)
%legend('x','y','z')

dataraw=A(:,1:6);
n=size(dataraw,1);
%[y yw t aa w norm1 norm2]=wavefilter(dataraw);
aa=[dataraw(:,1) dataraw(:,2) dataraw(:,3)];
w=[dataraw(:,4) dataraw(:,5) dataraw(:,6)];
for i=1:n
y(i,1)=sqrt(dataraw(i,1)^2+dataraw(i,2)^2+dataraw(i,3)^2);
yw(i,1)=sqrt(dataraw(i,4)^2+dataraw(i,5)^2+dataraw(i,6)^2);
end
for ij=1:n
        if yw(ij,1)>0.5
            flag(ij,1)=0;
        else
            flag(ij,1)=1;
        end
        %if abs(yw(ij)-yw(ij-1))==1
end
    index1=find(yw>0.05);
    a=index1(1,1)-60;
    b=a+1000;
    yw=yw(a:b,1);
    y=y(a:b,1);
    aa=aa(a:b,:);
    w=w(a:b,:);
    flag=flag(a:b,1);
    n=size(w,1);

    %[vel ss q]=motion(w,aa,yw,flag);
    [F vel ss q]=motion(w,aa,yw,flag);
    t=0:T:(n-2)*T;
    figure()
    subplot(2,1,1)
    plot(t,vel(:,1)',t,vel(:,2)',t,vel(:,3)','LineWidth',2)
    legend('x','y','z')
    subplot(2,1,2)
    plot(t,ss(:,1)',t,ss(:,2)',t,ss(:,3)','LineWidth',2)
    legend('x','y','z')
