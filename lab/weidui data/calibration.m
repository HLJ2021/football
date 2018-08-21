clc
clear
for j=2:2
str= strcat ('data', int2str(j) , '_p.csv');
A=importdata(str);
f=100;
% A=importdata('legacy1.csv');
% f=96;
T=1/f;

dataraw=A(:,16:21);
%dataraw=A(:,1:6);
n=size(dataraw,1);
t=0:T:(n-1)*T;
aa=[dataraw(:,1) dataraw(:,2) dataraw(:,3)];
w=[dataraw(:,4) dataraw(:,5) dataraw(:,6)];
for i=1:n
y(i,1)=sqrt(dataraw(i,1)^2+dataraw(i,2)^2+dataraw(i,3)^2);
yw(i,1)=sqrt(dataraw(i,4)^2+dataraw(i,5)^2+dataraw(i,6)^2);
end
    figure()
    ax1=subplot(2,1,1);
    plot(t,aa(:,1)',t,aa(:,2)',t,aa(:,3)',t,y','LineWidth',2)
    legend('x','y','z','total')
    ax2=subplot(2,1,2);
    plot(t,w(:,1)',t,w(:,2)',t,w(:,3)',t,yw','LineWidth',2)
    legend('x','y','z','total')
    filename=strcat('AccelandAngle', int2str(j) , '.fig');
    saveas(gcf,filename);
    cla(ax1)
    cla(ax2)
    
    [th1,th2]=Threshold(y,yw);
for ij=1:n
        %if y(ij,1)>1&&yw(ij,1)>0.8  % 1.5&&0.8   0.8&&0.5
        %if yw(ij,1)>1
        if y(ij,1)>th1&&yw(ij,1)>th2
            flag(ij,1)=0;
        else
            flag(ij,1)=1;
        end
        %if abs(yw(ij)-yw(ij-1))==1
end
%     index1=find(yw>0.05);
%     a=index1(1,1)-60;
%     %a=index1(1,1);
%     b=a+1000;
%     yw=yw(a:b,1);
%     y=y(a:b,1);
%     aa=aa(a:b,:);
%     w=w(a:b,:);
%     flag=flag(a:b,1);
%     n=size(w,1);

    %j=1;
    [vel ss q]=motion(w,aa,yw,flag);
    %[F vel ss q]=motion(w,aa,yw,flag);
    t=0:T:(n-2)*T;
%     filename9=strcat('AttiandPosi', int2str(j) , '.fig');
%      saveas(gcf,filename9);
%      filename6=strcat('AttiandPosi', int2str(j) , '.avi');
%      v=VideoWriter(filename6);
%      v.FrameRate=5;
%      open(v)
%      writeVideo(v,F)
%      close(v)
%      cla(figure(4));

    figure(2)
    ax1=subplot(2,1,1);
    plot(t,vel(:,1)',t,vel(:,2)',t,vel(:,3)','LineWidth',2)
    legend('x','y','z')
    ax2=subplot(2,1,2);
    plot(t,ss(:,1)',t,ss(:,2)',t,ss(:,3)','LineWidth',2)
    legend('x','y','z')
%     filename11=strcat('velandss',int2str(j),'.fig');
%     saveas(gcf,filename11);
%     cla(ax1)
%     cla(ax2)

    figure(5)
     stem3(ss(:,1),ss(:,2),ss(:,3),'LineWidth',2)
     xlabel('x')
     ylabel('y')
     zlabel('z')
%      filename7=strcat('trajectory', int2str(j) , '.fig');
%      saveas(gcf,filename7);
%      cla;
end
